From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: Consecutive git gc fails on Windows network share
Date: Mon, 20 Jan 2014 18:16:16 +0100
Message-ID: <52DD59E0.4090301@web.de>
References: <d10603d6-7740-44f8-909f-7ba1ea77d3a2@googlegroups.com> <52D9701F.5070009@web.de> <11936e14-7442-4601-8e97-b2062894975b@googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Jochen <zwanzig12@googlemail.com>, msysgit@googlegroups.com, 
 =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>, 
 Git Mailing List <git@vger.kernel.org>,
 stefanbeller@googlemail.com
X-From: msysgit+bncBCUZ3EUT2ADRBZVT6WLAKGQEXQQTQAQ@googlegroups.com Mon Jan 20 18:16:24 2014
Return-path: <msysgit+bncBCUZ3EUT2ADRBZVT6WLAKGQEXQQTQAQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f63.google.com ([209.85.215.63])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCUZ3EUT2ADRBZVT6WLAKGQEXQQTQAQ@googlegroups.com>)
	id 1W5ISW-0003w0-1H
	for gcvm-msysgit@m.gmane.org; Mon, 20 Jan 2014 18:16:24 +0100
Received: by mail-la0-f63.google.com with SMTP id y1sf823058lam.8
        for <gcvm-msysgit@m.gmane.org>; Mon, 20 Jan 2014 09:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=dqMajKASA7Rn1kPlGdJNvVLAY2TWWw8ubybKlFpAEH8=;
        b=d7eswbvFtdbR5xChPaC0qihEsBYfr0U0PML2BQ5pLtMBTNSL8wf/cFJf3XyErlbcc0
         X/A+wZkSte4nyAQZcWl8Wj8JMvLzJA1mOmAyzz4fQxcqM5UdlEEja6ROC39fotygZmeC
         lx2PG9T+8uBg+g69maLdoPP0AXm/ECxytRrr1TixelXqo6+j0JI4CpKMj4WfPt9F61ER
         uoaMgSNx0eHFyqJUDBQejdfHs8gSh8JVvvr61vxFgulc1ohuGq2vFDPt23QwM+NB4zjL
         b8p8pQVQe2iytrE7W9jAwPXCupxNoXPsqCrLN51WotZHwf0N4COe9SJ/mzP80+09qR8Z
         dZVQ==
X-Received: by 10.180.95.9 with SMTP id dg9mr84987wib.11.1390238183643;
        Mon, 20 Jan 2014 09:16:23 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.100.225 with SMTP id fb1ls108577wib.2.gmail; Mon, 20 Jan
 2014 09:16:22 -0800 (PST)
X-Received: by 10.180.205.168 with SMTP id lh8mr7068529wic.4.1390238182505;
        Mon, 20 Jan 2014 09:16:22 -0800 (PST)
Received: from mout.web.de (mout.web.de. [212.227.15.4])
        by gmr-mx.google.com with ESMTPS id f47si408927eem.0.2014.01.20.09.16.22
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2014 09:16:22 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of tboegi@web.de designates 212.227.15.4 as permitted sender) client-ip=212.227.15.4;
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0LpO93-1VQRnc33NF-00fBPK for
 <msysgit@googlegroups.com>; Mon, 20 Jan 2014 18:16:22 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <11936e14-7442-4601-8e97-b2062894975b@googlegroups.com>
X-Provags-ID: V03:K0:zEtoBYummIksfd3OxpB46wOiichElWoxwCe9Swf7Jl8k3w6RjjZ
 2NFBqjJRCS3wDA9m1+PCGP1438Lb8yDmfSYlzdxVTKCPNHLX5lRr32PSC1QRk4cw7M7w8Iv
 9aaqLSNsHx8EZIeAoHlZHrFwpTSeas9OHc0lkX56tp92Y5y7Mhkj44MeE3Kzwgj4FbmZyr6
 IY94LAI/iwRNtFL2U8xVg==
X-Original-Sender: tboegi@web.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: best guess record for domain of tboegi@web.de designates
 212.227.15.4 as permitted sender) smtp.mail=tboegi@web.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240719>

