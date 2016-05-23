From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Odd Difference Between Windows Git and Standard Git
Date: Mon, 23 May 2016 13:12:07 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605231310190.4122@virtualbox>
References: <nhlqd4$ekr$1@ger.gmane.org> <c07df4ac-08c9-8eaa-0233-06616945c857@web.de> <c20b9819-1b2d-6704-d870-1c0102dd9e35@gmail.com> <ede1c113-1ab8-6043-3e39-bbacec5db31c@web.de> <xmqqy474g3cv.fsf@gitster.mtv.corp.google.com>
 <xmqqfutcg0pe.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Jon Forrest <nobozo@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 23 13:12:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4nmw-0004UN-AX
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 13:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754087AbcEWLMm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 07:12:42 -0400
Received: from mout.gmx.net ([212.227.17.20]:52672 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753606AbcEWLMl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 07:12:41 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0M5csW-1bSosQ3Y9w-00xc2D; Mon, 23 May 2016 13:12:30
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqfutcg0pe.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:SxHkLKXgKuG/j/8OlUz3Cpc9eEIc8Lod5ggFPOkbdSGrNz+FW+Z
 +OTdTptiBeMfax8GDBhRZYI5qb3TT7ZNmk5XHgcfEzcsJNZmhXWkE3WyMC3SGhEl8r5Z8CQ
 xjJGF0b4p7KDxTY4HThaKtC2o2qbaUPY4KWPTxlQznJcHXL4RaTcetkqpS5rsE276jmP25U
 4PE9gpfkYbrvc5f1nya5w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1SURAZso5Pk=:0AoUboA6ygksVAtJdP4Jib
 kSj6vcSUzwXyjvksO7LFwjvjIRgkHoi0Qzg4Jh53AI7AjfQ9qVPYffVV0guzxa/vHHCbEi6k8
 VQI+A7b17ZZHip8uHKz22TXlcEwpf9j1PcLs2wmbPndCNiRQ5r49p8Fnpo0gn7P7DUpvex0bj
 9eCbhAYxzkwXCa99KAgzjnfJ39QViovdh5jSMqTX3OtGvTlCcXXKmmYI6VOHk9pYlNjYvzM8K
 jrE90lLi0Lei9UlLfxrpSmySSwxOQd7jrQLZ5dBpJIORLZ//KV4BiCDwD/I6NiSaGi8L6DQDk
 QSTizOiJ3+1+X4M4vNVuFDhyrFHIyEC6J5N+KjB4xN5QRIS7IucKJckB+E97XtsizWvIxW8lo
 VhhnTKfloKpR9a+d/XPRUD75K1XJy8WNFHd1hD6IVslEYt5vCKl9oJP+/aG/ASJPUlb9Je2Pu
 MKD0iKbHRwEmHw23m/4pFYje56g5Ds9q5TTHMfsEPtvFLi7H6lKm9RSfu8hpvUHsb3WGDeO2r
 CFW0MXcwt8Y/1vbb08FVHULLvfEcNdNiNzZGCWhuhJRgiaewN/VkjDXZvo1Is0y3UzQI5WBeY
 QshtflFfxD8bO4P9dnFCuC/NC1+kpiWW7l0XILLADO/CC2UdsBlAiNJ2mbYOwE1g5+0Ie0j7D
 HJHl7VnChUni6XKhkLQQCM9u/zsqBIzYPk0+o0TP+iJua4l/PhLvL1iejnvac7vJCC5MAb0Kz
 Totppk6pdnwX+kDzFjI6niodGLeo/0YcMnP6kPTQhKU1n+k65wMSJw94Snmoo2waxGTCT/m5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295318>

Hi,

On Fri, 20 May 2016, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Thanks for asking a great question.  I somehow expected that we
> > probe in init-db.c::create_default_files() for this when we probe
> > for case sensitivity, symlinks, etc., but apparently we don't.
> 
> Ah, we do probe by using "config" as a guinea pig file.
> 
> Of course, if you are doing network mount between systems with and
> without filemode support, the result would depend on where you did
> the "git init", so that would not help.
> 
> Which means that other probed things like symlink support and case
> sensitivity are likely to be wrong in the .git/config that the user
> may want to fix.

What we could do is to make the default config setting platform-dependent,
a la CRLF_NATIVE.

I imagine that we would want this for core.filemode, core.ignorecase and
core.symlinks.

What do you think?

Ciao,
Johannes
