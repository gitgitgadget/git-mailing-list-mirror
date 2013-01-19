From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH 2/3] t0050: honor CASE_INSENSITIVE_FS in add (with different
 case)
Date: Sat, 19 Jan 2013 20:36:04 +0100
Message-ID: <50FAF5A4.5090304@web.de>
References: <201301190819.29767.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Jan 19 20:38:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TweFb-0004Li-23
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jan 2013 20:38:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249Ab3ASTgI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jan 2013 14:36:08 -0500
Received: from mout.web.de ([212.227.15.3]:65312 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752241Ab3ASTgH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2013 14:36:07 -0500
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb003)
 with ESMTPA (Nemesis) id 0LnjAt-1THWdX2OYJ-00heXo; Sat, 19 Jan 2013 20:36:04
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <201301190819.29767.tboegi@web.de>
X-Provags-ID: V02:K0:bf+wJ395HhyILMBFRttczPuulSUb+7F4hK7BunnOkRi
 fsXrUYnOLKpgp74prdjHe3PNpHDjl1Z9UirRqEx3Hm25JFHodP
 rSAiUmhH8vvfne+i5YMGeWOEdCopu5h2+Gyu89AsQZnfk2eXFV
 67ce9JeGpjRy/drXwSLNxHlXLP8pcLkOkoLRrJqY+MOsox7dq7
 dhqO3VBz0Hh54DWn9zTKg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213985>

On 19.01.13 08:19, Torsten B=C3=B6gershausen wrote:
> The test case "add (with different case)" indicates a
> known breakage when run on a case sensitive file system.
>=20
> The test is invalid for case sensitive file system,
> check the precondition CASE_INSENSITIVE_FS before running it.
Sorry,
this should have been:

> The test case "add (with different case)" indicates a
> known breakage when run on a case insensitive file system.