(No top-posting, please see my comments below)
On 2014-01-20 15.02, Jochen wrote:
>On 01/16/2014 10:55 AM, Jochen Haag wrote:
> Hello,
>
> we want to report the following issue, because it seems to be not an
> intended behaviour. Maybe someone can have a look at it at some point.
> It is not urgent for us.
>
> After upgrading from Git version 1.8.1.msysgit.1 to 1.8.5.2.msysgit.0 we
> observed that a consecutive git gc fails, in case the Git repo is
> located on a Windows network share. Operating system used is Windows 7
> 64 bit SP1.
>
> In case git gc fails temporary packs and index remain in .git/objects/pac=
k/.
>
> "Consecutive" means, that git gc is called on an already packed
> repository (e.g. git gc is called more than once).
>
> This is the output given in case of error:
>
> U:\GitEnv>git gc
> Counting objects: 139, done.
> Delta compression using up to 8 threads.
> Compressing objects: 100% (71/71), done.
> Writing objects: 100% (139/139), done.
> Total 139 (delta 65), reused 139 (delta 65)
> fatal: renaming
> '.git/objects/pack/.tmp-7920-pack-ad9d069e7c27ce19cc5b6cde82b4a38bedbf588=
4.pack'
> failed: Permission denied
> error: failed to run repack
>
> And here the output with GIT_TRACE =3D 1:
>
> U:\GitEnv>git gc
> trace: built-in: git 'gc'
> trace: run_command: 'pack-refs' '--all' '--prune'
> trace: built-in: git 'pack-refs' '--all' '--prune'
> trace: run_command: 'reflog' 'expire' '--all'
> trace: built-in: git 'reflog' 'expire' '--all'
> trace: run_command: 'repack' '-d' '-l' '-A'
> '--unpack-unreachable=3D2.weeks.ago'
> trace: built-in: git 'repack' '-d' '-l' '-A'
> '--unpack-unreachable=3D2.weeks.ago'
> trace: run_command: 'pack-objects' '--keep-true-parents'
> '--honor-pack-keep' '--non-empty' '--all' '--reflog'
> '--unpack-unreachable=3D2.weeks.ago' '--local' '--delta-base-offset'
> '.git/objects/pack/.tmp-7612-pack'
> trace: built-in: git 'pack-objects' '--keep-true-parents'
> '--honor-pack-keep' '--non-empty' '--all' '--reflog'
> '--unpack-unreachable=3D2.weeks.ago' '--local' '--delta-base-offset'
> '.git/objects/pack/.tmp-7612-pack'
> Counting objects: 139, done.
> Delta compression using up to 8 threads.
> Compressing objects: 100% (71/71), done.
> Writing objects: 100% (139/139), done.
> Total 139 (delta 65), reused 139 (delta 65)
> fatal: renaming
> '.git/objects/pack/.tmp-7612-pack-ad9d069e7c27ce19cc5b6cde82b4a38bedbf588=
4.pack'
> failed: Permission denied
> error: failed to run repack
>
> After running git gc twice, this is what is left in .git/objects/pack/:
>
> U:\GitEnv\.git\objects\pack>ls -al
> total 53676
> drwxr-xr-x    1 hgj2fe   Administ        0 Jan 16 10:43 .
> drwxr-xr-x    1 hgj2fe   Administ        0 Jan 14 12:52 ..
> -r--r--r--    1 hgj2fe   Administ     4964 Jan 16 10:43
> .tmp-7612-pack-ad9d069e7c27ce19cc5b6cde82b4a38bedbf5884.idx
> -r--r--r--    1 hgj2fe   Administ 18315618 Jan 16 10:43
> .tmp-7612-pack-ad9d069e7c27ce19cc5b6cde82b4a38bedbf5884.pack
> -r--r--r--    1 hgj2fe   Administ     4964 Jan 16 10:40
> .tmp-7920-pack-ad9d069e7c27ce19cc5b6cde82b4a38bedbf5884.idx
> -r--r--r--    1 hgj2fe   Administ 18315618 Jan 16 10:40
> .tmp-7920-pack-ad9d069e7c27ce19cc5b6cde82b4a38bedbf5884.pack
> -r--r--r--    1 hgj2fe   Administ     4964 Jan 14 12:52
> pack-ad9d069e7c27ce19cc5b6cde82b4a38bedbf5884.idx
> -r--r--r--    1 hgj2fe   Administ 18315618 Jan 14 12:52
> pack-ad9d069e7c27ce19cc5b6cde82b4a38bedbf5884.pack
>
> In case we remove the read-only flag of the pack and index manually
> before running git gc again, no problem occurs:
>
> U:\GitEnv\.git\objects\pack>git gc
> trace: built-in: git 'gc'
> trace: run_command: 'pack-refs' '--all' '--prune'
> trace: built-in: git 'pack-refs' '--all' '--prune'
> trace: run_command: 'reflog' 'expire' '--all'
> trace: built-in: git 'reflog' 'expire' '--all'
> trace: run_command: 'repack' '-d' '-l' '-A'
> '--unpack-unreachable=3D2.weeks.ago'
> trace: built-in: git 'repack' '-d' '-l' '-A'
> '--unpack-unreachable=3D2.weeks.ago'
> trace: run_command: 'pack-objects' '--keep-true-parents'
> '--honor-pack-keep' '--non-empty' '--all' '--reflog'
> '--unpack-unreachable=3D2.weeks.ago' '--local' '--delta-base-offset'
> 'U:/GitEnv/.git/objects/pack/.tmp-3736-pack'
> trace: built-in: git 'pack-objects' '--keep-true-parents'
> '--honor-pack-keep' '--non-empty' '--all' '--reflog'
> '--unpack-unreachable=3D2.weeks.ago' '--local' '--delta-base-offset'
> 'U:/GitEnv/.git/objects/pack/.tmp-3736-pack'
> Counting objects: 139, done.
> Delta compression using up to 8 threads.
> Compressing objects: 100% (71/71), done.
> Writing objects: 100% (139/139), done.
> Total 139 (delta 65), reused 139 (delta 65)
> trace: run_command: 'prune-packed'
> trace: built-in: git 'prune-packed'
> trace: run_command: 'update-server-info'
> trace: built-in: git 'update-server-info'
> trace: run_command: 'prune' '--expire' '2.weeks.ago'
> trace: built-in: git 'prune' '--expire' '2.weeks.ago'
> trace: run_command: 'rerere' 'gc'
> trace: built-in: git 'rerere' 'gc'
>
> The problem might be related to this commit:
> https://github.com/msysgit/git/commit/a1bbc6c0176f1fa2d4aa571cc0183a1f0ff=
9b285
>
>
> Best regards,
>
> Jochen
------
>=20
>=20
> Am Freitag, 17. Januar 2014 19:02:07 UTC+1 schrieb Torsten B=C3=B6gershau=
sen:
>=20
>=20
>     So, please, what happens if you revert that commit?
>     It could be good if you can test it and share the results with the li=
st
>     /Torsten
>=20
>=20
> Instead of reverting we did some more analysis.
>=20
> In repack.c we found the following code:
>=20
>         /* Now the ones with the same name are out of the way... */
>         for_each_string_list_item(item, &names) {
>                 for (ext =3D 0; ext < 2; ext++) {
>                         char *fname, *fname_old;
>                         struct stat statbuffer;
>                         fname =3D mkpathdup("%s/pack-%s%s",
>                                         packdir, item->string, exts[ext])=
;
>                         fname_old =3D mkpathdup("%s-%s%s",
>                                         packtmp, item->string, exts[ext])=
;
>                         if (!stat(fname_old, &statbuffer)) {
>                                 statbuffer.st_mode &=3D ~(S_IWUSR | S_IWG=
RP | S_IWOTH);
>                                 chmod(fname_old, statbuffer.st_mode);
>                         }
>                         if (rename(fname_old, fname))
>                                 die_errno(_("renaming '%s' failed"), fnam=
e_old);
>                         free(fname);
>                         free(fname_old);
>                 }
>         }
>=20
> The rename command replaces a mv -f command of the original shell script.=
 Obviously the -f option can also override a read-only file but rename can =
