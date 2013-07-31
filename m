From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 2/2] Don't close pack fd when free'ing pack windows
Date: Wed, 31 Jul 2013 23:28:08 +0200
Message-ID: <87r4eee7x3.fsf@hexa.v.cablecom.net>
References: <CA+sFfMe1GTDqtgGs3NXoB0OBYTtyHxLDYgy0TmOe+3r=tMXS0A@mail.gmail.com>
	<1375300297-6744-1-git-send-email-bcasey@nvidia.com>
	<1375300297-6744-2-git-send-email-bcasey@nvidia.com>
	<CALWbr2wR2cN8dcOtW2bV3p7FC3ymdXgfp61A4pNKvOWhP6WU_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Brandon Casey <bcasey@nvidia.com>, git <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>, Jeff King <peff@peff.net>,
	<spearce@spearce.org>, Eric Sunshine <sunshine@sunshineco.com>,
	Brandon Casey <drafnel@gmail.com>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 31 23:28:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4dwP-0006di-PU
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 23:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760655Ab3GaV2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 17:28:13 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:17050 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752830Ab3GaV2K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 17:28:10 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 31 Jul
 2013 23:28:03 +0200
Received: from hexa.v.cablecom.net.ethz.ch (46.126.8.85) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 31 Jul
 2013 23:28:08 +0200
In-Reply-To: <CALWbr2wR2cN8dcOtW2bV3p7FC3ymdXgfp61A4pNKvOWhP6WU_Q@mail.gmail.com>
	(Antoine Pelisse's message of "Wed, 31 Jul 2013 23:08:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231465>

Antoine Pelisse <apelisse@gmail.com> writes:

> On Wed, Jul 31, 2013 at 9:51 PM, Brandon Casey <bcasey@nvidia.com> wrote:
>> -----------------------------------------------------------------------------------
>> This email message is for the sole use of the intended recipient(s) and may contain
>> confidential information.  Any unauthorized review, use, disclosure or distribution
>> is prohibited.  If you are not the intended recipient, please contact the sender by
>> reply email and destroy all copies of the original message.
>> -----------------------------------------------------------------------------------
>
> I'm certainly not a lawyer, and I'm sorry for not reviewing the
> content of the patch instead, but is that not a problem from a legal
> point of view ?
> I remember a video of Greg Kroah-Hartman where he talked about that
> (the video was posted by Junio on G+).

It's this video:

  http://www.youtube.com/watch?v=fMeH7wqOwXA

The comment starts at 13:55.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
