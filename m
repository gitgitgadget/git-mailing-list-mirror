From: =?ISO-8859-2?Q?Tajti_=C1kos?= <akos.tajti@intland.com>
Subject: git-upload-pack died of signal 13
Date: Wed, 06 Jun 2012 13:28:23 +0200
Message-ID: <4FCF3ED7.9060503@intland.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 06 13:28:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScEPl-0002Ur-5R
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 13:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755876Ab2FFL2c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jun 2012 07:28:32 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:50977 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752798Ab2FFL2b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 07:28:31 -0400
Received: from [192.168.1.101] (92-249-245-147.pool.digikabel.hu [92.249.245.147])
	by mrelayeu.kundenserver.de (node=mrbap3) with ESMTP (Nemesis)
	id 0MKqqe-1ScEPd2skK-0001q2; Wed, 06 Jun 2012 13:28:30 +0200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; hu; rv:1.9.2.28) Gecko/20120306 Thunderbird/3.1.20
X-Provags-ID: V02:K0:SDAyvX30pfr2glogRyBAdCOG2YqW9zPVYYbu2sxhEVS
 02mYoVNuWC6x6tMqfkoS/INb0Gw4yJexz5Be3peWTQysGa8Oxo
 jaQYjhmBWK88LbbO5KouG4kHeVVw7yItzWI2R+2VAVg4/jDF1n
 DQtT+S90xAjYsra40URqUv2aHCMpN9Rq0r0n0/Hmw+uTxu3gOu
 fzpI0FQP72hAFTmYWYuSncDT8rvyYbZ1woYxefWmbPlIkH1B8X
 ZP/2+GD+S8lgbCqFjnLk57l8Vfp/VdwdxWwVFJ5uVauTI3qPWB
 yLPDHzbIPlig0icFgUA3W+P+akYJAdm6MJG00bq1MzZF5m3r0T
 s2EdgfmPzxAYVIvtm1Eg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199313>

Dear List,

we got "git-upload pack died of signal 13" error when pushing using thi=
s=20
command:

  Executing: "/usr/lib/git-core/git-http-backend" env:=20
"CONTENT_TYPE=3Dapplication/x-git-upload-pack-request"=20
"GIT_HTTP_EXPORT_ALL=3Dtrue" "SERVER_PORT=3D443"=20
"CODEBEAMER_SMART_SCM_SERVLET=3Dtrue" "REMOTE_ADDR=3D91.82.170.74"=20
"REMOTE_HOST=3D91.82.170.74" "SERVER_SOFTWARE=3DApache Tomcat/6.0.35"=20
"SERVER_NAME=3Dcodebeamer.com"=20
"GIT_PROJECT_ROOT=3D/home/akos/repository/git" "REMOTE_USER=3Dzl"=20
"PATH_INFO=3D/cbdev-git/git-upload-pack" "QUERY_STRING=3D" "AUTH_TYPE=3D=
Basic"=20
"GATEWAY_INTERFACE=3DCGI/1.1" "SERVER_PROTOCOL=3DHTTP/1.1"=20
"REQUEST_METHOD=3DPOST" "CONTENT_LENGTH=3D1157"=20
"REQUEST_URI=3D/app/git/my-git/git-upload-pack"

What may be the cause?

Thanks in advance,
=C1kos Tajti
