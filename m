From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: How can i find the origin of a branch?
Date: Mon, 15 Jun 2009 14:48:21 +0200
Message-ID: <81b0412b0906150548m69abc1bax785a4743119804c6@mail.gmail.com>
References: <2f3bf9a60906150437v765c2cecva61307ae9cf0cec7@mail.gmail.com>
	 <4A363741.9030604@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Dotan Barak <dotanba@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Kristian Amlie <kristian.amlie@nokia.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 14:48:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGBc2-0000Xv-Ld
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 14:48:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753570AbZFOMsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 08:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756281AbZFOMsV
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 08:48:21 -0400
Received: from mail-fx0-f206.google.com ([209.85.220.206]:55825 "EHLO
	mail-fx0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753108AbZFOMsT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 08:48:19 -0400
Received: by fxm2 with SMTP id 2so253490fxm.37
        for <git@vger.kernel.org>; Mon, 15 Jun 2009 05:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=U8eIFPTY/Sjct9l4X4Rn3xodJgFVqCK/I2fsTRR2zmA=;
        b=ZxHgwHHUgtrMv3ztEuW7sFl0nwGfb6XuY3vAMLEVPqUnRUVnl1Y0bqbJqJWIjD+fH9
         Yeib2xnU5jOntU1fCrok5mvCJfCSj9sZn2HXDehnmTNNsTcxQXidHmo0NLJ0Qa/BYa1a
         Swn2N1OHLKb70siWPc9iHx04BJPdX3opGMHkE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XOlC2yh94ViFPFvT5hYQgC1rHKoGq5jJIZq9/4cheMVjMz+yEfgD3y9C/hTfsc24M5
         TEKHWyVSj7tWQ0LMbdHjasdoU1oyCrnmXk/zyXrwvURKVerBRNfxxZywXWCjLDhmISLz
         8Hu+3Ow/f4MoTjcrq5uRYhOG5sfJKWlaUIuHw=
Received: by 10.204.52.146 with SMTP id i18mr7011684bkg.82.1245070101162; Mon, 
	15 Jun 2009 05:48:21 -0700 (PDT)
In-Reply-To: <4A363741.9030604@nokia.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121603>

2009/6/15 Kristian Amlie <kristian.amlie@nokia.com>:
> ext Dotan Barak wrote:
>>
>> Is it possible to find the origin of a branch?
>> (the remote repository that this branch was cloned and checked out from)
>
> git config -l
>
> Assuming you're on the master branch, branch.master.remote and
> branch.master.merge will tell you which remote and which branch you are
> tracking. Assuming that the remote is origin, you can check
> remote.origin.url to see the URL of the repo.

Except when it is just happen to have the same name.
IOW, it is a BIG oversimplification.
