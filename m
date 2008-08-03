From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] Fix 'url.*.insteadOf' for submodule URLs
Date: Sun, 03 Aug 2008 16:57:28 -0700
Message-ID: <7vsktl7itz.fsf@gitster.siamese.dyndns.org>
References: <200808040057.00221.johan@herland.net>
 <alpine.DEB.1.00.0808040126170.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 04 01:58:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPnTD-0005tO-QD
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 01:58:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647AbYHCX5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 19:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752688AbYHCX5g
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 19:57:36 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38989 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270AbYHCX5f (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 19:57:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1456149D21;
	Sun,  3 Aug 2008 19:57:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4703249D1E; Sun,  3 Aug 2008 19:57:30 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0808040126170.9611@pacific.mpi-cbg.de.mpi-cbg.de> (Johannes
 Schindelin's message of "Mon, 4 Aug 2008 01:27:53 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F0F82DFA-61B7-11DD-94BC-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91295>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 4 Aug 2008, Johan Herland wrote:
>
>> As suggested in a thread some time ago, one could redefine the URL used 
>> to fetch submodules by adding a 'url.*.insteadOf' rule prior to the 
>> first invocation of 'git submodule update'.
>
> If I suggested it, but forgot the "--global" flag to "git config", I 
> apologize.

That's a nice way to say that the patchset is unnecessary ;-).
