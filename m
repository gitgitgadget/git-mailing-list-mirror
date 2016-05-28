From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v8 0/9] connect: various cleanups
Date: Sat, 28 May 2016 07:02:01 +0200
Message-ID: <5071966e-6bce-fa91-8837-81cb3c9157f7@web.de>
References: <20160527022756.22904-1-mh@glandium.org>
 <a6f4bf06-a52b-dcdf-9407-0c03b8b1dfe1@web.de>
 <20160527215943.GA21018@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat May 28 07:07:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6WTG-0003Do-LA
	for gcvg-git-2@plane.gmane.org; Sat, 28 May 2016 07:07:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbcE1FHa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 May 2016 01:07:30 -0400
Received: from mout.web.de ([212.227.17.11]:53626 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750814AbcE1FH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2016 01:07:29 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0MPHGG-1bAwEm2Dey-004Oo7; Sat, 28 May 2016 07:02:04
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.1.0
In-Reply-To: <20160527215943.GA21018@glandium.org>
X-Provags-ID: V03:K0:EjJjk7VgdnrsvHouC/cLyS6xXutbnzb0R4usP1BYEs4DFSMhLh+
 IasCaFcsed/oxtTtyBCaliy2wmqGNX0ZEslb89YX+8+V37G4bm3AlLrvEOCpovi3x4nL3hj
 JUwe0/drMgSYWk6UaIcPbS9mjFOT5+DC5juAVnX2hdQ1p0jKK8UsMFp4+WPymtFsrUyF+mt
 w6Fqlc+UZ+u+Rn+EEVSpQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RDlm5m4FPoc=:UE3pQpV0cQqzLy9ex/6i59
 UzUNOXakEYABo8c9gnz1Ibvja1lOwOzF4M8nCjZjaKddeNPqkETUqao5jtYZSUV9Jxgz2cpup
 kTt/Ii+D3mxR6JasJM2rDoLb3PrquqDwUVa0ssHxL+5WqZblkeTyzG3n3vsKxGOE1tvwmv26b
 fHwJibg8K9k4yCdSFnCe9cuuBdF+1Ff6QXhtYCRedbPDE087WL263YVlZ0LMhXY2v+rv8+1wm
 OCE5tGvLHy+eSEMHVIt8/bgtQRFccexjaAdohl8ej+Mje9oqw3soIqXZ8NnM6hE71w9SdWkqO
 HWY2aRuS8SyOC2kthAuk1XFzvt6TfIWHQP+K7zh/zP50OdFeIzjJ6vZhKeXrrMtO9twoJyu5R
 nY63uTOPRKQe1Jrt9v8R5+TnymnxpYT6Xq1biKze8GYQcXxFFfZW4uUcfgFwGfzy4pm5ZZWpW
 uKOqhEryx29FyEeOIPziNfzk9uV/T33ti/8aWF+8+5kZTn6CgYLBikkUb3mb8OpJPhLkiCrs8
 r2DVGktWxOvelxWZIloc8dFG9pLTaTqeJPiPttv38RXqq5MlTaY0/+v/QGAbAcjmMOGOjGUfB
 zflgXET1KdDm4w/px/q1WMMArUj5A725lAQJeBvVhDR8aBkPULz7iA32FQtbSp0kVCtVGVt55
 ibJk+6P/mP3ufGLyWswOEWcEXxjN/bJSYxuli5RnyKs7r3eKo9dqjC3SDFFqYms6uA+BW2D4c
 vIXHYWegzJSRE0U0HOJ8f0O/jhoYXAtxz/Cdx1dPCgbxd9EsNYZ8P7EjNVIz8conSu1T5elH 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295800>

On 27.05.16 23:59, Mike Hommey wrote:
> On Fri, May 27, 2016 at 04:24:20PM +0200, Torsten B=F6gershausen wrot=
e:
>> On 27.05.16 04:27, Mike Hommey wrote:
>>> Changes from v7:
>>> - Fixed comments.
>>>
>>> Mike Hommey (9):
All in all, a great improvement.
2 things left.
- The comment about [] is now stale, isn't it ?
- The legacy support should only be active for ssh, and not
  be used by other schemes.



diff --git a/connect.c b/connect.c
index 076ae09..79b8dae 100644
--- a/connect.c
+++ b/connect.c
@@ -618,10 +618,6 @@ static enum protocol parse_connect_url(const char =
*url_orig, char **ret_user,
                }
        }
=20
-       /*
-        * Don't do destructive transforms as protocol code does
-        * '[]' unwrapping in get_host_and_port()
-        */
        end =3D host_end(&host, 0);
=20
        if (protocol =3D=3D PROTO_LOCAL)
@@ -673,7 +669,7 @@ static enum protocol parse_connect_url(const char *=
url_orig, char **ret_user,
         * "host:port" and NULL.
         * To support this undocumented legacy we still need to split t=
he port.
         */
-       if (!port)
+       if (!port && protocol =3D=3D PROTO_SSH)
                port =3D get_port(host);
=20
        *ret_user =3D user ? xstrdup(user) : NULL;
