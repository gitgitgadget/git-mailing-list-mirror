From: Yongqiang Yang <xiaoqiangnk@gmail.com>
Subject: Re: an error when using 'git send-email'
Date: Sun, 20 Feb 2011 20:10:47 +0800
Message-ID: <AANLkTi=1dJ=jZ6KS4CTtyatZJBZ7-kz6vku2ztcYO5V_@mail.gmail.com>
References: <AANLkTiktO_f9+g4+wSS989a=pFZBgWGcORd_kg4pji-x@mail.gmail.com>
	<vpq7hcxsb77.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Feb 20 13:10:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pr87s-0000mt-6k
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 13:10:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753779Ab1BTMKu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Feb 2011 07:10:50 -0500
Received: from mail-ey0-f180.google.com ([209.85.215.180]:53481 "EHLO
	mail-ey0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268Ab1BTMKt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Feb 2011 07:10:49 -0500
Received: by eyf18 with SMTP id 18so2248629eyf.11
        for <git@vger.kernel.org>; Sun, 20 Feb 2011 04:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zJUJKlBtU7pqF87z4Tc/WhmCMtjTTS+ECK2mqPQvocI=;
        b=FGN6DSYYt/r//ng41LlpA9UI64dA0M8UY8fnX94+bCJ6eKvN4gho0gyLyzCKGwYB3B
         S/LAJoBT3cTlpQ4dCW2EWUL/C5ZjdyVfyjI/64jcY0umdiHj/PJa0ciIzz7uxErXQmtx
         rMasMWWsk+0NYF79F3eaZWkqthZbDqVTx90E8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DfroGNO/ljW1Gg0il+TlbCF/lZG7q0MASVwKNiLXART87iIIAWabZBr8rqpb97wPxX
         ebwGII1lDRXwBSUTDJseNjAFS9q7UC7pie3Ynfos+vLHlglN2jOSuQKK+itH/p1Es4ln
         L/fKrlQYO0GrXOmG12wSHhWontDHPzdy4m3Gg=
Received: by 10.14.48.78 with SMTP id u54mr319058eeb.34.1298203847042; Sun, 20
 Feb 2011 04:10:47 -0800 (PST)
Received: by 10.14.53.80 with HTTP; Sun, 20 Feb 2011 04:10:47 -0800 (PST)
In-Reply-To: <vpq7hcxsb77.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167420>

On Fri, Feb 18, 2011 at 9:51 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
>
> Yongqiang Yang <xiaoqiangnk@gmail.com> writes:
>
> > Hello All,
> >
> > When I use git 'send-email', I get an error "Command unknown: =A0'A=
UTH'
> > at /usr/bin/git-send-email line 775, <STDIN> line 1".
> > Is there anyone meet the same error?
>
> Not me.
>
> Can you give the exact command you're using? Which OS? Which Git
> version? If possible, tell us what's on line 775 of
> /usr/bin/git-send-email
The commad I used was 'git send-email --to xiaoqiangnk@gmail.com --cc
xxx@xx.xx xxx.patch'.
My OS is debian with linux version  2.6.37-rc2 and git version is 1.5.6=
=2E5.

On line 775 of /usr/bin/git-send-email is ' $auth ||=3D $smtp->auth(
$smtp_authuser, $smtp_authpass ) or die $smtp->message;'


Thank you.
Yongqiang.
>
> --
> Matthieu Moy
> http://www-verimag.imag.fr/~moy/



--
Best Wishes
Yongqiang Yang
