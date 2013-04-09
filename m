From: jk@blackdown.de (=?utf-8?Q?J=C3=BCrgen?= Kreileder)
Subject: Re: [PATCH 2/4] gitweb: Make feed title valid utf8
Date: Tue, 09 Apr 2013 21:22:03 +0200
Message-ID: <m2ip3va4ro.fsf@zahir.fritz.box>
References: <m2y5csbx91.fsf@blackdown.de> <51642F67.5010501@gmail.com>
	<m2r4ija9gh.fsf@zahir.fritz.box> <51645D99.6000106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 21:22:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPe7t-0002gD-KG
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 21:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761556Ab3DITWh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Apr 2013 15:22:37 -0400
Received: from mail-bk0-f51.google.com ([209.85.214.51]:33686 "EHLO
	mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759304Ab3DITWg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Apr 2013 15:22:36 -0400
Received: by mail-bk0-f51.google.com with SMTP id y8so3805177bkt.38
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 12:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackdown.de; s=google;
        h=x-received:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=GaY8qnmSyrEkrhxr4Fq4Sww5bJiy9qxWiRKMHPpv5oM=;
        b=DQ8cxVeBc7918x7SmNSepwc+HHfTsyxu4Zfn4+bMQSrQp0IWuovklSij3uvNUUOGNl
         atCXo0M6PRkRpmzjWQ/PZk/znMBy3pJxgdTGhCCi8ZahOnELNLbQ4rDYXgLxzgPnjs6I
         pDs/OBv6sQ3381ak3d6WANoQWasNkNtBThXUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=GaY8qnmSyrEkrhxr4Fq4Sww5bJiy9qxWiRKMHPpv5oM=;
        b=OlR7mmh8sV+SwYCCSrFc8JFH12D2w1ZzHNS20bCWyvF2EK4fJOA8Yo0uvOPA/LyE/H
         28+U2xZ6u/WKfPKEbzPhZOIU65iJWjfVlfRZ/L2Nsd0+YTMqi4yDqk0A4JRF8H5aK/Oa
         Y9k8sEUcn4FEAC7i2P3TCBkRvIU16rCguoxKY94G7KutRv0Z7RlfJT3xBwUtdURdz+0l
         xDhWbnFlVHjfBocQZv7lj3DVa+em4XLgjNn0dsL44yZxJC+CTQbla43mSq7XUj7juL/q
         2VXJYQmGv7kj+L2XjTLxyyYgpSKpEa80arXWuipQotVcQrxl08EBpNstD3+eDtUHtrwU
         uV1g==
X-Received: by 10.204.162.8 with SMTP id t8mr13247048bkx.95.1365535354942;
        Tue, 09 Apr 2013 12:22:34 -0700 (PDT)
Received: from zahir.fritz.box (p20030056CF2E81009227E4FFFEF3FF5E.dip.t-dialin.net. [2003:56:cf2e:8100:9227:e4ff:fef3:ff5e])
        by mx.google.com with ESMTPS id uo3sm4425984bkb.11.2013.04.09.12.22.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Apr 2013 12:22:33 -0700 (PDT)
In-Reply-To: <51645D99.6000106@gmail.com> ("Jakub \=\?utf-8\?Q\?Nar\=C4\=99bski\?\=
 \=\?utf-8\?Q\?\=22's\?\= message of "Tue,
	09 Apr 2013 20:27:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3.50 (darwin)
X-Gm-Message-State: ALoCoQnA8yG1bO59ZipH6ZSIWOxoV0cO1lNKWpJuzdP3DT3gLxRZmFRQmSAkQ1dGDupzAaPAcMUF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220620>

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> W dniu 09.04.2013 19:40, J=C3=BCrgen Kreileder napisa=C5=82:
>> Jakub Nar=C4=99bski <jnareb@gmail.com> writes:
>>> J=C3=BCrgen Kreileder wrote:
>>>
>>>> Properly encode site and project names for RSS and Atom feeds.
>
>>>> -	my $title =3D "$site_name - $project/$action";
>>>> +	my $title =3D to_utf8($site_name) . " - " . to_utf8($project) . =
"/$action";
>
>>> Was this patch triggered by some bug?
>>=20
>> Yes, I actually see broken encoding with the old code, e.g on=20
>> https://git.blackdown.de/old.cgi?p=3Dcontactalbum.git;a=3Drss
>> my first name is messed up in the title tag.
>>=20
>> New version: https://git.blackdown.de/?p=3Dcontactalbum.git;a=3Drss
>>=20
>>> Because the above is not necessary, as git_feed() has
>>>
>>> 	$title =3D esc_html($title);
>>>
>>> a bit later, which does to_utf8() internally.
>>=20
>> Good point.  But it doesn't fix the string in question:
>> It looks like to_utf8("$a $b") !=3D (to_utf8($a) . " " . to_utf8($b)=
).
>
> Strange.  I wonder if the bug is in our to_utf8() implementation,
> or in Encode, or in Perl... and whether this bug can be triggered
> anywhere else in gitweb.

I don't think it's a bug, more like a consequence of concatenating utf8
and non-utf8 strings:

    my $a =3D "=C3=BC";
    my $b =3D "=C3=BC";
    my $c =3D "$a - $b";
    print "$c -> ". to_utf8($c) . ": " . (utf8::is_utf8($c) ? "utf8" : =
"not utf8") . "\n"; # GOOD
    $b =3D to_utf8($b);
    $c =3D "$a - $b";
    print "$c -> ". to_utf8($c) . ": " . (utf8::is_utf8($c) ? "utf8" : =
"not utf8") . "\n"; # GOOD

yields (hopefully the broken encoding shows up correctly here):

    =C3=83=C2=BC - =C3=83=C2=BC -> =C3=BC - =C3=BC: not utf8
    =C3=83=C2=BC - =C3=BC -> =C3=83=C2=BC - =C3=BC: utf8


In gitweb we have the bad case:=20

   my $title =3D "$site_name - $project/$action";

$project and $action are apparently utf8 already but $site_name isn't.
The resulting string is marked as utf8 - although the encoding of
$site_name was never fixed.  The to_utf8() in esc_html() returns the st=
ring
without fixing anything because of that.

> What Perl version and Encode module version do you use?

5.14.2 and 2.42_01 on Ubuntu.  Same results with 5.12.4 and 2.39 on OS =
X.


       Juergen
