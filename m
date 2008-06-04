From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] describe match pattern for soft tags too
Date: Tue, 03 Jun 2008 23:04:55 -0700
Message-ID: <7vy75lzqew.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.10.0806031957360.3605@pollux>
 <20080603224839.GO12896@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Dressel <MichaelTiloDressel@t-online.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jun 04 08:06:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3m8p-0006iW-0P
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 08:06:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbYFDGFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 02:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbYFDGFH
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 02:05:07 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52424 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbYFDGFF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 02:05:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EBD4B34D0;
	Wed,  4 Jun 2008 02:05:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 12DAD34CC; Wed,  4 Jun 2008 02:04:58 -0400 (EDT)
In-Reply-To: <20080603224839.GO12896@spearce.org> (Shawn O. Pearce's message
 of "Tue, 3 Jun 2008 18:48:39 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2BEE1B04-31FC-11DD-A5EE-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83745>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Michael Dressel <MichaelTiloDressel@t-online.de> wrote:
>> 
>> So far git describe --match <pattern> would apply the <pattern> only
>> to tag objects not to soft tags. This change make describe apply
>> the <pattern> to soft tags too.
>
> Whoops.

Micronit.  They are called "lightweight" tags.  There aren't any hard tags
either.

> Signed-off-by tag?
>
> Assuming you supply Junio an SBO tag,
>
> Acked-by: Shawn O. Pearce <spearce@spearce.org>

Thanks for proofreading.
