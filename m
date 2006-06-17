From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: parsecvs and unnamed branches
Date: Fri, 16 Jun 2006 23:02:05 -0400
Message-ID: <9e4733910606162002x508ec6ccjbc36e4220ca44fd6@mail.gmail.com>
References: <9e4733910606161444i2f996096sbd1f9b3f3ff3a32d@mail.gmail.com>
	 <1150496362.6983.34.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 17 05:02:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrR4s-0001TL-DG
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 05:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583AbWFQDCK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 23:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751593AbWFQDCK
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 23:02:10 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:57288 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751583AbWFQDCG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jun 2006 23:02:06 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1281902nze
        for <git@vger.kernel.org>; Fri, 16 Jun 2006 20:02:05 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SweoLaQWrIdE5kfCsw34vnt+acp0Ai8BBRwpMpJSZ6kQqj+VUxQw6BRVBOuQNKSgUIViqUj2GlvMZsdJRDl08OCmY+LsEKxOJZO6k9TfNHDgLPeWcivNMdAd8WQ1K1wzwjD6L6lJ4Aj9Xnyj7OtM+mYkkbKnvXClY3x98iy71Rs=
Received: by 10.36.38.13 with SMTP id l13mr1232353nzl;
        Fri, 16 Jun 2006 20:02:05 -0700 (PDT)
Received: by 10.36.36.7 with HTTP; Fri, 16 Jun 2006 20:02:05 -0700 (PDT)
To: "Keith Packard" <keithp@keithp.com>
In-Reply-To: <1150496362.6983.34.camel@neko.keithp.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21994>

My parsecvs job died after 5 hours of CPU time. Does this tell you anything?

Pack pack-e28915a5ea09143a9139e84e24534ed888bf1c45 created

