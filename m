From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: folder naming bug?
Date: Tue, 03 Feb 2015 09:40:29 +0100
Message-ID: <54D0897D.4050101@web.de>
References: <27503C0E-7D33-4893-AD25-6A821D31FAB1@sparkstart.io> <CAGyf7-FXhhW74DvcO8nbWud9A868AYqKj_zY61wmf9XGvH4eQA@mail.gmail.com> <06E0624C-2484-476D-A32F-B586062EC230@sparkstart.io> <20150203052317.GA1262@peff.net> <26FB4384-1027-436F-84C5-91C6CC4D27EA@sparkstart.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bryan Turner <bturner@atlassian.com>,
	Git Users <git@vger.kernel.org>
To: Kevin Coleman <kevin.coleman@sparkstart.io>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 03 09:41:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIZ2l-0001XX-2N
	for gcvg-git-2@plane.gmane.org; Tue, 03 Feb 2015 09:41:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932575AbbBCIlH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Feb 2015 03:41:07 -0500
Received: from mout.web.de ([212.227.17.12]:57504 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752221AbbBCIlF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2015 03:41:05 -0500
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0LfAoO-1Xps3s2J20-00oqQ2; Tue, 03 Feb 2015 09:40:56
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.4.0
In-Reply-To: <26FB4384-1027-436F-84C5-91C6CC4D27EA@sparkstart.io>
X-Provags-ID: V03:K0:BC9Ts1LavRikOvuvhOD/8tlnkUAZuP8OHGb7sUVG3ntFOVU8pGG
 IMvfcd7+hzZps1AKeDcwppnykku3iR2bOMQ1qaFg9bU6Q9FbkVlAepX1cv2S+TMT0RrEVUm
 73MAz/hGMt4ShLC6gcrvhO1Gsn9N1x9P2tfoqBfZlqhp75vEXThkEMjUFPVX53efcVohhAs
 CFPxM9IeDaI8kyfoWTc0w==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263311>

On 02/03/2015 07:23 AM, Kevin Coleman wrote:
> Awesome reply! That makes sense.  So basically if I accidentally capi=
talize a folder name and commit it, I need to be very careful when I co=
rrect it.  Definitely ran into this problem with my repo and =E2=80=98l=
ost=E2=80=99 a few commits before I noticed something was off.
>
> -Kevin Coleman
(Please no top-posting)

According to my experience setting core.ignorecase false
may cause the user to loose commits.

Can you reproduce the problem ?
with core.ignorecase false (Which is wrong)
with core.ignorecase true (You shouldn't loose anything)
