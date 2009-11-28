From: Maximilien Noal <noal.maximilien@gmail.com>
Subject: Re: non-US-ASCII file names (e.g. Hiragana) on Windows
Date: Sun, 29 Nov 2009 00:07:47 +0100
Message-ID: <4B11AD43.3070307@gmail.com>
References: <4B1168D4.5010902@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Singer <thomas.singer@syntevo.com>
X-From: git-owner@vger.kernel.org Sun Nov 29 00:08:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEWOa-0002V8-Nt
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 00:08:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430AbZK1XHp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Nov 2009 18:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751852AbZK1XHp
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Nov 2009 18:07:45 -0500
Received: from mail-ew0-f215.google.com ([209.85.219.215]:34675 "EHLO
	mail-ew0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814AbZK1XHo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Nov 2009 18:07:44 -0500
Received: by ewy7 with SMTP id 7so3058153ewy.28
        for <git@vger.kernel.org>; Sat, 28 Nov 2009 15:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=8w8L/YXMAGEbfOa9L0lG+znZ7ar30Nj4rI0Pn6nVCoM=;
        b=ppiE3PM6blNhnAA6D6nZKUmiiBrsewg4OPQzdp4SuAmyvv+a98vY+xiNTqREq9JCWr
         27M5W2h+sktZ6J7gFXPBeau/sMFBIzl44g93djTskMyJaKDa0qe5u1rV2U7/LjXQJs2N
         y/Ymp8tQbyGEbBUBl/HCGfpeO9yng7MDWcqMo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=QlB+CxefAK/TbUPxVkPNIOutzNhd9kLv59M1R9HKX0gW+QuenJ52u8iSBR+GCAPQbd
         pEttQoFyr+5PukUSRBIqv379FQcasONioiLcPEnvqWrreEB7TspsZI334TJ1Og8RtTwK
         AuNr+i7yH7UJIzVAN+uIV2ks4rPWUZ8plT/Qk=
Received: by 10.213.24.22 with SMTP id t22mr2628743ebb.59.1259449669313;
        Sat, 28 Nov 2009 15:07:49 -0800 (PST)
Received: from ?192.168.1.20? (ABordeaux-257-1-137-155.w90-55.abo.wanadoo.fr [90.55.144.155])
        by mx.google.com with ESMTPS id 13sm1796422ewy.9.2009.11.28.15.07.48
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 28 Nov 2009 15:07:48 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4B1168D4.5010902@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133982>

Thomas Singer a =E9crit :
> I've created a file with unicode characters in its name (using Java):
>=20
>  new File(dir, "\u3041\u3042\u3043\u3044").createNewFile();
>=20
> The file name is stored correctly on disk, because if invoking a
>=20
>  dir.list()
>=20
> the name is listed correctly.
>=20
> When opening this directory in the Windows Explorer (German Windows X=
P SP3),
> it shows 4 boxes - which most likely is a problem of the font not sup=
porting
> these characters.
>=20
> When launching 'git status' from the git shell (msys 1.6.5.1.1367.gcd=
48 from
> 7zip-bundle) it only shows me 4 question marks. I would have expected=
 to see
> the non-displayable characters escaped like it did with the umlauts o=
n OS X.
>=20
> Even adding fails:
>=20
> $ git add .
> fatal: unable to stat '????': No such file or directory
>=20
> What should I do to make Git recognize these characters?
>=20
Hi

About the 'boxes' :

The thing is, Windows' files for Asian languages are _not_ installed by=
=20
default.

They can be installed (even while installing Windows), by checking the=20
two checkboxes under the "Supplemtal languages support" groupbox in the=
=20
"Languages" tab of the "Regional and language options" control panel.=20
*re-take some breath ;-) *

It will remove the "boxes" in Explorer and display nice Asian character=
s.

But that will only fix Windows' files' names display, surely not git=20
(unless I'm mistaken).
