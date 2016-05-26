From: Yong Bakos <junk@humanoriented.com>
Subject: Re: [PATCH] transport, send-pack: append period to up-to-date message
Date: Thu, 26 May 2016 09:16:11 -0500
Message-ID: <AD23EFA5-FE44-4CE8-AD95-D95300E05B55@humanoriented.com>
References: <1464123104-45513-1-git-send-email-junk@humanoriented.com> <CAGZ79kayB59-U52oAw=13a2CAhJLsfmoD6JbAURbt0p8g8a8fg@mail.gmail.com> <20160525224733.GF13776@sigill.intra.peff.net> <xmqqy46xycg0.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>, barkalow@iabervon.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 26 16:32:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5wKY-0001wF-3d
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 16:32:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754059AbcEZOcF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 10:32:05 -0400
Received: from outmail149122.authsmtp.com ([62.13.149.122]:34536 "EHLO
	outmail149122.authsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754018AbcEZOcD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 May 2016 10:32:03 -0400
X-Greylist: delayed 904 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 May 2016 10:32:03 EDT
Received: from mail-c247.authsmtp.com (mail-c247.authsmtp.com [62.13.128.247])
	by punt24.authsmtp.com (8.14.2/8.14.2/) with ESMTP id u4QEGKXH011113;
	Thu, 26 May 2016 15:16:20 +0100 (BST)
Received: from [10.0.1.25] (cpe-76-184-32-111.tx.res.rr.com [76.184.32.111])
	(authenticated bits=0)
	by mail.authsmtp.com (8.14.2/8.14.2/) with ESMTP id u4QEGBKP096838;
	Thu, 26 May 2016 15:16:12 +0100 (BST)
In-Reply-To: <xmqqy46xycg0.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.3112)
X-Server-Quench: 66f73788-234c-11e6-bcde-0015176ca198
X-AuthReport-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCdxaQoTA1ZXUQIZ IiMZCSZGTh8kKxtQ DBNFJgxfNl8UURhQ KkJXbgcSJgdCAnRQ SnkJW1VSQFx0U2Jz YQtSIwJbfEtGWxtp UlZIQ1NNFgBqBAMB SFsaM2wFBX4meHd2 bUVqEHFaXUZ6O0B7 FElXEmUOeGVjbDMC UUENcR4GI1cfYx9F a1V+U3VeMGQObjQC El17DAgYAR5/HWxJ WAgLNkoVW1pPViUx QRxHBTwkHh9NTj0r IhoqYkYRBkcWPg0u NhM8QRcENFoeAxFT V0RAGzRQKFRp
X-Authentic-SMTP: 61633239323630.1038:706
X-AuthFastPath: 0 (Was 255)
X-AuthSMTP-Origin: 76.184.32.111/2525
X-AuthVirus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295657>

On May 25, 2016, at 5:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Jeff King <peff@peff.net> writes:
> 
>> I think messages to stderr are generally fair game for changing, even in
>> plumbing. In many cases they are also translated (and I would argue that
>> these messages probably should be translated, too).
> 
> I think I agree.  My first reaction to this thread indeed was "Why
> isn't this marked for translation?"; as to the change proposed by
> the patch itself, my reaction actually was "Meh" ;-)

Aw come one, Junio, you mean one "." doesn't excite you? :)

> 
>> That being said, CodingGuidelines says:
>> 
>>   - Do not end error messages with a full stop.
> 
> Thanks for pointing it out---I forgot about that one.
> 
> I do not think there was a concrete reason why they should not end
> with a full stop, other than "be consistent with existing ones that
> do not end with a full stop", though.
> 
>> This isn't an error message exactly, but I think it's in the same vein.
>> I will note that we have not historically been consistent here, though
>> (as evidenced by the noted message in git-merge).

Indeed, most of the output during a pull/merge/push workflow breaks the
"don't end with a full stop" guideline. I believe that this patch,
despite its candidacy for the "most insignificant patch award," is a
sane one.

Thanks for reviewing,
yong
