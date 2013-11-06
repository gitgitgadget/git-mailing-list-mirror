From: Max Horn <max@quendi.de>
Subject: Re: [PATCH v3 2/2] Rename suffixcmp() to has_suffix() and invert its result
Date: Thu, 7 Nov 2013 00:53:55 +0100
Message-ID: <11C89E15-B6DE-4FE4-9135-0841CFAE92A4@quendi.de>
References: <20131105210237.21525.61810.chriscool@tuxfamily.org> <20131106221735.GB10302@google.com> <61456C34-834F-4E7B-89D2-9DB45690C9ED@quendi.de> <20131106232805.GD10302@google.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 07 00:54:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeCvQ-0001UT-UH
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 00:54:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705Ab3KFXyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Nov 2013 18:54:13 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:50932 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751365Ab3KFXyM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Nov 2013 18:54:12 -0500
Received: from ip-178-202-253-6.unitymediagroup.de ([178.202.253.6] helo=[192.168.178.22]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1VeCv9-0000v1-2z; Thu, 07 Nov 2013 00:53:59 +0100
In-Reply-To: <20131106232805.GD10302@google.com>
X-Mailer: iPhone Mail (11B511)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1383782052;022f1a93;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237386>



> Am 07.11.2013 um 00:28 schrieb Jonathan Nieder <jrnieder@gmail.com>:
> 
> Max Horn wrote:
> 
>> Well, unlike suffixcmp, it is transitive, so it could be used for sorting.
> 
> It is not antisymmetric.
> 
>    prefixcmp("foo", "foobar") < 0
>    prefixcmp("foobar", "foo") == 0

Right! I wasn't thinkinh :-(
> 
> I can see how it's possible to care about the sign of the return
> value, but it's equally possible to care about the sign from
> suffixcmp.  Neither is suitable as a function for passing to qsort.

Yeah, so then I'd be for changing rhis one to has_prefix.


> 
> Hoping that clarifies,
> Jonathan
> 
