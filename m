From: Tim Visher <tim.visher@gmail.com>
Subject: Re: git svn teething problems - initial clone okay - fetches not 
	working
Date: Mon, 23 Mar 2009 15:43:15 -0400
Message-ID: <c115fd3c0903231243n1cddf1f1ra88b00ca8db83044@mail.gmail.com>
References: <2BACA6CC2F9647C19C0463120219E694@HPLAPTOP>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Aaron Gray <aaronngray.lists@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 20:45:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llq4p-0001cg-3N
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 20:44:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754625AbZCWTnS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Mar 2009 15:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754369AbZCWTnS
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 15:43:18 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:41113 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753766AbZCWTnR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2009 15:43:17 -0400
Received: by yx-out-2324.google.com with SMTP id 31so2243290yxl.1
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 12:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=o246v0rJK60jud1ftH/wLZaP6YH+i0sgK3I8BbfZDE8=;
        b=jD1aiXsbDkcsqNMI6g5gxB8avpzDSjW5rbsGAl5WgvDX4EHkMKCI741EywZqw0QZhE
         Oaiqs6XdwwGHzCcPZb5jU0G0Hh/VfI3lEJUEtcachM+3XKGHuyzeLqvLS7tk5df9ad0L
         jsSRIjeTay9UUSt4yMzLF85L0dxiM7/w/vbWY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FVdqBs82iJ89Ow2BfFq0q+XBgwYYHJqPR3+d2Ty2VIsN8oEgJpkCsKgh7uO5ZyoU17
         34qpjNdk56eBrOF8PmIdk4lmizTuBQIb+sNUk99bmatioHhS2DO2eFjfeyBtUvpZVNmP
         uOIAf7vAY1D9cY55D67+A3LZpUR+2NFtPHERY=
Received: by 10.100.205.15 with SMTP id c15mr4547598ang.82.1237837395118; Mon, 
	23 Mar 2009 12:43:15 -0700 (PDT)
In-Reply-To: <2BACA6CC2F9647C19C0463120219E694@HPLAPTOP>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114344>

I had a lot of success when I was more actively using `git svn` with
`git svn rebase`.  Just be sure that you're doing your work in local
branches and then merging back into the main trunk branches that are
tracking the svn repo, that way you can always get the latest changes
from your clean trunk branch.

On Mon, Mar 23, 2009 at 3:30 PM, Aaron Gray
<aaronngray.lists@googlemail.com> wrote:
> Hi,
>
> I am a newbie to git, so be warned :)
>
> I have installed git-daemon, and gitweb on an F10 server.
>
> Basically managed to do a 'git svn clone' on LLVM, it took 11 hours !
>
> Anyway I am having the problem that I can do a 'git svn fetch' and I =
see
> changes coming in. But the gitweb and another git clone from it do no=
t
> reflect those changes. The repository is still showing its two days o=
ld.
>
> I am obviously missing something. The only documentation I could find=
 on
> 'git svn' was the command line help and 'man git-svn'.
>
> Hope you can help,
>
> Aaron
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>



--=20

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