not on a network share.
>=20
> We changed the code as followed:
>=20
>         /* Now the ones with the same name are out of the way... */
>         for_each_string_list_item(item, &names) {
>                 for (ext =3D 0; ext < 2; ext++) {
>                         char *fname, *fname_old;
>                         struct stat statbuffer;
>                         fname =3D mkpathdup("%s/pack-%s%s",
>                                         packdir, item->string, exts[ext])=
;
>                         fname_old =3D mkpathdup("%s-%s%s",
>                                         packtmp, item->string, exts[ext])=
;
>                         if (!stat(fname_old, &statbuffer)) {
>                                 statbuffer.st_mode &=3D ~(S_IWUSR | S_IWG=
RP | S_IWOTH);
>                                 chmod(fname_old, statbuffer.st_mode);
>                         }
>+++                         if (!stat(fname, &statbuffer)) {
>+++                                 statbuffer.st_mode |=3D (S_IWUSR | S_I=
WGRP | S_IWOTH);
>+++                                 chmod(fname, statbuffer.st_mode);
>+++                         }
>                         if (rename(fname_old, fname))
>                                 die_errno(_("renaming '%s' failed"), fnam=
e_old);
>                         free(fname);
>                         free(fname_old);
>                 }
>         }
>=20
> Before rename is called the destination file is made writeable. This work=
ed for us. We are not sure if this is a good implementation.

Jochen,
thanks for sharing the code changes with us.

I allowed me to=20
a) reconstruct the original mail,
b) add "+++" at the places where you added the stat() and chmod(),
c) and to send the question "is this a good implementation ?" to upstream g=
it.

I think your implementation makes sense.
/Torsten
=20

--=20
--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den

---=20
You received this message because you are subscribed to the Google Groups "=
msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
