From: Chris Johnsen <chris_johnsen@pobox.com>
Subject: Re: [PATCH 3/8] Documentation: rename docbook-xsl-172 attribute to
 git-asciidoc-no-roff
Date: Tue, 24 Mar 2009 14:48:52 -0500
Message-ID: <B70DE0F1-8CDA-46FC-9EF8-41B0FAC39631@pobox.com>
References: <1237881866-5497-1-git-send-email-chris_johnsen@pobox.com>
 <1237881866-5497-4-git-send-email-chris_johnsen@pobox.com>
 <20090324090440.GC1799@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 24 20:50:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmCe5-00046T-Fa
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 20:50:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756499AbZCXTsk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 15:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755117AbZCXTsj
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 15:48:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61495 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754901AbZCXTsi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 15:48:38 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 77438A4FE4;
	Tue, 24 Mar 2009 15:48:35 -0400 (EDT)
Received: from [192.168.1.241] (unknown [75.53.43.147]) (using TLSv1 with
 cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8CD04A4FE3; Tue,
 24 Mar 2009 15:48:31 -0400 (EDT)
In-Reply-To: <20090324090440.GC1799@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.753.1)
X-Pobox-Relay-ID: C31DC30C-18AC-11DE-AAA6-32B0EBB1AA3C-07245699!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114483>

On 2009 Mar 24, at 04:04, Jeff King wrote:
> On Tue, Mar 24, 2009 at 03:04:21AM -0500, Chris Johnsen wrote:
>
>> It seems that the ability to use raw roff codes in asciidoc.conf
>> was eliminated by docbook-xsl 1.72.0 _and later_. Unlike the
>> 1.72.0-specific XSLT problem, this behavior was not reverted in
>> later releases.
>>
>> This patch aims to make it clear that the affected asciidoc
>> attribute (flag) can be reasonably used with docbook-xsl versions
>> other than 1.72.0.
>
> Great, this looks like a definite improvement. Should we be respecting
> more DOCBOOK_XSL_* variables than just 172, then? I.e.,:
>
>> +# For docbook-xsl ...
>> +#	-1.68.1,	set ASCIIDOC_NO_ROFF? (based on changelog from 1.73.0)
>> +#	1.69.0-1.71.1,	no extra settings are needed?
>> +#	1.72.0,		set DOCBOOK_XSL_172.
>> +#	1.73.0-,	set ASCIIDOC_NO_ROFF
>
> DOCBOOK_XSL_173, etc?
>
> I don't know that we need to cover _every_ version, but if we can have
> specific knobs for individual features (like ASCIIDOC_NO_ROFF), then
> maybe it makes sense to aggregate the settings for those knobs for  
> a few
> common versions.


I am not opposed to providing more version-specific controls, but I  
am not sure which versions are important enough to justify their own  
variables. Are you indicating that 1.73 is important enough because  
it was a "return to sanity" after 1.72?

The versions I listed in the comments were just the ones that the  
tools' documentation described as needing one adjustment or another.  
I thought the comments would be an easy way to start tracking which  
versions were "interesting".

-- 
Chris
