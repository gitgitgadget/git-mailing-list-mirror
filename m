From: Junio C Hamano <gitster@pobox.com>
Subject: Re: question: how to ignore extral CR when diff dos format files
 with 'color=auto'
Date: Tue, 26 Aug 2008 21:54:51 -0700
Message-ID: <7v63pnt5us.fsf@gitster.siamese.dyndns.org>
References: <1219728743111-783231.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: goooguo <erwangg@fortemedia.com.cn>
X-From: git-owner@vger.kernel.org Wed Aug 27 06:56:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYD4l-0006fj-AD
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 06:56:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbYH0EzB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 00:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbYH0EzA
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 00:55:00 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58297 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012AbYH0EzA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 00:55:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C2E41698AE;
	Wed, 27 Aug 2008 00:54:59 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 538AF698AA; Wed, 27 Aug 2008 00:54:55 -0400 (EDT)
In-Reply-To: <1219728743111-783231.post@n2.nabble.com>
 (erwangg@fortemedia.com.cn's message of "Mon, 25 Aug 2008 22:32:23 -0700
 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4D55F886-73F4-11DD-9DD8-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93854>

goooguo <erwangg@fortemedia.com.cn> writes:

> git-diff prints "^M" at each end of line for dos format files when
> 'color=auto'.
>
> it's annoying!

"man git-config" and learn about core.whitespace perhaps?
