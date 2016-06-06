From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] regex: fix a SIZE_MAX macro redefinition warning
Date: Mon, 6 Jun 2016 08:57:10 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1606060856230.28610@virtualbox>
References: <575212DF.90209@ramsayjones.plus.com> <alpine.DEB.2.20.1606050815360.4250@virtualbox> <57542A85.3040206@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 08:57:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9oTc-00041O-SG
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 08:57:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751412AbcFFG53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 02:57:29 -0400
Received: from mout.gmx.net ([212.227.17.20]:51432 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751243AbcFFG52 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 02:57:28 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MCfcc-1bJC8o1WB0-009U4I; Mon, 06 Jun 2016 08:57:12
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <57542A85.3040206@ramsayjones.plus.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:ahQcQdvLEhYq7DfK3u5j/Mfhna6imPNnGkoBkb/hqVB3Uyi5/38
 WdShgrIfc32YMI+xZSblq4EdfHFEZfrehU5Ugt2JFmLl+fOuW+g8BZgYmqNuiWmA1iVy+mm
 iLpdX6vToQr7m4OgBHLnJd6AbAXweF5hbJEUlCUgz/6cz3TBw1ZLRWVcFeV72lNc3mllT7u
 uID8nBFMh5In/7mp5zaqQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Pvd299YUZ6A=:Dp/vyFoOqqTT8nr/2ylS5u
 L4ggrES16dnKs8WSZHwqOkh6bmPJHQ8onCuwB8ScN/8BHsLNGbJdO01lQjYCX4KeMmgLlioUb
 WsTurWDgFcm7XDlziMvhYv12sPvzTtQxV+NOknvpHHR2ros3ynS31vl4Tx1VN6h1XEFtVzC9W
 Auhw7zOAPvDgzwZc1ZaegMmWeuHUo6X22Qeerr8Vfrb2kxPI8+3q38lYUdsOxFz+3CRMgPqR+
 ckDaJCV4ZyxzRTIvF2DLXs02TwbJ69wgzmKwW6hAmiij88QYM21ItdrK+cFerz/tEVPtqS9mz
 qkLsNCBU5FRTJmIk9/pIlxqYBZq+7MThm4JXL9aHv0bkneHs9XPcBp64JHtF9EmvNrx2qLsKM
 ooTIRvZQYvLGK1IMK3pnYFXbW+OjCc2SuACj3XhgXqzmQ2xv6AH0bCTCtAv91OsoUElp6JhC5
 oj+ZageCG87au3y3DIA5cEpJBuyiEcCYlNiVyZ0VkWUqu2hFC3Ozp+uppP/EAiuBGOeG42ipw
 +47X2qShB52sWfBGZeEtNHolAzotDPj6GVAS7MbAnIuZLefYyTXONS5gkbA11WOgWi/eOI8pU
 /lxEdJAdiKxB8RN7/I0RsYMt4wyezfsgtkIklQHk3kw4BCzfSMtxnfcSA9l28MtrYIsHT7Fxv
 g/jaJbAIQwd8ks1lqMX9dbuOu8aoCsbvVUSZ1huIU/42CCmXMo1Gg/cHeAsD1hhfL2vKE5dNB
 K4C+ZmhtgTzbXK+/i9peaLXEjdG3Twj7hne8XTJphPzS4WOs49PNdN6i7Hs+e0B3cnTXRFpZ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296485>

Hi Ramsay,

On Sun, 5 Jun 2016, Ramsay Jones wrote:

> > Other than that, I think this patch is an improvement.
> 
> Thanks. What do you think of replacing it with the original patch
> (above)?

That would work for me, too.

Thanks,
Dscho
