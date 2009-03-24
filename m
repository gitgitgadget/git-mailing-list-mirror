From: Chris Johnsen <chris_johnsen@pobox.com>
Subject: Re: [PATCH 2/8] Documentation: use parametrized manpage-base.xsl
 with manpage-{1.72,normal}.xsl
Date: Tue, 24 Mar 2009 14:42:01 -0500
Message-ID: <B7D7397E-7B3C-4124-92F1-D3A6FBA7DF1A@pobox.com>
References: <1237881866-5497-1-git-send-email-chris_johnsen@pobox.com>
 <1237881866-5497-3-git-send-email-chris_johnsen@pobox.com>
 <20090324085751.GB1799@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 24 20:43:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmCWz-0001JJ-5A
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 20:43:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759214AbZCXTlq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 15:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758912AbZCXTlq
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 15:41:46 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45613 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756116AbZCXTlp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 15:41:45 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id BBDDF8376;
	Tue, 24 Mar 2009 15:41:43 -0400 (EDT)
Received: from [192.168.1.241] (unknown [75.53.43.147]) (using TLSv1 with
 cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 467368375; Tue,
 24 Mar 2009 15:41:40 -0400 (EDT)
In-Reply-To: <20090324085751.GB1799@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.753.1)
X-Pobox-Relay-ID: CDB8B32C-18AB-11DE-96AD-C5D912508E2D-07245699!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114482>

On 2009 Mar 24, at 03:57, Jeff King wrote:
> On Tue, Mar 24, 2009 at 03:04:20AM -0500, Chris Johnsen wrote:
>
>> +<!-- manpage-1.72.xsl:
>> +     special settings for manpages rendered from asciidoc+docbook
>> +     must be used with manpage-base.xsl
>> +     handles peculiarities in docbook-xsl 1.72.0 -->
>
> Hmm. I'm not sure I understood all of the issues you ran into that you
> mentioned in the commit message (but trust me, having tried to do
> anything with docbook, I can sympathize with the frustration you
> probably felt), so maybe I am missing something. But is it not  
> possible
> to <xsl:include> manpage-base here, rather than a comment saying "Make
> sure you have already included it"?


Right. I went overboard with reworking the XSLT into "modules" for  
xmlto.

-- 
Chris
