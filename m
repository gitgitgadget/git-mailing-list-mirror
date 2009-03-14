From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Add a test for checking whether gitattributes is
 honored by checkout.
Date: Fri, 13 Mar 2009 21:36:09 -0700
Message-ID: <7vljr8g1qe.fsf@gitster.siamese.dyndns.org>
References: <49B8DD1D.3060908@viscovery.net>
 <1236950656-1967-2-git-send-email-kristian.amlie@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kristian Amlie <kristian.amlie@nokia.com>
X-From: git-owner@vger.kernel.org Sat Mar 14 05:37:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiLd3-0003ME-I6
	for gcvg-git-2@gmane.org; Sat, 14 Mar 2009 05:37:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbZCNEgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2009 00:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbZCNEgP
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Mar 2009 00:36:15 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38691 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbZCNEgP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2009 00:36:15 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6F4F96B08;
	Sat, 14 Mar 2009 00:36:13 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D2DFE6B07; Sat,
 14 Mar 2009 00:36:10 -0400 (EDT)
In-Reply-To: <1236950656-1967-2-git-send-email-kristian.amlie@nokia.com>
 (Kristian Amlie's message of "Fri, 13 Mar 2009 14:24:15 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A63339EC-1051-11DE-AC13-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113234>

Please do not waste new tests for these.  I think they can be added to
t0020-crlf.sh or t0021-conversion.sh.
