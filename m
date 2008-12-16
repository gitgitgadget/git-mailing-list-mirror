From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: make feature_blame return a list
Date: Mon, 15 Dec 2008 21:38:55 -0800
Message-ID: <7vabawu1ao.fsf@gitster.siamese.dyndns.org>
References: <1229352709-4663-1-git-send-email-kraai@ftbfs.org>
 <7v7i61w06k.fsf@gitster.siamese.dyndns.org> <20081216024605.GA4529@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matt Kraai <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Tue Dec 16 06:40:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCSfX-0001B5-Rk
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 06:40:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbYLPFjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 00:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbYLPFjF
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 00:39:05 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34845 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbYLPFjE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2008 00:39:04 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 360651A499;
	Tue, 16 Dec 2008 00:39:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D70AB1A5F3; Tue,
 16 Dec 2008 00:38:57 -0500 (EST)
In-Reply-To: <20081216024605.GA4529@ftbfs.org> (Matt Kraai's message of "Mon,
 15 Dec 2008 18:46:05 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D79C189A-CB33-11DD-B1F1-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103248>

Matt Kraai <kraai@ftbfs.org> writes:

> If you'd like me to resubmit my second patch, I'm happy to do so.
> Just let me know whether you prefer the resulting function to wrap its
> return values in parentheses (as is currently done by feature_grep and
> feature_pickaxe) or not.

Sure, keeping what feature_grep does is just fine.

Thanks.
