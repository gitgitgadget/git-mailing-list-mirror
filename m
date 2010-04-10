From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v9] Documentation/remote-helpers: Add invocation section
Date: Sat, 10 Apr 2010 17:54:26 +0530
Message-ID: <z2tf3271551004100524w9b8cf62ck7e889f87b7f2cb8e@mail.gmail.com>
References: <g2vf3271551004062257ycbda64d3z3d3004d802a03fc3@mail.gmail.com> 
	<7vsk77e20r.fsf@alter.siamese.dyndns.org> <n2nf3271551004070950ucf314b40g56087d49dfbd29f1@mail.gmail.com> 
	<20100407224942.GA20239@progeny.tock> <7vzl1eamss.fsf@alter.siamese.dyndns.org> 
	<x2of3271551004072154r62d10023r32e74064d38aff75@mail.gmail.com> 
	<7vk4si8r02.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 10 14:25:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0ZkH-0004f6-Ql
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 14:25:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341Ab0DJMYs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Apr 2010 08:24:48 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:56148 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948Ab0DJMYr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Apr 2010 08:24:47 -0400
Received: by gyg13 with SMTP id 13so2082777gyg.19
        for <git@vger.kernel.org>; Sat, 10 Apr 2010 05:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=qartPNX+WW+VsVc6wGRGcNvlv0MFLukRCw07c2iv30A=;
        b=qJ7cRz10njc5uzomSvr1RLB3KRITy3jhGgstN4CAstLcb2dQhTgOVmDtCyLita8lL5
         ZOSOobNsWMfLkYnttvis9uHa9AuAMGrcf4c/tnfcC+IRVBxc+AiR8To5J0qMurPIhTaY
         a9s7cQFf9xVkbjh5LBMoHpxfsUzuclkiW4VSs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=vt0A29AFN08KKooOOu4mwJrHPETebYhkbNfUsIBtEQwDkL3ArL+zuuYheo1XVWPsMc
         OivMHEnZGYRTWXJ6VjpydTZBIkBJ3RK3+tub3kZVnkzpqKpr/nJqvvTMECUsFYPbkQ0O
         gL4I+N6zyaso1ufaX1m86eN+6L1xV+HeblQ9g=
Received: by 10.90.69.14 with HTTP; Sat, 10 Apr 2010 05:24:26 -0700 (PDT)
In-Reply-To: <7vk4si8r02.fsf@alter.siamese.dyndns.org>
Received: by 10.90.6.22 with SMTP id 22mr620183agf.70.1270902286106; Sat, 10 
	Apr 2010 05:24:46 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144542>

Hi,

> =C2=A0 =C2=A0$ git log --first-parent --oneline origin/master..origin=
/pu
>
> and find "Merge branch 'rr/remote-helper-doc'" in the output. =C2=A0T=
he second
> parent of that merge commit (e.g. 6144af5^2 =3D=3D ad466d1) is the ti=
p of your
> topic. =C2=A0You can verify it with:
>
> =C2=A0 =C2=A0$ git log -p origin/master..ad466d1
> =C2=A0 =C2=A0$ git checkout -b remote-helper-doc ad466d1
> =C2=A0 =C2=A0... build further on it ...

Thanks for the excellent instructions. I'm just curious: why didn't
you include these instructions in your rewrite of SubmittingPatches?

-- Ram
