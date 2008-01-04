From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: try lazy read of config only once
Date: Fri, 04 Jan 2008 00:36:57 -0800
Message-ID: <7v1w8ym1g6.fsf@gitster.siamese.dyndns.org>
References: <20080104083116.GA3354@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 04 09:37:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAi3Z-0000Eu-86
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 09:37:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753733AbYADIhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 03:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753808AbYADIhG
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 03:37:06 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49651 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753127AbYADIhF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 03:37:05 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EE724E8E;
	Fri,  4 Jan 2008 03:37:04 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E69444E8B;
	Fri,  4 Jan 2008 03:36:59 -0500 (EST)
In-Reply-To: <20080104083116.GA3354@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 4 Jan 2008 03:31:16 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69563>

Thanks.  I think you can lose "if (!user_diff_tail)" there as
well.
