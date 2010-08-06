From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: Back-dating commits--way back--for constitution.git
Date: Fri, 06 Aug 2010 11:44:00 -0500
Message-ID: <fGxsOXuy8990l2eOzf2k3cXF066OSIj50KBNkGGWXJhFoVG_B5MV_Q@cipher.nrlssc.navy.mil>
References: <i372v0$3np$1@dough.gmane.org>	<AANLkTik2B8pGo8uR4yxV3nz-Nx6dcU+fiO8GWgv9-VtW@mail.gmail.com>	<4C599781.2020603@gmail.com>	<4C5B2F2E.4050709@gmail.com>	<AANLkTikWc0rKV9rQsLfmZvhdqAuvATmbur2ZqQ4Xu7uo@mail.gmail.com> <AANLkTikJP2d5_pA+RcQeToE+RGW0oBhcZyghLfqDoJ8E@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: "Joel C. Salomon" <joelcsalomon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 18:44:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhQ1i-0007QL-1C
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 18:44:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933681Ab0HFQoF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Aug 2010 12:44:05 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:33716 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933055Ab0HFQoE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 12:44:04 -0400
Received: by mail.nrlssc.navy.mil id o76Gi17Y022346; Fri, 6 Aug 2010 11:44:01 -0500
In-Reply-To: <AANLkTikJP2d5_pA+RcQeToE+RGW0oBhcZyghLfqDoJ8E@mail.gmail.com>
X-OriginalArrivalTime: 06 Aug 2010 16:44:00.0964 (UTC) FILETIME=[927B6040:01CB3586]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152794>

Joel C. Salomon wrote:
> On Thu, Aug 5, 2010 at 5:58 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n
> <avarab@gmail.com> wrote:
>> On Thu, Aug 5, 2010 at 21:37, Joel C. Salomon <joelcsalomon@gmail.co=
m> wrote:
>>> It's up, at <http://github.com/jcsalomon/constitution>, with one co=
mmit.
>>>
>>> I'm curious to find out if folks with 64-bit time_t get the correct
>>> author and commit times.
>> On 32bit:
>>
>> commit 826a4f7721fe1c3963a733ecbc5422f05925af5d
>> Author: The Philadelphia Convention <>
>> Date:   Wed Dec 31 19:59:59 1969 -0400
>>
>> On 64bit:
>>
>> commit 826a4f7721fe1c3963a733ecbc5422f05925af5d
>> Author: The Philadelphia Convention <>
>> Date:   Mon Sep 17 13:00:00 1787 -0400
>=20
> Cool, it works!  (The 13:00 should have been 12:00, but there's some
> DST weirdness at work.)

Something other than the fact that -0400 should be -0500?
Or are you talking about an issue with the software you are using to
create the dates?

-brandon
