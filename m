From: viresh kumar <viresh.kumar@st.com>
Subject: Re: Query: Patches break with Microsoft exchange server.
Date: Thu, 12 Aug 2010 10:11:07 +0530
Message-ID: <4C637B63.1060404@st.com>
References: <4C5F9B25.8080401@st.com> <AANLkTinxwRFLUibJECm0c3_oL5mYRkmscsw-xXgAHSTe@mail.gmail.com> <4C624AE1.30504@st.com> <4C62C5BD.3020808@mnsu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" 
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Justin P. Mattock" <justinmattock@gmail.com>,
	=?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
	<u.kleine-koenig@pengutronix.de>,
	Valeo de Vries <valeo@valeo.co.cc>,
	Linus Walleij <linus.ml.walleij@gmail.com>,
	Matti Aarnio <matti.aarnio@zmailer.org>,
	"mihai.dontu@gmail.com" <mihai.dontu@gmail.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"Gadiyar, Anand" <gadiyar@ti.com>
To: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
X-From: linux-kernel-owner@vger.kernel.org Thu Aug 12 06:42:21 2010
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1OjPcS-0005lY-Sv
	for glk-linux-kernel-3@lo.gmane.org; Thu, 12 Aug 2010 06:42:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481Ab0HLEmJ (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 12 Aug 2010 00:42:09 -0400
Received: from eu1sys200aog115.obsmtp.com ([207.126.144.139]:55609 "EHLO
	eu1sys200aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751225Ab0HLEmG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2010 00:42:06 -0400
Received: from source ([138.198.100.35]) (using TLSv1) by eu1sys200aob115.postini.com ([207.126.147.11]) with SMTP
	ID DSNKTGN7ifP28un52PM/6YhQ7VrFgEmzSY9N@postini.com; Thu, 12 Aug 2010 04:42:06 UTC
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id AADFB129;
	Thu, 12 Aug 2010 04:41:14 +0000 (GMT)
Received: from Webmail-ap.st.com (eapex1hubcas1.st.com [10.80.176.8])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6F6AF96C;
	Thu, 12 Aug 2010 04:41:14 +0000 (GMT)
Received: from [10.199.82.92] (10.199.82.92) by Webmail-ap.st.com
 (10.80.176.7) with Microsoft SMTP Server (TLS) id 8.2.234.1; Thu, 12 Aug 2010
 12:41:13 +0800
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <4C62C5BD.3020808@mnsu.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153337>

 On 8/11/2010 9:16 PM, Jeffrey Hundstad wrote:
> Hello,
>
> Exchange 2010 does not handle IMAP "chunking" (partial message transfer) 
> correctly.  Any request after about 1 megabyte of total message size 
> will fail.
>
> Thunderbird uses this "chunking" feature to give you a status update 
> while downloading large messages.  The IMAP statements are of this type:
> 11 UID fetch 244477 (UID RFC822.SIZE BODY[]<20480.12288>)
>
> When the 20480 is larger than 1MB Exchange "claims" there is no more.  
> Sigh....
>
> Fortunately you can disable this feature.  To disable this in 
> Thunderbird you can go to the Advanced configuration and disable the 
> following feature, by setting it to false:
> mail.server.default.fetch_by_chunks
Jeffrey,

I tried this but problem is still there.

viresh.
