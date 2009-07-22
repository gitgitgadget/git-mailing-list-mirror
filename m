From: "seth's list" <srlytle.list@gmail.com>
Subject: Re: push fails -- temporary sha1, no such file / corruptiion ???
Date: Wed, 22 Jul 2009 13:55:14 -0400
Message-ID: <5656c890907221055s69416174h81a76902156b6f45@mail.gmail.com>
References: <1248229319591-3297467.post@n2.nabble.com>
	 <be6fef0d0907220004n70c583f9u1852871df7686ed1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 19:55:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTg2P-0001ld-A0
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 19:55:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754077AbZGVRzQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Jul 2009 13:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753944AbZGVRzQ
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 13:55:16 -0400
Received: from mail-yx0-f197.google.com ([209.85.210.197]:49809 "EHLO
	mail-yx0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752878AbZGVRzP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jul 2009 13:55:15 -0400
Received: by yxe35 with SMTP id 35so584390yxe.33
        for <git@vger.kernel.org>; Wed, 22 Jul 2009 10:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=D+wd5r12fd3e+U0eL0pQ8g6fHY02i05B6P02gtwGSeM=;
        b=sRRlhnb4DXmzWaV5yIHjJn2zula8bOO8h6dOsrJyW/swnYGlY4Q1HknnGaTTxsTcer
         SOUvOYEgpZQ3MJianh3WKN4YIcgUdqNz9XhKodLFbnTomrjULSRAqE1kA6U1aUvE0N57
         LcLJzAQxcA0sltCG4kZtLCwtd8TQ+IjK51P6o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=iD3Xjx8gzEXYxhbs+fWHAMgOIb50+Pkj+Y4qQTtE9yc/ZxRMor185ItfT1iCM5w3mB
         vOdZ2Pr52hNUMoPAx32guK+IEuc/z7AqCa66njX7HvOfWum4FDJlZJxDNiq/DH3PbaBa
         QbsO+HUGqKIuDl14IQW8kbI7Qzkr3pZE+zHr8=
Received: by 10.150.92.8 with SMTP id p8mr1326567ybb.63.1248285314344; Wed, 22 
	Jul 2009 10:55:14 -0700 (PDT)
In-Reply-To: <be6fef0d0907220004n70c583f9u1852871df7686ed1@mail.gmail.com>
X-Google-Sender-Auth: 0a4d92051e7e4e33
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123761>

(sorry for the dup Tay)

the permissions look ok to me. what should they be ?

drwxr-xr-x 8 lytles lytles=A0=A0=A0=A0 4096 2009-07-21 20:06 .
drwxr-xr-x 4 lytles lytles=A0=A0=A0=A0 4096 2009-07-21 20:06 objects/
-rw-r--r-- 2 lytles lytles=A0=A0=A0=A0=A0=A0 54 2009-07-21 20:06 object=
s/info/packs
drwxr-xr-x 2 lytles lytles=A0=A0=A0=A0 4096 2009-07-21 20:06 objects/pa=
ck
-r--r--r-- 2 lytles lytles=A0=A0=A0 18208 2009-07-21 20:06 objects/pack=
/pack-
9f4893584105c3f5b62cb9ff05e3d4d1f495a9f8.idx
-r--r--r-- 2 lytles lytles 34209770 2009-07-21 20:06
objects/pack/pack-9f4893584105c3f5b62cb9ff05e3d4d1f495a9f8.pack



any other thoughts on what caused the errors / corruption ?

On Wed, Jul 22, 2009 at 3:04 AM, Tay Ray Chuan <rctay89@gmail.com> wrot=
e:
>
> Hi,
>
> On Wed, Jul 22, 2009 at 10:21 AM, lytles<srlytle.list@gmail.com> wrot=
e:
> > the "object/2f" varies with attempts to push from different remote =
repos,
> > but it's always an "object/??". multiple attempts to push from the =
same
> > remote repo always results in the same "object/??"
>
> have you checked the permissions on your remote repo, particularly th=
e
> objects/ directory?
>
> This is just a shot in the dark. I used to have pushes failing due to
> stricter permissions on the remote side.
>
> --
> Cheers,
> Ray Chuan
