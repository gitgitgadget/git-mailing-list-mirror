From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v5 01/15] fast-export: avoid importing blob marks
Date: Sun, 11 Nov 2012 17:36:53 +0100
Message-ID: <509FD425.5030702@web.de>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com> <1352642392-28387-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 17:37:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXaX7-0004Mw-Vu
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 17:37:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753514Ab2KKQhD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 11:37:03 -0500
Received: from mout.web.de ([212.227.17.12]:54153 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752235Ab2KKQhB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 11:37:01 -0500
Received: from birne.lan ([195.67.191.23]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0M1XDJ-1TDJp10IhN-00tuBS; Sun, 11 Nov 2012 17:36:56 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:16.0) Gecko/20121026 Thunderbird/16.0.2
In-Reply-To: <1352642392-28387-2-git-send-email-felipe.contreras@gmail.com>
X-Provags-ID: V02:K0:cyYHqRgWm5ro9VhVgOxKuvHWwZQ+/GtVS76CaLs2srS
 H/nzC5RpgnvROEyZJ8PzuTFfeZcO49BqqEdz8BZR/ppOIMyKwP
 fm/aL12Q6gpR0Cws3WcF8pTj/2w690eTblwmZJmmdgRfO/Fykn
 LdyUavMTTOtxHmdZrwnSANBVzE1oaRUubn4USlz6KXi6EOh8UW
 llAlgNfvSkgjxb6Gf52Dg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209396>

On 11.11.12 14:59, Felipe Contreras wrote:
> test_expect_success 'test biridectionality' '
> +	echo -n > marks-cur &&
> +	echo -n > marks-new &&
Unless I messed up the patch:

Minor issue: still a typo "biridectionality"
Major issue:  "echo -n" is still not portable.

Could we simply use

touch  marks-cur  &&
touch marks-new


/Torsten
