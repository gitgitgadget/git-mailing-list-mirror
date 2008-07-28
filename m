From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Fundamental problem with relative system paths] [PATCH 2/2]
 run-command (Windows): Run dashless "git <cmd>"
Date: Sun, 27 Jul 2008 22:58:44 -0700
Message-ID: <7vvdyqv9bf.fsf@gitster.siamese.dyndns.org>
References: <1217224228-31303-1-git-send-email-prohaska@zib.de>
 <1217224228-31303-2-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Jul 28 07:59:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNLm0-0002nO-4q
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 07:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbYG1F6z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 01:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbYG1F6z
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 01:58:55 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61660 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbYG1F6z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 01:58:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 188E03F297;
	Mon, 28 Jul 2008 01:58:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D42923F296; Mon, 28 Jul 2008 01:58:46 -0400 (EDT)
In-Reply-To: <1217224228-31303-2-git-send-email-prohaska@zib.de> (Steffen
 Prohaska's message of "Mon, 28 Jul 2008 07:50:28 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 41C4E604-5C6A-11DD-9AC5-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90411>

Steffen Prohaska <prohaska@zib.de> writes:

> ...  It is either used as
> 'bin/git' (1 directory) or as 'libexec/git-core/git-*'
> (2 directories).

I thought Hannes already fixed that one; we shouldn't have the latter. 
