From: =?windows-1252?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH 00/14] numparse module: systematically tighten up integer
 parsing
Date: Tue, 24 Mar 2015 17:49:58 +0100
Message-ID: <551195B6.9040402@web.de>
References: <1426608016-2978-1-git-send-email-mhagger@alum.mit.edu>	<20150319052620.GA30645@peff.net> <xmqqk2ydjvcd.fsf@gitster.dls.corp.google.com> <55118B74.1030201@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.org>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 24 17:50:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaS2D-0004S0-RH
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 17:50:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360AbbCXQu3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2015 12:50:29 -0400
Received: from mout.web.de ([212.227.17.11]:53737 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753038AbbCXQu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 12:50:28 -0400
Received: from [192.168.178.27] ([79.253.160.236]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MOipW-1YXgLT2ISM-0067os; Tue, 24 Mar 2015 17:50:13
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <55118B74.1030201@alum.mit.edu>
X-Provags-ID: V03:K0:PC3iwIqJFTdRbfzh86Q5yVOr4+fZvGbAliTMzkw7az/8IOjNkAE
 KnX9Bz0AlVm6A9Vs7nF/AjOEObwo5FYEpsgMgk7mr8y1gxzNwSp7mJbrqmm13aAhbNhGAT9
 UqY3apn3uADNFG7phiaBOwgvvXwG4X1wUXaTmkFnQA3VxMgUusPH55FyZe1Lk1qELPx2UA2
 HxToUHnPNnBdcKh2DMxgQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266199>

Am 24.03.2015 um 17:06 schrieb Michael Haggerty:
> Parsing numbers is not rocket science, but there are a lot of pitfall=
s,
> especially around overflow. It's even harder to write such code via
> macros and the result is less readable.
>
> This patch series is mostly about finding a reasonable API and whippi=
ng
> the callers into shape. That seems ambitious enough for me. I'd rathe=
r
> stick with boring wrappers for now and lean on strtol()/strtoul() to =
do
> the dirty work. It will be easy for a motivated person to change the
> implementation later.

The OpenBSD developers invented strtonum for that.  Are you aware of it=
?=20
  Would it fit?  This discussion may be useful:

	http://www.tedunangst.com/flak/post/the-design-of-strtonum

Ren=E9
