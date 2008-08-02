From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-name-rev: allow --name-only in combination with
 --stdin
Date: Sat, 02 Aug 2008 11:12:51 -0700
Message-ID: <7vfxpnmgkc.fsf@gitster.siamese.dyndns.org>
References: <1217510434-94979-1-git-send-email-pdebie@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailinglist <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Sat Aug 02 20:14:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPLcD-0006mu-U2
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 20:14:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754156AbYHBSNF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 14:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753738AbYHBSND
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 14:13:03 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55291 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753644AbYHBSNC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 14:13:02 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2D28A4843F;
	Sat,  2 Aug 2008 14:12:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 50F814843E; Sat,  2 Aug 2008 14:12:54 -0400 (EDT)
In-Reply-To: <1217510434-94979-1-git-send-email-pdebie@ai.rug.nl> (Pieter de
 Bie's message of "Thu, 31 Jul 2008 15:20:34 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A2C34F88-60BE-11DD-9BA5-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91163>

Pieter de Bie <pdebie@ai.rug.nl> writes:

> 	Or was there a specific reason not to allow this?

The --name-only option to the command was added in 1.5.3 cycle, but the
original focus was only to support describe.  I do not see any fundamental
reason to disallow it --- we could even say this is a bug.

I've applied the "split single line processing to a separate function" and
then this patch to 'maint' as a bugfix.
