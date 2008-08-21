From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Suggestion: "man git clone"
Date: Thu, 21 Aug 2008 13:14:41 -0700
Message-ID: <48ADCCB1.6040803@zytor.com>
References: <48ACB29C.7000606@zytor.com> <48ACB5F4.3000905@sneakemail.com> <48AD99DF.5090802@zytor.com> <32541b130808211007xf295e40l567ecf785a8fca22@mail.gmail.com> <48ADA467.1030407@zytor.com> <20080821173842.GB26920@coredump.intra.peff.net> <20080821201307.GC27705@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Avery Pennarun <apenwarr@gmail.com>,
	=?UTF-8?B?IlBldGVyIFZhbGRlbWFyIE0=?=
	 =?UTF-8?B?w7hyY2ggKExpc3RzKSI=?= <4ux6as402@sneakemail.com>,
	flucifredi@acm.org, Git ML <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 21 22:16:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWGZl-0001yf-IA
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 22:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754090AbYHUUPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 16:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754066AbYHUUPF
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 16:15:05 -0400
Received: from terminus.zytor.com ([198.137.202.10]:48777 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753784AbYHUUPE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 16:15:04 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m7LKEiMx018833
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 Aug 2008 13:14:44 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m7LKEigH028006;
	Thu, 21 Aug 2008 13:14:44 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m7LKEfXW022234;
	Thu, 21 Aug 2008 13:14:42 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <20080821201307.GC27705@coredump.intra.peff.net>
X-Virus-Scanned: ClamAV 0.93.3/8069/Thu Aug 21 10:36:55 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93198>

Jeff King wrote:
> On Thu, Aug 21, 2008 at 01:38:42PM -0400, Jeff King wrote:
> 
>> There is some configuration magic about what is a section. Try
>>
>>   perl -pi -e 's/^SECTION.*/$& git/' /etc/manpath.config
>>
>> That seems to convince my man to look in .../mangit, but I'm having
>> trouble actually getting it to find a page and I don't have time to
>> investigate further now.
> 
> Ah, OK. My problem was that the pages actually need to be named "am.git",
> etc. But with 'git' in the section field, "man git am" does work.
> Unfortunately, it seems to break "man git". :(
> 
> -Peff

Yeah, that pretty much makes it not a general solution.

	-hpa
