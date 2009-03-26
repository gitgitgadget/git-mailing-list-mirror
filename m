From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 3/8] Documentation: rename docbook-xsl-172 attribute to
   git-asciidoc-no-roff
Date: Thu, 26 Mar 2009 19:49:02 +0100
Message-ID: <49CBCE1E.8070408@drmicha.warpmail.net>
References: <1237881866-5497-1-git-send-email-chris_johnsen@pobox.com> <1237881866-5497-4-git-send-email-chris_johnsen@pobox.com> <20090324090440.GC1799@coredump.intra.peff.net> <B70DE0F1-8CDA-46FC-9EF8-41B0FAC39631@pobox.com> <20090326094322.GB14292@coredump.intra.peff.net> <7vocvop6x2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Chris Johnsen <chris_johnsen@pobox.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 19:50:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmuf6-00048W-8a
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 19:50:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758872AbZCZStN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 14:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758080AbZCZStM
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 14:49:12 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:47553 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756289AbZCZStM (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Mar 2009 14:49:12 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 07DA72FE735;
	Thu, 26 Mar 2009 14:49:10 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 26 Mar 2009 14:49:10 -0400
X-Sasl-enc: 8nZ6Q6fPrrx2bh6wiiyLekwlUB9Dtn7QnVsG2aimWnoo 1238093349
Received: from localhost.localdomain (p4FC63417.dip0.t-ipconnect.de [79.198.52.23])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0EF331C856;
	Thu, 26 Mar 2009 14:49:08 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090326 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <7vocvop6x2.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114808>

Junio C Hamano venit, vidit, dixit 26.03.2009 17:47:
> Jeff King <peff@peff.net> writes:
> 
>> On Tue, Mar 24, 2009 at 02:48:52PM -0500, Chris Johnsen wrote:
>>
>>> I am not opposed to providing more version-specific controls, but I am not 
>>> sure which versions are important enough to justify their own variables. 
>>> Are you indicating that 1.73 is important enough because it was a "return 
>>> to sanity" after 1.72?
>>
>> No, mainly because it is what is shipped in the last version of Debian,
>> which means it is a major enough version that there will be a lot of
>> people using it.
>>
>> But let's just start with adding the tweakable knobs (which your series
>> is already doing), and see in what ways they need to be tweaked for
>> popular platforms before going overboard.
> 
> When I was trying out the series yesterday, I was wondering if this is
> something we can autodetect.
> 
> Output from "asciidoc --version" is easily machine parsable for giving
> asciidoc7compatible aka ASCIIDOC8, but I couldn't come up with anything
> simpler than probing a few hardcoded paths under /usr/share/sgml; that
> approach is unacceptable because would not work if your stylesheets are in
> somewhere we do not know about.  Ideally, we should be able to ask the
> tools we invoke (e.g. xmlto) to get that information.

Maybe run asciidoc/xmlto on a minimal test file and check the output?
"autoconf lite", so to say.

Michael
