From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 05/18] Allow demoting errors to warnings via receive.fsck.<key>
 = warn
Date: Mon, 22 Dec 2014 22:44:18 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1412222244100.21312@s15462909.onlinehome-server.info>
References: <cover.1418055173.git.johannes.schindelin@gmx.de> <d81653ce9ef73a54a71613c3e9828ad21f2391d7.1418055173.git.johannes.schindelin@gmx.de> <xmqqzjavie9l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 22 22:44:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3AmH-0000pc-Lv
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 22:44:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755728AbaLVVo3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 16:44:29 -0500
Received: from mout.gmx.net ([212.227.15.18]:61782 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755346AbaLVVo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 16:44:29 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0LyEJp-1XrImM0jwr-015X9g;
 Mon, 22 Dec 2014 22:44:19 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqzjavie9l.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:nDrOkSwzkUDEBJfawdQrL4rgy9ErQKDWM6RcidAYJFBB1fXMflm
 AkvkH71/iXUjaF9RrzH0FGXGz23Bza8UXM4rTLkPA+iv9bR0yXmWEetihVJbAz6aHd8iYrh
 VkhuEjP2YuNIahLbX2UXUQW1qY41WvbRUluKI4WuN/TLYhJr4x+7sU0GW7zxm9NIYpETs43
 oPVXFAU5wfNsegeB3qMMQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261673>

Hi Junio,

On Wed, 10 Dec 2014, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > For example, missing emails in commit and tag objects can be demoted to
> > mere warnings with
> >
> > 	git config receive.fsck.missing-email warn
> 
> No punctuations in the first and the last level of configuration
> variable names, please.  I.e. s/missing-email/missingEmail/ or
> something.

Fixed.

Ciao,
Dscho
