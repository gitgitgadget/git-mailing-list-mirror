From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] parse_options: Add flag to prevent errors for
 further processing
Date: Mon, 23 Jun 2008 12:55:00 -0700
Message-ID: <7v4p7khqp7.fsf@gitster.siamese.dyndns.org>
References: <1213758236-979-1-git-send-email-shawn.bohrer@gmail.com>
 <1213758236-979-2-git-send-email-shawn.bohrer@gmail.com>
 <7v1w2v2zsh.fsf@gitster.siamese.dyndns.org>
 <20080618033010.GA19657@sigill.intra.peff.net>
 <7vwskn1g2p.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0806181709300.6439@racer>
 <7v8wx2zibp.fsf@gitster.siamese.dyndns.org>
 <20080619142527.GA8429@mediacenter>
 <alpine.DEB.1.00.0806221953470.6439@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Bohrer <shawn.bohrer@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, madcoder@debian.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 23 21:56:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAs9X-0004jq-8d
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 21:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758620AbYFWTzO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 15:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754917AbYFWTzO
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 15:55:14 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38793 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754617AbYFWTzM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 15:55:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B82EE4BC5;
	Mon, 23 Jun 2008 15:55:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D428E4BC3; Mon, 23 Jun 2008 15:55:04 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0806221953470.6439@racer> (Johannes
 Schindelin's message of "Sun, 22 Jun 2008 20:07:18 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4988CFBC-415E-11DD-B8AD-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85910>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 19 Jun 2008, Shawn Bohrer wrote:
>
>> On Wed, Jun 18, 2008 at 11:52:42AM -0700, Junio C Hamano wrote:
> I believe not.  I think that Junio prefers some callback that can handle a 
> whole bunch of options (as opposed to the callback we can have now, to 
> handle arguments for a specific option).

Sorry, no.  I do not want callbacks.  I've been saying that parser
cascading is easier if you use an incremental interface like diff option
parser does.
