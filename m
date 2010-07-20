From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [http] Git error messages reveal password encoded in the URL
Date: Tue, 20 Jul 2010 15:46:18 +0800
Message-ID: <AANLkTilYeKkJlUaB7zRgvIR_OyzrabWG1iPLbmrvkAqu@mail.gmail.com>
References: <4C4484A4.5010009@gmail.com>
	<AANLkTilby7GWOuObh6W4z_caUG83O5A5Wh4Wb-JJnSdJ@mail.gmail.com>
	<4C44DEF7.4000903@gmail.com>
	<201007200241.46972.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ketan Padegaonkar <ketanpadegaonkar@gmail.com>,
	Jacob Helwig <jacob.helwig@gmail.com>,
	git-dev <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 20 09:46:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ob7X2-0006PU-QU
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 09:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752375Ab0GTHqX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jul 2010 03:46:23 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61788 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160Ab0GTHqW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jul 2010 03:46:22 -0400
Received: by iwn7 with SMTP id 7so5513804iwn.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 00:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Ziz6Toge1MWhRSGpASxICsJOcB8gNgFYifHodj7zjy8=;
        b=iuJXIZhD2m/HraJqmcWQ+6JccEFg2CzCpoeLOPNzjDwKhTkk1GPwTVWIZKaiQ+xKKk
         YozKQYKES/SSUohzX37MLkbJqnXQ90svlQmWBE619W+c8HhWuYGFBE1EsD3IrUggt0lP
         iVeMje4GPr5diu+NPdO5yyc7w7VgLbQjSlLl4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=aHCe8w5L4oU4PVVsBoocSiyVi+ctd5hqgjFPUMBaHBeLQMOjB6LwbFQdjkK9S3mHys
         WY0c/NGg6PMscchG5OOua+wE4tET1bSmQEuBYo1M3BPYCYVPvTe28iwidipZ71587l7X
         bSJryv5Nvt92Q7Zra4MGqkWNCnLpTykT99bG8=
Received: by 10.231.192.67 with SMTP id dp3mr6847588ibb.180.1279611978438; 
	Tue, 20 Jul 2010 00:46:18 -0700 (PDT)
Received: by 10.231.153.12 with HTTP; Tue, 20 Jul 2010 00:46:18 -0700 (PDT)
In-Reply-To: <201007200241.46972.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151307>

Hi:

On Tue, Jul 20, 2010 at 8:41 AM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> Dnia wtorek 20. lipca 2010 01:25, Ketan Padegaonkar napisa=C5=82:
[snip]
> Can't you use ~/.netrc file[1] instead? =C2=A0As far as I see this wo=
uld not
> show password info on error. =C2=A0Not that the current situation sho=
uld
> not be fixed, but it might be worthwhile workaround for a time.
>
> The ~/.netrc file would look like this for your example:
>
> =C2=A0machine host
> =C2=A0login user
> =C2=A0password pass
>
> You should of course `chmod 600 ~/.netrc`
>
> [1] This is unfortunately underdocumented: only this documentation
> Documentation/howto/setup-git-server-over-http.txt mentions ~/.netrc
> file. =C2=A0I think that handling the $HOME/.netrc is done by the cur=
l
> library that git uses, see libcurl-tutorial(3) manpage.

+1

This is the only way I know of to "hide" your password.

Of course, depending on your authentication scheme, your efforts for
this setup may prove worthless.

--=20
Cheers,
Ray Chuan
