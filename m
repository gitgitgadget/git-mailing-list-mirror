From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Teach git mergetool to use custom commands defined
 at config time
Date: Sat, 16 Feb 2008 17:15:42 -0800
Message-ID: <7vbq6g758h.fsf@gitster.siamese.dyndns.org>
References: <20080216185349.GA29177@hashpling.org>
 <CD749541-1B3B-4EA7-82A5-0DFC67B953BE@zib.de>
 <20080217002029.GA504@hashpling.org>
 <alpine.LSU.1.00.0802170045210.30505@racer.site>
 <20080217005620.GB504@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Charles Bailey <charles@hashpling.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Feb 17 02:17:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQY9j-0002nd-Re
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 02:17:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753479AbYBQBQu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 20:16:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753528AbYBQBQt
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 20:16:49 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33508 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753435AbYBQBQt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 20:16:49 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0BE5F6053;
	Sat, 16 Feb 2008 20:16:48 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 3BC926050; Sat, 16 Feb 2008 20:16:40 -0500 (EST)
In-Reply-To: <20080217005620.GB504@hashpling.org> (Charles Bailey's message
 of "Sun, 17 Feb 2008 00:56:20 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74089>

Charles Bailey <charles@hashpling.org> writes:

> On Sun, Feb 17, 2008 at 12:46:15AM +0000, Johannes Schindelin wrote:
>> 
>> So you'd rather have the end users do the same work for the same tool over 
>> and over again?
>
> I'm sorry, I should have made myself clearer. I disagree that the
> approach of adding new tool support to the source code as and when they
> are encountered is optimal. I believe that it is preferable to have a
> solution that allows users to configure, rather then code, support for
> their own tools that do not to have native support.
>
> I do not disagree that there is benefit to having a wide range of
> tools that are supported natively.
>
> I thought I made a reasonable argument for this in the rest of my
> email that you took the headline from, but evidently I came across as
> muddled.

I do not understand why people are so upset about this.  I think
the approach Charles's patch takes is reasonable, with example
configurations to coax a few of his tools to be driven by
mergetool as backends, that demonstrate the customizing
framework works well.

It of course would also be good to throw in the native support
for the tools he used as examples but I'd say that they are
topics of separate patches.
