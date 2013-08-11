From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: Bug in git on windows
Date: Sun, 11 Aug 2013 10:49:20 +0200
Message-ID: <52075010.5030808@web.de>
References: <CAHHiLxQW00Zc9hpUEVV0bZ7_+18tCNdGT+bhrmryr47aj=x6XA@mail.gmail.com> <CAHHiLxTsTrQy3PBHSpMTUHpRMWnKwgzf=nSuUrZU3cniK6=vvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?B?0JjQu9GM0Y8g0JLQvtGA0L7QvdGG0L7Qsg==?= 
	<prijutme4ty@gmail.com>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 11 10:49:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8RLP-0000tZ-SN
	for gcvg-git-2@plane.gmane.org; Sun, 11 Aug 2013 10:49:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752474Ab3HKItX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Aug 2013 04:49:23 -0400
Received: from mout.web.de ([212.227.15.4]:60618 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752393Ab3HKItW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Aug 2013 04:49:22 -0400
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0M5Omd-1W3ynv3E7D-00zalb for <git@vger.kernel.org>;
 Sun, 11 Aug 2013 10:49:20 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <CAHHiLxTsTrQy3PBHSpMTUHpRMWnKwgzf=nSuUrZU3cniK6=vvg@mail.gmail.com>
X-Provags-ID: V03:K0:roa+zBlb9BaawPgfXgSP/Yc6yPd7x20+AwhugFAd5UwBHJf/xmt
 OOrMgvaNjvYwC46bbeFEduqB4iNyTRH5iIQNlRdSQGpbbTCh4p8EHJ0wApLOh/X2PIwTEVx
 rcJZuQ6QMY9pTuXZX6xbNd2UtqiEhA5A1+pUmd6ycH1Ed9nJEDUhDP+X+Ggx0UlTA4xxmVa
 zpxEbCJTtzjYBSYAiQkGw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232128>

On 2013-08-11 08.45, =D0=98=D0=BB=D1=8C=D1=8F =D0=92=D0=BE=D1=80=D0=BE=D0=
=BD=D1=86=D0=BE=D0=B2 wrote:
> git under windows doesn't check case of letters in filename. So when
> one rename for example images from *.JPG to *.jpg, git doesn't files
> in a repository so when one deliver this repo on *nix -system, old
> filenames preserve and this matters.
> It can be very confusing when some of assets in your website on serve=
r
> can't be loaded after deploy, though on windows all was ok.
> Possibly git windows shall identify changed case of symbols and
> suggested to rename files in commit.
It does (but this is disabled by default),
you can try=20
git config core.ignorecase false
/Torsten
