From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/5] i18n: mark relative dates for translation
Date: Thu, 15 Mar 2012 14:18:46 -0500
Message-ID: <20120315191846.GA23731@burratino>
References: <1331198198-22409-1-git-send-email-pclouds@gmail.com>
 <1331198198-22409-3-git-send-email-pclouds@gmail.com>
 <20120315185102.GA4636@burratino>
 <4F623FF8.1040507@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Mar 15 20:19:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8GCR-0000ks-SN
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 20:19:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031621Ab2COTSz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Mar 2012 15:18:55 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61072 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031761Ab2COTSy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 15:18:54 -0400
Received: by iagz16 with SMTP id z16so4272732iag.19
        for <git@vger.kernel.org>; Thu, 15 Mar 2012 12:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=eaoSusFp8Icdx+3hJuf1D6v/w5IzsJc6GSuUUXfcGyE=;
        b=nJd8JCPbKzpYO2RYK5ycAlV7ywgn1eEgraeBHL4K0WrRhsDYnsFaR3LPKqQIMsN/v4
         irMRznf+AGJIbY++2Hv/STojJ3ehWK7mZwVVF9tHK5dcDPiBOE05dqRQpZfDspXHKjw6
         C/lKXYWXt10hFrNb68WACltFFEomOW4BSKlVvrvIuVbiXAE4Ym7Gx1SODqs0Sz9s8IXG
         gtPdK4cGo6Xb2sQeHoQk+QswGdW9plLSH82wSb142wl9W5O3LBo+CJgvkgchwuRauYal
         lnMmzteXLPfqnoUq0Nis4Hz0ujQwX9j6m+D8aLts9hLq2u3yu70dolClcoFOl1Y6Q9FF
         dK0A==
Received: by 10.42.155.7 with SMTP id s7mr7635408icw.45.1331839133615;
        Thu, 15 Mar 2012 12:18:53 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id hq3sm4581077igc.0.2012.03.15.12.18.52
        (version=SSLv3 cipher=OTHER);
        Thu, 15 Mar 2012 12:18:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4F623FF8.1040507@kdbg.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193223>

Johannes Sixt wrote:
> Am 15.03.2012 19:51, schrieb Jonathan Nieder:

>> @@ -141,40 +142,42 @@ const char *show_date_relative(unsigned long time, int tz,
>>  		unsigned long years = totalmonths / 12;
>>  		unsigned long months = totalmonths % 12;
>>  		if (months) {
>>  			struct strbuf sb = STRBUF_INIT;
>>  			strbuf_addf(&sb, Q_("%lu year", "%lu years", years), years);
>>  			/* TRANSLATORS: "%s" is "<n> years" */
>> -			snprintf(timebuf, timebuf_size,
>> +			strbuf_addf(timebuf,
>
> OT: You have 6 lines of context here, unlike all other hunks, which have
> only 3 lines. Something weird or simple to explain?

Just manual patch mangling. ;-)
