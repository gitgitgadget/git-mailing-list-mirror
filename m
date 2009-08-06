From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: confirm on empty mail subjects
Date: Wed, 05 Aug 2009 23:25:11 -0700
Message-ID: <7vhbwlpigo.fsf@alter.siamese.dyndns.org>
References: <1249490994-23455-1-git-send-email-jengelh@medozas.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jan Engelhardt <jengelh@medozas.de>
X-From: git-owner@vger.kernel.org Thu Aug 06 08:25:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYwPm-0004Wg-Qz
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 08:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753848AbZHFGZR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 02:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752506AbZHFGZR
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 02:25:17 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58759 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496AbZHFGZP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 02:25:15 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 29F941F85B;
	Thu,  6 Aug 2009 02:25:16 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 321431F85A; Thu,  6 Aug 2009
 02:25:12 -0400 (EDT)
In-Reply-To: <1249490994-23455-1-git-send-email-jengelh@medozas.de> (Jan
 Engelhardt's message of "Wed\,  5 Aug 2009 18\:49\:54 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E7D8EBC2-8251-11DE-B934-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jan Engelhardt <jengelh@medozas.de> writes:

> When the user forgot to enter a subject in a compose session,
> send-email will now inquire whether this is really intended, similar
> to what the Alpine MUA does when a subject is absent.

This seems to break t9001...
