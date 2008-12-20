From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email: handle email address with quoted comma
Date: Fri, 19 Dec 2008 22:48:28 -0800
Message-ID: <7vabar1gw3.fsf@gitster.siamese.dyndns.org>
References: <1229658012-9240-1-git-send-email-fengguang.wu@intel.com>
 <7vej04d5wy.fsf@gitster.siamese.dyndns.org>
 <20081219081010.GA12494@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Matt Kraai <kraai@ftbfs.org>
To: Wu Fengguang <fengguang.wu@intel.com>
X-From: git-owner@vger.kernel.org Sat Dec 20 07:49:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDvet-0002VQ-AJ
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 07:49:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752195AbYLTGsg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 01:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752186AbYLTGsg
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 01:48:36 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53840 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021AbYLTGsf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 01:48:35 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8661E1AB2B;
	Sat, 20 Dec 2008 01:48:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DB6881AB22; Sat,
 20 Dec 2008 01:48:30 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 395B3A58-CE62-11DD-A21A-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103625>

Wu Fengguang <fengguang.wu@intel.com> writes:

> Thank you for the helpful information. The patch is updated and tested

Thanks.  I'll apply but it would be nice to have an additional test script
somewhere in t/t9001-send-email.sh to protect this change from regression
by future changes.
