From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/6] strbuf: add string-chomping functions
Date: Wed, 30 Jan 2013 06:00:23 +0100
Message-ID: <5108A8E7.5080308@alum.mit.edu>
References: <20130129091434.GA6975@sigill.intra.peff.net> <20130129091540.GB9999@sigill.intra.peff.net> <5107A146.4000309@alum.mit.edu> <20130129111028.GA11055@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 30 06:00:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0Pn1-0005I2-0h
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 06:00:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857Ab3A3FA3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 00:00:29 -0500
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:48307 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750695Ab3A3FA2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Jan 2013 00:00:28 -0500
X-AuditID: 1207440d-b7f306d0000008b7-36-5108a8ebe594
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 07.C4.02231.BE8A8015; Wed, 30 Jan 2013 00:00:27 -0500 (EST)
Received: from [192.168.69.140] (p57A252DC.dip.t-dialin.net [87.162.82.220])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0U50OVE021205
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 30 Jan 2013 00:00:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <20130129111028.GA11055@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsUixO6iqPt6BUegweNTuhZdV7qZLLqnvGW0
	+NHSw2wx/9BEVgcWj52z7rJ7POvdw+jx5/weVo/Pm+QCWKK4bZISS8qCM9Pz9O0SuDN2v17H
	XHCWtWLRxb1sDYxnWLoYOTkkBEwkZm1vgLLFJC7cW88GYgsJXGaUmLGIvYuRC8g+wyTxYfZH
	sCJeAW2JL+sfM4HYLAKqEmu23QGz2QR0JRb1NIPZogJhEr2vzzFC1AtKnJz5BKxXREBW4vvh
	jWBxZoFMiY3/ljCD2MICdhLbz99nhFi2jVHi/4KV7CAJTgFriSdHtgBdxAHUoC6xfp4QRK+8
	xPa3c5gnMArMQrJiFkLVLCRVCxiZVzHKJeaU5urmJmbmFKcm6xYnJ+blpRbpGunlZpbopaaU
	bmKEhDPvDsb/62QOMQpwMCrx8C56wR4oxJpYVlyZe4hRkoNJSZR34SKOQCG+pPyUyozE4oz4
	otKc1OJDjBIczEoivApqQDnelMTKqtSifJiUNAeLkjiv2hJ1PyGB9MSS1OzU1ILUIpisDAeH
	kgTv7OVAjYJFqempFWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGgOI0vBkYqSIoHaO9hkHbe
	4oLEXKAoROspRmOO/U/anzNybP8NJIVY8vLzUqXEeVtASgVASjNK8+AWwRLZK0ZxoL+FeU+B
	VPEAkyDcvFdAq5iAVhm1sYOsKklESEk1MIZPuBETwfz3GPcfxXYxf2GrZDF9waTZ52wiAu7Z
	fwy7bnj40dSZ64/pL1WRE82pzXq+Q/XcPf7DbqnVXVWPE59/jXNZ+fV2R738mzTv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214993>

On 01/29/2013 12:10 PM, Jeff King wrote:
> On Tue, Jan 29, 2013 at 11:15:34AM +0100, Michael Haggerty wrote:
>> Please document the new functions in
>> Documentation/technical/api-strbuf.txt.  Personally I would also
>> advocate a "docstring" in the header file, but obviously that preference
>> is the exception rather than the rule in the git project :-(
> 
> Will do. I need to document the metapack functions, too, so I was thinking
> about experimenting with some inline documentation systems.

That would be great; it would make future API documentation much easier
and therefore (hopefully) more common.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
