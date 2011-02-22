From: Yongqiang Yang <xiaoqiangnk@gmail.com>
Subject: Re: an error when using 'git send-email'
Date: Tue, 22 Feb 2011 21:30:17 +0800
Message-ID: <AANLkTinssKFSqjk5ZCqzjZQWU_vFMDewY+3FSfR+_xMb@mail.gmail.com>
References: <AANLkTiktO_f9+g4+wSS989a=pFZBgWGcORd_kg4pji-x@mail.gmail.com>
	<20110220164427.GA1439@jpl.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Magnus_B=E4ck?= <magnus.back@sonyericsson.com>
X-From: git-owner@vger.kernel.org Tue Feb 22 14:30:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrsJu-00013T-Fj
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 14:30:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752474Ab1BVNaU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 08:30:20 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:43363 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085Ab1BVNaT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Feb 2011 08:30:19 -0500
Received: by eyx24 with SMTP id 24so669451eyx.19
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 05:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KZti9oDiV3MeYIruIAGzbVWvxq0Zk/Tk8Rx2PsbEEZ8=;
        b=Zd56Ox9bsdhiPLw7Tj8WBf9NsiukRZSO4pR4ocBA/Cu8VYe51TbVpQp5+QOD7I43pj
         UgMJy1MlR0TF9LNA4hsjvR0YI/Vvwj9cu4ZBxcNr11HS84p0dvp1ZzwAI8l0ha+KNiHx
         bHqMIKiMIwYV9TvH000Cdn6xHHWqvpZ3MVoeI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gxCp9O3GzcvSfY5F4zyk0ZJv2B+yRPUL3czUYhwGjBnhKDR/Newx+5YFiCdUWikyii
         20JkssNN+RHn+ukpaOTlFaUNYczv8NjfRmpF43Czh+4XUrifzndtXbUUl48BaKfc3KX/
         B3fpbg+8f9ttm9CnIqGmIwBFcEmLyc3S3LkpI=
Received: by 10.14.120.142 with SMTP id p14mr2955587eeh.13.1298381417962; Tue,
 22 Feb 2011 05:30:17 -0800 (PST)
Received: by 10.14.53.80 with HTTP; Tue, 22 Feb 2011 05:30:17 -0800 (PST)
In-Reply-To: <20110220164427.GA1439@jpl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167542>

On Mon, Feb 21, 2011 at 12:44 AM, Magnus B=E4ck
<magnus.back@sonyericsson.com> wrote:
> On Friday, February 18, 2011 at 12:45 CET,
> =A0 =A0 Yongqiang Yang <xiaoqiangnk@gmail.com> wrote:
>
>> When I use git 'send-email', I get an error "Command unknown: =A0'AU=
TH'
>> at /usr/bin/git-send-email line 775, <STDIN> line 1".
>> Is there anyone meet the same error?
>
> You seem to have configured a username and password for SMTP
> authentication, yet the server Git connects to doesn't support
> authentication.
>
> Make sure the SMTP server you've configured Git to use
> (sendemail.smtpserver configuration variable) is the right one.
> If so, clear the smtpemail.smtpuser and smtpemail.smtppass
> variables as you obviously can't use them with the server.
Contents in my .gitconfig file are as follows.
[sendemail]
    smtpencryption =3D tls
    smtpserver =3D smtp.gmail.com
    smtpuser =3D xxxxxxx
    smtpserverport =3D 587

When I remove the line smtpuser.  Git said my config file is not correc=
t.

Thank you.
>
> For testing purposes there are options to "git send-email" to
> override the values set in the configuration files. Those might
> be more convenient to use when testing out new configurations.
>
> --
> Magnus B=E4ck =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Opinions are=
 my own and do not necessarily
> SW Configuration Manager =A0 =A0 =A0 =A0 represent the ones of my emp=
loyer, etc.
> Sony Ericsson
>



--=20
Best Wishes
Yongqiang Yang
