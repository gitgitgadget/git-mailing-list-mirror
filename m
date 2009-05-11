From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: use --textconv to generate diff text
Date: Mon, 11 May 2009 14:20:17 -0700
Message-ID: <7vk54n9w1a.fsf@alter.siamese.dyndns.org>
References: <4A07D160.9020709@viscovery.net>
	<20090511091346.GA5685@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 11 23:20:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3cvJ-0002LB-2f
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 23:20:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759764AbZEKVUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 17:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759760AbZEKVUS
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 17:20:18 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:38070 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759759AbZEKVUR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 17:20:17 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090511212018.NNBT20976.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Mon, 11 May 2009 17:20:18 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id qMLH1b00G4aMwMQ04MLHAs; Mon, 11 May 2009 17:20:17 -0400
X-Authority-Analysis: v=1.0 c=1 a=4bx7SMiv7XcA:10 a=e55H4uVQSdEA:10
 a=PKzvZo6CAAAA:8 a=A9qS8gIqAAAA:8 a=J3TjgM65XiX34CC1DC8A:9
 a=LP8VFycbTvc2JBirbcvN0eVNF_AA:4 a=OdWmie4EkE0A:10 a=Kj4G0JfAssAA:10
X-CM-Score: 0.00
In-Reply-To: <20090511091346.GA5685@coredump.intra.peff.net> (Jeff King's message of "Mon\, 11 May 2009 05\:13\:47 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118850>

Jeff King <peff@peff.net> writes:

> On Mon, May 11, 2009 at 09:18:56AM +0200, Johannes Sixt wrote:
>
>> For the most part gitk's focus is on showing history and changes in
>> a human readable form. For this reason, it makes sense to generate
>> the patch text in the diff view using --textconv so that textconv drivers
>> are used if they are defined.
>> 
>> gitk can also generate patches, but we do not use --textconv because
>> such patches could not be applied.
>> 
>> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
>
> As the original author of the textconv code, I am in favor of this.

I agree; I think textconv is meant for this kind of usage.
