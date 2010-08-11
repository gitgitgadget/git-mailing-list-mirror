From: viresh kumar <viresh.kumar@st.com>
Subject: Re: Query: Patches break with Microsoft exchange server.
Date: Wed, 11 Aug 2010 12:31:53 +0530
Message-ID: <4C624AE1.30504@st.com>
References: <4C5F9B25.8080401@st.com> <AANLkTinxwRFLUibJECm0c3_oL5mYRkmscsw-xXgAHSTe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" 
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Justin P. Mattock" <justinmattock@gmail.com>,
	=?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
	<u.kleine-koenig@pengutronix.de>,
	Valeo de Vries <valeo@valeo.co.cc>,
	Linus Walleij <linus.ml.walleij@gmail.com>,
	Matti Aarnio <matti.aarnio@zmailer.org>,
	<mihai.dontu@gmail.com>, <dwmw2@infradead.org>,
	<richardcochran@gmail.com>, "Gadiyar, Anand" <gadiyar@ti.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: linux-kernel-owner@vger.kernel.org Wed Aug 11 09:04:05 2010
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Oj5M4-00031g-Lf
	for glk-linux-kernel-3@lo.gmane.org; Wed, 11 Aug 2010 09:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752826Ab0HKHD4 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 11 Aug 2010 03:03:56 -0400
Received: from eu1sys200aog112.obsmtp.com ([207.126.144.133]:37502 "EHLO
	eu1sys200aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752037Ab0HKHDz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2010 03:03:55 -0400
Received: from source ([138.198.100.35]) (using TLSv1) by eu1sys200aob112.postini.com ([207.126.147.11]) with SMTP
	ID DSNKTGJLNdslsIw1VGOSyWoObXHYnMo1AK1r@postini.com; Wed, 11 Aug 2010 07:03:54 UTC
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 593F5157;
	Wed, 11 Aug 2010 07:01:58 +0000 (GMT)
Received: from Webmail-ap.st.com (eapex1hubcas1.st.com [10.80.176.8])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 17D338A5;
	Wed, 11 Aug 2010 07:01:58 +0000 (GMT)
Received: from [10.199.82.92] (10.199.82.92) by Webmail-ap.st.com
 (10.80.176.7) with Microsoft SMTP Server (TLS) id 8.2.234.1; Wed, 11 Aug 2010
 15:01:57 +0800
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <AANLkTinxwRFLUibJECm0c3_oL5mYRkmscsw-xXgAHSTe@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153193>

On 8/11/2010 3:34 AM, Felipe Contreras wrote:
> On Mon, Aug 9, 2010 at 9:07 AM, viresh kumar <viresh.kumar@st.com> wrote:
>> > Mail server in ST has recently changed and now we have Microsoft
>> > exchange server. We are using thunderbird as mail client.
>> > What we observed with this server is that patch are broken now while
>> > sending as well as receiving. Tabs are replaced by spaces and may
>> > be some other too which we haven't observed.
>> >
>> > Has anybody found a solution to this kind of issues? Are there any
>> > workarounds possible?
> Same in Nokia. I wrote a script to fix exchange's crap, but I also
> noticed some quoted-printable mails didn't get converted, so the
> easiest would be to tell git to always send quoted-printable.
> 

Hi Guys

The situation has changed now.
We are informed that SP2 is already in place in ST and mail client is not
doing any tampering.

When i send a mail using git send-email then it receives fine on
outlook but on thunderbird, tabs are converted to spaces.

This doesn't happen with every patch on thunderbird, but only a few.
And observation is that it happens only with big patches.
(more than 500 lines)

Any idea, how to solve issue now on thunderbird??

viresh.
