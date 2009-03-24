From: Chris Johnsen <chris_johnsen@pobox.com>
Subject: Re: [PATCH 1/8] Documentation: move callouts.xsl to
 manpage-{base,normal}.xsl
Date: Tue, 24 Mar 2009 14:36:52 -0500
Message-ID: <B1EF04D8-8423-4794-BEFF-908C1B3DEC31@pobox.com>
References: <1237881866-5497-1-git-send-email-chris_johnsen@pobox.com>
 <1237881866-5497-2-git-send-email-chris_johnsen@pobox.com>
 <20090324085147.GA1799@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 24 20:38:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmCRr-0007og-0L
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 20:38:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758297AbZCXTgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 15:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757964AbZCXTgg
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 15:36:36 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45137 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756317AbZCXTgg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 15:36:36 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id AD09D82E9;
	Tue, 24 Mar 2009 15:36:33 -0400 (EDT)
Received: from [192.168.1.241] (unknown [75.53.43.147]) (using TLSv1 with
 cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 33A4D82E8; Tue,
 24 Mar 2009 15:36:31 -0400 (EDT)
In-Reply-To: <20090324085147.GA1799@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.753.1)
X-Pobox-Relay-ID: 14E91C7E-18AB-11DE-B079-C5D912508E2D-07245699!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114481>

On 2009 Mar 24, at 03:51, Jeff King wrote:
> On Tue, Mar 24, 2009 at 03:04:19AM -0500, Chris Johnsen wrote:
>
>>  Documentation/Makefile           |    2 +-
>>  Documentation/callouts.xsl       |   30  
>> ------------------------------
>>  Documentation/manpage-base.xsl   |   30 ++++++++++++++++++++++++++ 
>> ++++
>>  Documentation/manpage-normal.xsl |   30 ++++++++++++++++++++++++++ 
>> ++++
>>  4 files changed, 61 insertions(+), 31 deletions(-)
>>  delete mode 100644 Documentation/callouts.xsl
>>  create mode 100644 Documentation/manpage-base.xsl
>>  create mode 100644 Documentation/manpage-normal.xsl
>
> This is definitely a good change, though it would also be fine to
> actually munge the contents in the same patch rather than duplicate  
> them
> (i.e., actually _split_ callouts.xsl instead of copying it to two
> places).
>
> I think it would have been much easier to read, though, by turning on
> rename detection in format-patch (i.e., "-M"). That yields:


Thank you for looking at these. I will incorporate your feedback and  
resend in a couple of days.

I used -C -M in some early diffs to make sure it would "compress"  
like that, but I failed to do so for the final send-email.

-- 
Chris
