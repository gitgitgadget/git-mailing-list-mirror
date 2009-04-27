From: Constantine Plotnikov <constantine.plotnikov@gmail.com>
Subject: Re: [JGIT PATCH] Added support for creating bare repositories
Date: Mon, 27 Apr 2009 16:46:03 +0400
Message-ID: <85647ef50904270546w41692a50j84cc898a264998ba@mail.gmail.com>
References: <1240587417-3732-1-git-send-email-constantine.plotnikov@gmail.com>
	 <200904270029.56939.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: spearce@spearce.org, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 14:46:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyQE4-0006Ha-1h
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 14:46:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122AbZD0MqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 08:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753851AbZD0MqI
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 08:46:08 -0400
Received: from mail-bw0-f163.google.com ([209.85.218.163]:35848 "EHLO
	mail-bw0-f163.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753122AbZD0MqG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 08:46:06 -0400
Received: by bwz7 with SMTP id 7so2262639bwz.37
        for <git@vger.kernel.org>; Mon, 27 Apr 2009 05:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GTjvX/ttZzxk6tj3+4Wv3QyQTtTaH3oMs6NPaoiZQcI=;
        b=FOAoCn1K6KNdF146K/HhrZb9OmTGr2KBh9UDSENY6RCF1bfkpplRqqP4Adk1uA6CGr
         2plgneiy8C0hNiFejsaFcFhdch81VUHySG37eCkjmaPfPl/vxW1u0zZK8ol45PlCXPWe
         vx9g1Utn1PaxBZ0/1xGEIKYgmuxrUCZmA7Kp0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bHxzMdZA/5ksGpxkBTc6a69JRs4qsR8vC42ych7HsJ7xsKU9w5Yao/vaiRIErSGpwB
         CJu2wEB+fOPAKvDSjGoXibQuhoW+y37J5dWHafszU9n8E9VkXNwRhRU0AdnQNBy+Zhn9
         NX1O/Dk1QnnWF5CvhZtytlwc2Fsr+xDnp2G5c=
Received: by 10.204.56.4 with SMTP id w4mr5287718bkg.17.1240836363208; Mon, 27 
	Apr 2009 05:46:03 -0700 (PDT)
In-Reply-To: <200904270029.56939.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117668>

On Mon, Apr 27, 2009 at 2:29 AM, Robin Rosenberg
<robin.rosenberg.lists@dewire.com> wrote:
> fredag 24 april 2009 17:36:57 skrev Constantine Plotnikov <constantine.plotnikov@gmail.com>:
>> Now it is possible to create bare repositories.
>> The difference from normal repository creation is
>> that directory where repository is created might
>> exists and that core.bare property is set to true.
>
> I know C Git doesn't check if a directory is a non-bare repo, but I think
> that's wrong, so if I try to create a bare repo in a non-bare repo that
> should be an error. For now I'll accept it anyway since the C version allows
> it and it is useful.
>
I'm not sure that this should be an error. We have a bare git
repository with a test data inside the non-bare repository. And such
feature might be nice to have to other git related tools as well. %)

Constantine
