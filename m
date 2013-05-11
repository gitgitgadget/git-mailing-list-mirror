From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: RE:  [PATCH] test-bzr: Do not use unportable sed "\+"
Date: Sat, 11 May 2013 22:11:25 +0200
Message-ID: <518EA5ED.9020001@web.de>
References: <201305111525.53130.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: felipe.contreras@gmail.com, git@vger.kernel.org
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat May 11 22:13:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbGAI-0005cB-7N
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 22:13:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754057Ab3EKUNF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 May 2013 16:13:05 -0400
Received: from mout.web.de ([212.227.15.3]:65388 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753879Ab3EKUNE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 16:13:04 -0400
Received: from [192.168.209.16] ([195.67.191.23]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0LrK0u-1UP3uD48Sa-013LBb; Sat, 11 May 2013 22:13:02
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
In-Reply-To: <201305111525.53130.tboegi@web.de>
X-Provags-ID: V02:K0:3IKMSaq2z9TyXACJ1q1ZabTJNYP96zus0v7oGn2Yd8I
 1l7DSrY4k6zsdV1NkEPwJCIsCnNXQX2BFdkFFtEhdHlId08Oqb
 t8YAZmdK+t5zfaPojWTTYmwngyDY1Pj8q0ySBvNs9CGRGKm+v5
 6t7WKRmZF/x4n0IfrjQxXAS7iUU+cCx6kfAhdYCiWwP1fu+cXt
 3vv1BLG3mmd+5dUzZ+I1A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224009>

On 05/11/2013 03:25 PM, Torsten B=C3=B6gershausen wrote:
Sorry, I forgot to mention that there is another test case that fails
in test-bzr.sh (Both Linux and MacOS):

Cloning into 'gitrepo'...
--- ../expected 2013-05-11 20:07:17.678360248 +0000
+++ actual      2013-05-11 20:07:21.510312073 +0000
@@ -1,3 +1,3 @@
-origin/HEAD
+origin
  origin/branch
  origin/trunk
not ok 11 - proper bzr repo
