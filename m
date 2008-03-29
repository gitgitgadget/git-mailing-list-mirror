From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH 2/2] send-email: rfc2047-quote subject lines with non-ascii characters
Date: Sat, 29 Mar 2008 10:39:43 +0100
Message-ID: <200803291039.43355.robin.rosenberg.lists@dewire.com>
References: <20080328212700.GA9529@coredump.intra.peff.net> <200803291002.43768.robin.rosenberg.lists@dewire.com> <20080329091145.GA19501@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 29 10:41:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfXYr-0000vq-3R
	for gcvg-git-2@gmane.org; Sat, 29 Mar 2008 10:41:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbYC2Jkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2008 05:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbYC2Jkf
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 05:40:35 -0400
Received: from [83.140.172.130] ([83.140.172.130]:27521 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751101AbYC2Jke (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 05:40:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id D2DE28026E9;
	Sat, 29 Mar 2008 10:40:33 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xGIRinoOo+Ka; Sat, 29 Mar 2008 10:40:33 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 6FAAF802679;
	Sat, 29 Mar 2008 10:40:33 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <20080329091145.GA19501@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78461>

Den Saturday 29 March 2008 10.11.45 skrev Jeff King:
> On Sat, Mar 29, 2008 at 10:02:43AM +0100, Robin Rosenberg wrote:
> > My proof is entirely empirical. What happens is that attempting to decode
> > a non-UTF-8 string will put a unicode surrogate pair into the (now
> > Unicode) string and encoding will just encode the surrogate pair into
> > UTF-8 and not the original. As a result, the encode(decode($x)) eq $x
> > *only* if $x is a valid UTF-8 octet sequence. Why would you not get the
> > original back if you start with valid UTF-8?
>
> Because some UTF-8 sequences have multiple representations, and that

Care to give an example?

-- robon
