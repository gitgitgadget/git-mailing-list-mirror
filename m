From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH 3/3] Add filter-objects command
Date: Fri, 19 Jun 2015 12:04:08 +0100
Message-ID: <20150619110408.GA4513@hashpling.org>
References: <1434705059-2793-1-git-send-email-charles@hashpling.org>
 <1434705059-2793-4-git-send-email-charles@hashpling.org>
 <20150619101010.GA15802@peff.net>
 <20150619103324.GA4093@hashpling.org>
 <20150619105228.GR18226@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Jun 19 13:04:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5u5o-0007yF-Ux
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 13:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbbFSLEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 07:04:12 -0400
Received: from avasout06.plus.net ([212.159.14.18]:39868 "EHLO
	avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633AbbFSLEL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 07:04:11 -0400
Received: from hashpling.plus.com ([212.159.69.125])
	by avasout06 with smtp
	id iB481q0092iA9hg01B49fQ; Fri, 19 Jun 2015 12:04:09 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=foEhHwMf c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=EBOSESyhAAAA:8
 a=0Bzu9jTXAAAA:8 a=J0QyKEt1u0cA:10 a=BHUvooL90DcA:10 a=kj9zAlcOel0A:10
 a=Ew9TdX-QAAAA:8 a=XAFQembCKUMA:10 a=Pn-5SQfMXdCwiE5jNRsA:9 a=CjuIK1q_8ugA:10
Received: from charles by hashpling.plus.com with local (Exim 4.84)
	(envelope-from <charles@hashpling.plus.com>)
	id 1Z5u5g-0001BP-Mj; Fri, 19 Jun 2015 12:04:08 +0100
Content-Disposition: inline
In-Reply-To: <20150619105228.GR18226@serenity.lan>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272128>

On Fri, Jun 19, 2015 at 11:52:28AM +0100, John Keeping wrote:
> On Fri, Jun 19, 2015 at 11:33:24AM +0100, Charles Bailey wrote:
> > So, yes, performance is definitely an issue and I could have called this
> > command "git magically-generate-all-object-for-scripts" but then, as it
> > was so easy to provide exactly the filtering that I was looking for in
> > the C code, I thought I would do that as well and then "filter-objects"
> > ("filter-all-objects"?) seemed like a better name.
> 
> By analogy with "git filter-branch", I don't think "filter-objects" is a
> good name here.  My preference would be "ls-objects".

I like that because it emphasises why I wrote it, the very basic
filtering is a nice additional feature.
