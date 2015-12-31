From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: ./t3310-notes-merge-manual-resolve.sh broken on pu under Mac OS ?
Date: Thu, 31 Dec 2015 12:23:10 +0000
Message-ID: <56851E2E.4050403@ramsayjones.plus.com>
References: <5683DA04.6000007@web.de>
 <CAPig+cQZq-aDYv5G3eNivvqC0eCTfyPtA4gEuop0PWq2LFT=9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Dec 31 13:24:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEcHT-0006Gp-D1
	for gcvg-git-2@plane.gmane.org; Thu, 31 Dec 2015 13:24:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052AbbLaMYc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Dec 2015 07:24:32 -0500
Received: from avasout07.plus.net ([84.93.230.235]:40537 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbbLaMYa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2015 07:24:30 -0500
Received: from [10.0.2.15] ([46.208.159.221])
	by avasout07 with smtp
	id 0CPG1s00B4mu3xa01CPHWT; Thu, 31 Dec 2015 12:23:17 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=MZKRwMLf c=1 sm=1 tr=0
 a=Sp5fw55EgyGSOjouSGNDoQ==:117 a=Sp5fw55EgyGSOjouSGNDoQ==:17 a=0Bzu9jTXAAAA:8
 a=EBOSESyhAAAA:8 a=IkcTkHD0fZMA:10 a=dacQiwKEeEe0IGjbzVcA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
In-Reply-To: <CAPig+cQZq-aDYv5G3eNivvqC0eCTfyPtA4gEuop0PWq2LFT=9Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283234>



On 31/12/15 06:08, Eric Sunshine wrote:
> On Wed, Dec 30, 2015 at 8:20 AM, Torsten B=C3=B6gershausen <tboegi@we=
b.de> wrote:
>> I got 2 failures on pu under Mac OS, (Linux is OK)
>> I did some very basic debugging, it seems as if grep doesn't find
>> a needed string.
>> Does anybody have an idea here ?
>=20
> I'm unable to reproduce these failures on Mac.
>=20

This test failed during a short window (due to commit 2bd811ec) and
has already been fixed in commit 3a74ea38 ("notes: allow merging
from arbitrary references", 29-12-2015).

ATB,
Ramsay Jones
