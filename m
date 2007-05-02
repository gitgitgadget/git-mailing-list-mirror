From: "srinivas naga vutukuri" <srinivas.vutukuri@gmail.com>
Subject: Re: problem using git on cygwin
Date: Wed, 2 May 2007 09:34:16 +0530
Message-ID: <ace3f33d0705012104r3cf0b99ayb2ec2a69833e6ea1@mail.gmail.com>
References: <ace3f33d0704292325t6ab16075rbdeac40a437920e8@mail.gmail.com>
	 <Pine.LNX.4.64.0704301343020.29859@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 02 06:04:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hj64j-0007X5-SG
	for gcvg-git@gmane.org; Wed, 02 May 2007 06:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992701AbXEBEES (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 May 2007 00:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992705AbXEBEES
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 00:04:18 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:40863 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992701AbXEBEER (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2007 00:04:17 -0400
Received: by an-out-0708.google.com with SMTP id b33so7091ana
        for <git@vger.kernel.org>; Tue, 01 May 2007 21:04:16 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IaEqf1Ma7KbI/gx0+EuUFbL1mZmTUyeytyYiPybLvCWBPUc4FCV9LSUxIUa6TibVZfkediE6+BdU1Urq0mJINN4bqWe/pwQIKgsFD+ydXHUP+ZaSwzJDshABWtk3cGtkfTDA+4Th/FVUT2PLf+1PoDNkbNNo1Umkh75nibqdnak=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AA2PXUJ4KKtgpWWBg9P86OI059ZAsFBFIZiuYFMdk68g7NjPX8hRb9b1LYuojn62GM6U0AblmqhpWZw4AoyLIy3uKoVVCqdPRYYmRaHpaROaKUoRTXB2/MJtsSqf2fSOiOPEs9Cxmmc5oheQUPEGxBY+m6MJ6ge3b01feUBueG8=
Received: by 10.100.135.16 with SMTP id i16mr120086and.1178078656221;
        Tue, 01 May 2007 21:04:16 -0700 (PDT)
Received: by 10.100.136.12 with HTTP; Tue, 1 May 2007 21:04:16 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0704301343020.29859@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46002>

Hi,

On 4/30/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 30 Apr 2007, srinivas naga vutukuri wrote:
>
> > $ git add project/test.c
> > error: bad index file sha1 signature
> > fatal: index file corrupt
>
> I could imagine that you do not have "binary mode" default for opening
> files.
>

       i do't think it is in binary mode when opening the files. I am
used vim to create a new file and editing through that. And also am
used file format (set ff=unix).


> However, if you do, maybe your .git/index went corrupt?
>
> As a workaround, you could try "git read-tree HEAD" and then "git add"
> again, but make sure you have a backup of .git/index, since it could be a
> bug in Git(cygwin) and if so, I'd like to fix it.
>

     I have taken the initial index (once repository created, after
initial commit) to backup.
and followed the above steps.

1. cp index index.orig
2. git read-tree HEAD
3. git add test.c (my new file)

But end up with the same errors. Would you think there is a bug in the
git working on cygwin ?. I hope would the sequence help you in
catching the bug.



> Ciao,
> Dscho
>
>

best regards,
srinivas.
