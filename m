From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: Problems with  ./t9902-completion.sh
Date: Sat, 20 Oct 2012 14:50:23 +0200
Message-ID: <50829E0F.5040900@web.de>
References: <508292DC.8030700@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Oct 20 14:55:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TPYaX-0004sN-Vf
	for gcvg-git-2@plane.gmane.org; Sat, 20 Oct 2012 14:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755707Ab2JTMu3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Oct 2012 08:50:29 -0400
Received: from mout.web.de ([212.227.15.4]:56586 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755537Ab2JTMu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2012 08:50:29 -0400
Received: from birne.lan ([195.67.191.22]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0LZeou-1T2LFf0FIK-00m3Xr; Sat, 20 Oct 2012 14:50:27 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <508292DC.8030700@web.de>
X-Provags-ID: V02:K0:tbHmK8eDwfFM0hMKgialYzzvRT/PK1c3m2qOOQ/5MOl
 meEdEFX4Me75+LDQMXXNoFnZAAsyBVGOYmdTBAcVbnS0gHqGTc
 UhxflTGczSeUkoReAUHttqPnygWdABhGLenFg1I5iq3kdf/D2k
 L+YVua2ZraVSpNIWNjcH+sAr1elQPcdEvOxcA0a9sdHJ0ml69g
 cp47qo3UoUwKP9ddgUxuw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208086>

On 20.10.12 14:02, Torsten B=F6gershausen wrote:
> t9902  does not work on my Mac OS box,
> but only in one working directory.
>=20
> Any idea where the "check-ignore" comea from ?
> /Torsten
>=20


Oh, I find the answer myself:
 git status

# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#       ../git-check-ignore

=46rom some experiments there was a git-check-ignore left.
(and make clean doesn't delete it)

sorry for the noise.
