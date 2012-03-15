From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/5] i18n: mark relative dates for translation
Date: Thu, 15 Mar 2012 20:16:08 +0100
Message-ID: <4F623FF8.1040507@kdbg.org>
References: <1331198198-22409-1-git-send-email-pclouds@gmail.com> <1331198198-22409-3-git-send-email-pclouds@gmail.com> <20120315185102.GA4636@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 20:16:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8G9p-0006cd-D8
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 20:16:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965351Ab2COTQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Mar 2012 15:16:12 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:54139 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965311Ab2COTQM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 15:16:12 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 43FB413004E;
	Thu, 15 Mar 2012 20:16:09 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id C2ACB19F479;
	Thu, 15 Mar 2012 20:16:08 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.27) Gecko/20120215 SUSE/3.1.19 Thunderbird/3.1.19
In-Reply-To: <20120315185102.GA4636@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193222>

Am 15.03.2012 19:51, schrieb Jonathan Nieder:
> @@ -141,40 +142,42 @@ const char *show_date_relative(unsigned long time, int tz,
>  		unsigned long years = totalmonths / 12;
>  		unsigned long months = totalmonths % 12;
>  		if (months) {
>  			struct strbuf sb = STRBUF_INIT;
>  			strbuf_addf(&sb, Q_("%lu year", "%lu years", years), years);
>  			/* TRANSLATORS: "%s" is "<n> years" */
> -			snprintf(timebuf, timebuf_size,
> +			strbuf_addf(timebuf,

OT: You have 6 lines of context here, unlike all other hunks, which have
only 3 lines. Something weird or simple to explain?

-- Hannes
