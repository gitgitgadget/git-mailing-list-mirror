From: "Matt Seitz (matseitz)" <matseitz@cisco.com>
Subject: Re: git send-email should not allow 'y' for in-reply-to
Date: Fri, 11 Jan 2013 20:13:57 +0000
Message-ID: <A0DB01D693D8EF439496BC8B037A0AEF322039A7@xmb-rcd-x15.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 11 21:25:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtlAE-0002Es-Pd
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 21:25:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754409Ab3AKUY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2013 15:24:59 -0500
Received: from rcdn-iport-9.cisco.com ([173.37.86.80]:21153 "EHLO
	rcdn-iport-9.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753552Ab3AKUY6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Jan 2013 15:24:58 -0500
X-Greylist: delayed 649 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Jan 2013 15:24:58 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=687; q=dns/txt; s=iport;
  t=1357935898; x=1359145498;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=dANx03nHkuickgXpQdTGdyugmsB1Hcb+EJNoLWmBfwI=;
  b=Irm3rC3gONe1jIBVIuxEPYGlIuzZjrW+lbnro19c40IJ0zQHOBP4sMJp
   XNJrqAsDYnIdbeZ5Lpa7oEPgOgSisyJn34/aS+zLG6/sSLuWbbbM1a77q
   45JRf8ecjIn8s4wuA3X6rbO27UvS2bLUeKSmVBVVwxCCBcl2VSws9aicg
   k=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AkQFAF9y8FCtJV2d/2dsb2JhbABEhXK4EBZzgh4BAQEEOlEBCBgKFEImAQQTCBKHfgGXIp8WjG6DV2EDplSCdYFvNQ
X-IronPort-AV: E=Sophos;i="4.84,453,1355097600"; 
   d="scan'208";a="158520040"
Received: from rcdn-core-6.cisco.com ([173.37.93.157])
  by rcdn-iport-9.cisco.com with ESMTP; 11 Jan 2013 20:13:59 +0000
Received: from xhc-rcd-x01.cisco.com (xhc-rcd-x01.cisco.com [173.37.183.75])
	by rcdn-core-6.cisco.com (8.14.5/8.14.5) with ESMTP id r0BKDxlE015407
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Fri, 11 Jan 2013 20:13:59 GMT
Received: from xmb-rcd-x15.cisco.com ([169.254.5.248]) by
 xhc-rcd-x01.cisco.com ([173.37.183.75]) with mapi id 14.02.0318.004; Fri, 11
 Jan 2013 14:13:58 -0600
Thread-Topic: git send-email should not allow 'y' for in-reply-to
Thread-Index: Ac3wOC7tNZkcC6jpT4OkjYlm77CfXQ==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [171.71.137.42]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213242>

"Jeff King" <peff@peff.net> wrote in message news:<20130111185417.GA12852@sigill.intra.peff.net>...
> On Fri, Jan 11, 2013 at 10:43:39AM -0800, Hilco Wijbenga wrote:
> 
> 
> > How about "What Message-ID to use as In-Reply-To for the first email?"
> > or "Provide the Message-ID to use as In-Reply-To for the first
> > email:".
> 
> seem fine to me. Maybe somebody who has been confused by it can offer
> more. At any rate, patches welcome.

Suggestion: "Message-ID to use as In-Reply-To for the first email:".

Simple and unlikely to generate a "y" or "n" response.  Putting "Message-ID" first makes it more obvious what data is being asked for by this prompt.
