From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH] tg-graph: print dependency graph like git log 
	--graph
Date: Tue, 19 May 2009 13:47:39 +0200
Message-ID: <36ca99e90905190447u19d7cd19re8932f8f3aadefb2@mail.gmail.com>
References: <1242711875-25666-1-git-send-email-bert.wesarg@googlemail.com>
	 <20090519102742.GA28702@noris.de>
	 <36ca99e90905190337y63aeb98ag59ff37688f75ba96@mail.gmail.com>
	 <20090519110800.GB28702@noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	Adam Simpkins <adam@adamsimpkins.net>
To: Michael Radziej <mir@noris.de>
X-From: git-owner@vger.kernel.org Tue May 19 13:47:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6NnT-0006p1-VU
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 13:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020AbZESLrn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 07:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbZESLrm
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 07:47:42 -0400
Received: from mail-bw0-f174.google.com ([209.85.218.174]:64610 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbZESLrm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 07:47:42 -0400
Received: by bwz22 with SMTP id 22so3766779bwz.37
        for <git@vger.kernel.org>; Tue, 19 May 2009 04:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pKFrHeBkrn6IkOZVjR+rUg8yxuDR8q3OTxHqn7luhF0=;
        b=ep8tac0GUkAPDu8pIgFvhk1nzbB9APSxlyP0+KCrI5VXR1hk0VU6OiZDJG+mAWlA2e
         SbuomN+qrO2f+G9QuDPHLNoVlBWfQ1HB5kvCMoJQ313yMNxbX9Zgbg4+PE3n4vfYL+JP
         mMFvjxEwEznJx80F+aewM/y+7oRLAbKS6Ltfc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Q2lK7uuQFuT8eAPbAtW5k8rrXbnLeIBo8Ev88hW/KvPsXsvjY3MovK+UItnRvhUqQZ
         rEAtjDHJU8HWMIZkY3zFSsd5toZAUZRMhXlOlM0ZYQ5437GKMVfTkoenjZdnNihf5xPk
         ULgfhXgNTAaRByB9LiCai3jVyPm6hegvDUD20=
Received: by 10.223.126.145 with SMTP id c17mr5057931fas.16.1242733661388; 
	Tue, 19 May 2009 04:47:41 -0700 (PDT)
In-Reply-To: <20090519110800.GB28702@noris.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119519>

On Tue, May 19, 2009 at 13:08, Michael Radziej <mir@noris.de> wrote:
> On Tue, May 19, Bert Wesarg wrote:
>
>> No, it works here. Which version of graphviz do you have?
>
> I tried two versions on debian:
>
> 2.8-3+etch1 (debian etch)
> 2.20.2-3~bpo40+1 (debian etch-backports)
>
> I also tried it on a different host running Ubuntu with
> 2.16-3ubuntu2
>
> Which one did you use?
The 2.20.2 one.

And you see the error with all 3?

Can you send the output from 'tg summary --graphviz' too?

Bert
>
> Michael