Error: branch cycle
*** glibc detected *** parsecvs: munmap_chunk(): invalid pointer: 0x0a820198 ***
*** glibc detected *** parsecvs: corrupted double-linked list: 0x45b1e158 ***
======= Backtrace: =========
/lib/libc.so.6[0x45a502c6]
/lib/libc.so.6[0x45a5235a]
/lib/libc.so.6(calloc+0x8d)[0x45a539a1]
/lib/ld-linux.so.2[0x459db1ba]
/lib/ld-linux.so.2[0x459d6f8a]
/lib/ld-linux.so.2[0x459d91e1]
/lib/ld-linux.so.2[0x459e2204]
/lib/ld-linux.so.2[0x459de7b9]
/lib/ld-linux.so.2[0x459e1d0a]
/lib/libc.so.6[0x45ae9c3e]
/lib/ld-linux.so.2[0x459de7b9]
/lib/libc.so.6(__libc_dlopen_mode+0x55)[0x45ae9dc9]
/lib/libc.so.6[0x45ac90f6]
/lib/libc.so.6(backtrace+0x109)[0x45ac9295]
/lib/libc.so.6[0x45a4aa61]
/lib/libc.so.6(__libc_free+0x179)[0x45a554f0]
parsecvs[0x804dec8]
parsecvs[0x804df1e]
parsecvs[0x804ccce]
/lib/libc.so.6(__libc_start_main+0xdc)[0x45a03724]
parsecvs[0x8049cc1]
======= Memory map: ========
08048000-08065000 r-xp 00000000 09:01 4052384
/home/jonsmirl/workspace/parsecvs/parsecvs
08065000-08067000 rw-p 0001c000 09:01 4052384
/home/jonsmirl/workspace/parsecvs/parsecvs
08067000-459c9000 rw-p 08067000 00:00 0          [heap]
459d1000-459ea000 r-xp 00000000 03:06 4243239    /lib/ld-2.4.so
459ea000-459eb000 r--p 00018000 03:06 4243239    /lib/ld-2.4.so
459eb000-459ec000 rw-p 00019000 03:06 4243239    /lib/ld-2.4.so
459ee000-45b1b000 r-xp 00000000 03:06 4243241    /lib/libc-2.4.so
45b1b000-45b1d000 r--p 0012d000 03:06 4243241    /lib/libc-2.4.so
45b1d000-45b1e000 rw-p 0012f000 03:06 4243241    /lib/libc-2.4.so
45b1e000-45b21000 rw-p 45b1e000 00:00 0
45b23000-45b25000 r-xp 00000000 03:06 4243258    /lib/libdl-2.4.so
45b25000-45b26000 r--p 00001000 03:06 4243258    /lib/libdl-2.4.so
45b26000-45b27000 rw-p 00002000 03:06 4243258    /lib/libdl-2.4.so
45c6e000-45c80000 r-xp 00000000 03:06 1782100    /usr/lib/libz.so.1.2.3
45c80000-45c81000 rw-p 00011000 03:06 1782100    /usr/lib/libz.so.1.2.3
46497000-46499000 r-xp 00000000 03:06 4244426    /lib/libcom_err.so.2.1
46499000-4649a000 rw-p 00001000 03:06 4244426    /lib/libcom_err.so.2.1
4649c000-464ab000 r-xp 00000000 03:06 4244425    /lib/libresolv-2.4.so
464ab000-464ac000 r--p 0000e000 03:06 4244425    /lib/libresolv-2.4.so
464ac000-464ad000 rw-p 0000f000 03:06 4244425    /lib/libresolv-2.4.so
464ad000-464af000 rw-p 464ad000 00:00 0
464bb000-465da000 r-xp 00000000 03:06 4244427    /lib/libcrypto.so.0.9.8a
465da000-465ed000 rw-p 0011e000 03:06 4244427    /lib/libcrypto.so.0.9.8a
465ed000-465f0000 rw-p 465ed000 00:00 0
465f2000-465f5000 r-xp 00000000 03:06 1785207    /usr/lib/libkrb5support.so.0.0
465f5000-465f6000 rw-p 00002000 03:06 1785207    /usr/lib/libkrb5support.so.0.0
465f8000-4666b000 r-xp 00000000 03:06 1788263    /usr/lib/libkrb5.so.3.2
4666b000-4666d000 rw-p 00073000 03:06 1788263    /usr/lib/libkrb5.so.3.2
4666f000-46687000 r-xp 00000000 03:06 1788264    /usr/lib/libgssapi_krb5.so.2.2
46687000-46688000 rw-p 00017000 03:06 1788264    /usr/lib/libgssapi_krb5.so.2.2
4668a000-466ae000 r-xp 00000000 03:06 1788262    /usr/lib/libk5crypto.so.3.0
466ae000-466af000 rw-p 00024000 03:06 1788262    /usr/lib/libk5crypto.so.3.0
467e0000-46821000 r-xp 00000000 03:06 4244428    /lib/libssl.so.0.9.8a
46821000-46825000 rw-p 00040000 03:06 4244428    /lib/libssl.so.0.9.8a
84400000-84421000 rw-p 84400000 00:00 0
84421000-84500000 ---p 84421000 00:00 0
84518000-84523000 r-xp 00000000 03:06 4244801
/lib/libgcc_s-4.1.1-20060525.so.1
84523000-84524000 rw-p 0000a000 03:06 4244801
/lib/libgcc_s-4.1.1-20060525.so.1
84538000-85438000 rw-p 84538000 00:00 0
854bc000-856bc000 rw-p 854bc000 00:00 0
8577f000-86b7f000 rw-p 8577f000 00:00 0
86bc1000-86dc1000 rw-p 86bc1000 00:00 0
86e65000-88465000 rw-p 86e65000 00:00 0
884e8000-893e8000 rw-p 884e8000 00:00 0
893e9000-896e9000 rw-p 893e9000 00:00 0
896ea000-89bea000 rw-p 896ea000 00:00 0
89c2c000-89f2c000 rw-p 89c2c000 00:00 0
89f4d000-8a14d000 rw-p 89f4d000 00:00 0
8a16e000-8a76e000 rw-p 8a16e000 00:00 0
8a76f000-8af6f000 rw-p 8a76f000 00:00 0
8b056000-8b156000 rw-p 8b056000 00:00 0
8b177000-8b477000 rw-p 8b177000 00:00 0
8b478000-8b978000 rw-p 8b478000 00:00 0
8b979000-8ba79000 rw-p 8b979000 00:00 0
8ba9a000-8bc9a000 rw-p 8ba9a000 00:00 0
8bd1e000-8c11e000 rw-p 8bd1e000 00:00 0
8c11f000-8c41f000 rw-p 8c11f000 00:00 0
8c420000-8c520000 rw-p 8c420000 00:00 0
8c582000-8c682000 rw-p 8c582000 00:00 0
8c683000-8d383000 rw-p 8c683000 00:00 0
8d426000-8d5260Aborted
[jonsmirl@jonsmirl parsecvs]$







-- 
Jon Smirl
jonsmirl@gmail.com
