From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [BUG] having 'plink' anywhere in the =?UTF-8?Q?GIT=5FSSH=20en?=
 =?UTF-8?Q?vironment=20variables=20sets=20putty=20=3D=20true?=
Date: Wed, 22 Apr 2015 19:46:09 +0200
Organization: gmx
Message-ID: <6c2a6b53e8e6e019b145dddc67a9d2ca@www.dscho.org>
References: <2A6FFC1D-5479-4DCA-A5E5-FF92DE0AA552@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Patrick Sharp <jakanapes@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 19:46:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ykyj7-0007By-WA
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 19:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754105AbbDVRqP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Apr 2015 13:46:15 -0400
Received: from mout.gmx.net ([212.227.15.18]:53595 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753937AbbDVRqM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 13:46:12 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LdpcB-1ZARpx1I1b-00iyqG; Wed, 22 Apr 2015 19:46:10
 +0200
In-Reply-To: <2A6FFC1D-5479-4DCA-A5E5-FF92DE0AA552@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:XYL0FkmSwH+N8KpuO42cn51ImxTahJ3lKSrvZ9FROjSg+D7HeDv
 MmP9Su7VVOysLqrWR9+OMHfSNVbmcaP3IGIQn+AWH3DvFXReh/bXYBgDuiUhcdkrrWMNbqs
 nJUPQA/3/hC1PrgdBZZ2CsWasPvsBfybdEyOSV/b7y7vykwMyO860Bd4vwbi9v3B2pSlusx
 Yvzy/rR3FdHdL4uu+SsCA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267600>

Hi Patrick,

On 2015-04-22 16:36, Patrick Sharp wrote:
> The plink string detection in GIT_SSH for setting putty to true is ve=
ry broad.

Wow. You probably wanted to state that you are using Windows, downloade=
d Git from [link here], that you are using [version] and that you use P=
Link [version] (from the Putty package downloaded [link here]) to do yo=
ur ssh business.

Without that information, you leave readers who have no idea about Putt=
y *quite* puzzled.

> If plink is anywhere in the path to the shell file then putty gets se=
t
> to true and ssh will fail trying to parse -batch as the hostname.

This is cryptic even for me.

> Wouldn=E2=80=99t searching for plink.exe be better?--

I invite you to try your hand at improving anything you find flawed. Fo=
r example, if you want to improve the PLink detection in Git for Window=
s 1.x, this would be the correct place to start: https://github.com/msy=
sgit/msysgit/blob/70f24b4b0f5f86a5e85f7264a4ee2c0fec2d4391/share/WinGit=
/install.iss#L232-L253 (yes, you would have to download the development=
 environment from https://msysgit.github.com/#download-msysgit and rebu=
ild your own installer using `/share/msysGit/WinGit/release.sh 1.9.5-pa=
trick` after editing the installer script).

Ciao,
Johannes
