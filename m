From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email: add a new sendemail.cc configuration
 variable
Date: Sun, 27 Apr 2008 13:26:48 -0700
Message-ID: <7vprsbf3hz.fsf@gitster.siamese.dyndns.org>
References: <1209244746-12649-1-git-send-email-vmiklos@frugalware.org>
 <alpine.DEB.1.00.0804262330370.7944@eeepc-johanness>
 <20080426232737.GR4012@genesis.frugalware.org>
 <alpine.DEB.1.00.0804271252200.16320@eeepc-johanness>
 <20080427121458.GU4012@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Apr 27 22:28:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqDTn-0007oX-0y
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 22:28:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758368AbYD0U1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 16:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764319AbYD0U1G
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 16:27:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61966 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbYD0U1E (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 16:27:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8A4F04D8C;
	Sun, 27 Apr 2008 16:27:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id D3FEB4D89; Sun, 27 Apr 2008 16:26:53 -0400 (EDT)
In-Reply-To: <20080427121458.GU4012@genesis.frugalware.org> (Miklos Vajna's
 message of "Sun, 27 Apr 2008 14:14:58 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80484>

Miklos Vajna <vmiklos@frugalware.org> writes:

> Some projects prefer to always CC patches to a given mailing list. In
> these cases, it's handy to configure that address once.
>
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
>
> On Sun, Apr 27, 2008 at 12:53:34PM +0100, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> > Yes and no. :-) I first searched for a --cc option in send-email,
>> > then
>> > realized that only format-patch has one.
>>
>> You are completely correct, sorry.  Hmm.  I would have preferred
>> send-email inserting that header, oh well.
>
> Heh, no. git-send-email has a --cc option as well, just it was not
> configurable. Here is a one-liner which does the trick.

Thanks, the idea makes sense.

Tests?
