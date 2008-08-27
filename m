From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-shortlog hangs on bare repo without --bare option
Date: Wed, 27 Aug 2008 13:32:31 -0700
Message-ID: <7vtzd6nqqo.fsf@gitster.siamese.dyndns.org>
References: <20080827195233.GA2477@garry-thinkpad.arpnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Garry Dolley <gdolley@arpnetworks.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 22:33:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYRi8-0001n9-2W
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 22:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752751AbYH0Uck (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 16:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752286AbYH0Ucj
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 16:32:39 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33414 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233AbYH0Uch (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 16:32:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 795086A894;
	Wed, 27 Aug 2008 16:32:36 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C34376A893; Wed, 27 Aug 2008 16:32:33 -0400 (EDT)
In-Reply-To: <20080827195233.GA2477@garry-thinkpad.arpnetworks.com> (Garry
 Dolley's message of "Wed, 27 Aug 2008 12:52:33 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 48F40C5A-7477-11DD-BD2D-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93944>

Garry Dolley <gdolley@arpnetworks.com> writes:

> [garry@garry-thinkpad] ~/dev/ebay4r-bare (master) $ git shortlog -e -s
> <hang>                                                                   <----- *** It hangs here ***

Tryp typing ^D here.  I think it is operating in the filter mode.
