From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2013, #07; Thu, 20)
Date: Sat, 22 Jun 2013 00:19:10 +0530
Message-ID: <CALkWK0kpp7xzUZsMMsib1HPsi+DzkGqwhPnYvKpEEQZ5orv7zA@mail.gmail.com>
References: <7v1u7woydw.fsf@alter.siamese.dyndns.org> <CALkWK0=1e5ospzJBqaz9iLwSiOoTy_+vTxwVMvW-H7kynfkbBg@mail.gmail.com>
 <7vk3lno40x.fsf@alter.siamese.dyndns.org> <CALkWK0kDDRicX9VmcRgG9daXVi6W-zGNt=x6ruy7X5MhrHOZbQ@mail.gmail.com>
 <7vtxkrmlz5.fsf@alter.siamese.dyndns.org> <CALkWK0mUcJ1f0xP2w-fUFr-tMSKMX23_nmYQUYXw3zjw7Hm9GQ@mail.gmail.com>
 <7vehbvmib8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 21 20:50:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq6PQ-0002eO-HR
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 20:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423714Ab3FUSty convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Jun 2013 14:49:54 -0400
Received: from mail-bk0-f44.google.com ([209.85.214.44]:39227 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423690Ab3FUStw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Jun 2013 14:49:52 -0400
Received: by mail-bk0-f44.google.com with SMTP id r7so3549411bkg.17
        for <git@vger.kernel.org>; Fri, 21 Jun 2013 11:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=zxFf+2wXl0VUOjVKMG/TwPJtJSq2pK9WtzIBgiT6Hr8=;
        b=Xiqx9yGzGnYqTsULuy4C9r3paB7JfomtxOd1uQpSSORNu6htQSSVgS5EAb8kqSDuNr
         bDXdhnJpEKwJrd7eQBVTjJdtX8GqwIxTwuhg4Z2Ku7dcOh50nm72Tn1TmBA3w51ARHFS
         2zid1o8BhjH9N8lyvqIvcCfOt2h7+EOOqYfBcxDMmgjE/b9V4G7YqjHSllF7gi3nPAyx
         lKnDiGGBbs4xd6KXtkqeT6/0c0KoZgSEAveSe2yYrikYiBVk86lSNvtKCf65PASjY20i
         DBZqPxcOHHK7AAFd3UgpDPjAA5UxFPX6T4zbFexHdRaFqzwX8rGq3o8SYZRX8C04BSYa
         h0CQ==
X-Received: by 10.204.233.16 with SMTP id jw16mr2011008bkb.82.1371840591050;
 Fri, 21 Jun 2013 11:49:51 -0700 (PDT)
Received: by 10.204.186.77 with HTTP; Fri, 21 Jun 2013 11:49:10 -0700 (PDT)
In-Reply-To: <7vehbvmib8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228651>

Junio C Hamano wrote:
> Unfortunately, I tend to become bottleneck more often than you do,
> so I do not think that would be a good use of my time.

Besides, as Antoine points out, those numbers might well be useless
(or worse, misleading).  It's probably not worth the effort.

> Which ones went unreviewed that are of high value?

My observation can be boiled down to: I usually never get the
opportunity to say something useful on most patches, because someone
else already has; that has not been the case offlate.  Probably some
bias: I tried looking for examples and counter-examples, but the list
is too large for individual patches to make any sense.

I did run a script on git.git to see if there are any recent trends:
if I'm right about patches not being reviewed, it must ultimately show
up somewhere, right?

v1.7.0..v1.7.1:: 702
 jc (68), jn (50), jh (32), tr (22), jk (19), tr (19), mj (18), sb
(15), bc (11), jl (10)
v1.7.1..v1.7.2:: 772
 jc (57), jn (56), =C3=86a (32), mj (26), jk (21), tr (20), bc (19), gv
(18), jn (18), cc (17)
v1.7.2..v1.7.3:: 624
 jn (117), =C3=86a (64), jc (28), mm (23), nt (23), en (18), bc (17), t=
r
(17), js (15), jl (12)
v1.7.3..v1.7.4:: 1025
 jn (89), nt (68), jc (59), en (54), jk (27), mj (26), =C3=86a (25), ef
(23), jh (23), ra (20)
v1.7.4..v1.7.5:: 734
 jn (90), =C3=86a (79), jc (64), mj (40), jk (38), nt (31), bw (16), hv
(13), pw (12), jl (10)
v1.7.5..v1.7.6:: 650
 jc (112), jk (51), mv (35), jn (28), jn (20), mj (16), jh (15), =C3=86=
a
(12), mk (11), jm (9)
v1.7.6..v1.7.7:: 779
 jc (105), jk (60), en (55), =C3=86a (48), mh (44), js (19), di (16), j=
n
(16), sr (15), tr (15)
v1.7.7..v1.7.8:: 644
 jc (85), mh (37), jk (31), rs (26), rr (23), jn (18), nt (15), bc
(13), mj (10), ra (9)
v1.7.8..v1.7.9:: 565
 jc (82), jk (62), nt (24), mh (23), pw (18), jn (16), tr (15), bw
(14), mv (11), pt (11)
v1.7.9..v1.7.10:: 683
 jc (84), jk (40), jn (27), nt (25), tr (21), jn (18), jx (15), zj
(15), mh (13), th (11)
v1.7.10..v1.7.11:: 925
 jc (92), ap (73), jk (69), nt (39), rs (38), mh (37), jn (25), jx
(19), rt (17), zj (17)
v1.7.11..v1.7.12:: 548
 jc (107), jk (51), mm (29), jx (15), mg (14), nt (14), pw (13), jn
(12), as (7), cw (7)
v1.8.0..v1.8.1:: 525
 jc (55), jk (41), fc (32), nt (19), fa (15), mh (12), km (11), ta
(11), mo (10), rr (9)
v1.8.1..v1.8.2:: 957
 jc (107), nt (53), jk (39), pw (35), jk (33), as (31), mh (31), fc
(26), mv (23), wt (17)
v1.8.2..v1.8.3:: 1005
 fc (112), jc (95), jk (89), nt (35), jk (29), da (26), rr (24), tr
(18), bc (15), jn (15)
v1.8.3..master:: 497
 fc (112), mh (60), rr (24), jc (23), rs (21), tr (18), kb (15), js
(13), ra (12), nt (11)

Meh, it looks normal.  Sorry for the noise: I don't think there's any
cause for worry.
