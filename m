From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] [git-p4] Make it possible to abort the submission of a
 change to Perforce
Date: Wed, 27 Aug 2008 12:20:57 -0700
Message-ID: <7vk5e2p8me.fsf@gitster.siamese.dyndns.org>
References: <200808270937.10577.simon@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Simon Hausmann <simon@lst.de>
X-From: git-owner@vger.kernel.org Wed Aug 27 21:22:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYQao-0002pT-Pm
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 21:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752732AbYH0TVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 15:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752713AbYH0TVF
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 15:21:05 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62516 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394AbYH0TVE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 15:21:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 372886A172;
	Wed, 27 Aug 2008 15:21:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 794556A171; Wed, 27 Aug 2008 15:20:59 -0400 (EDT)
In-Reply-To: <200808270937.10577.simon@lst.de> (Simon Hausmann's message of
 "Wed, 27 Aug 2008 09:30:29 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 495E58EE-746D-11DD-93F8-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93928>

Simon Hausmann <simon@lst.de> writes:

> Currently it is not possible to skip the submission of a change to Perforce
> when running git-p4 submit. This patch compares the modification time before
> and after the submit editor invokation and offers a prompt for skipping if
> the submit template file was not saved.

Applied, thanks.

It makes one wonder if mtime is a reliable enough indication or you are
better off comparing the contents, though.  The message file the user is
editing is not that big anyway, no?
