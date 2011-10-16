From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: fix error message mention --exclude
Date: Sat, 15 Oct 2011 20:27:33 -0700
Message-ID: <7v62jptt7e.fsf@alter.siamese.dyndns.org>
References: <2533ba3dbe08fc0d76c9cbc9c76bff1c4ff80d4c.1318703760.git.bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Oct 16 07:13:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFJ2D-0002mg-F5
	for gcvg-git-2@lo.gmane.org; Sun, 16 Oct 2011 07:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969Ab1JPFNN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 01:13:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51963 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751582Ab1JPFNL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 01:13:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31DE52B0B;
	Sun, 16 Oct 2011 01:13:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=oOEwoXdVZObsvXpQcq2U
	E/uFg/k4UX+ahtaFhtGSi4V522GW95O1YekfFxuCObG/tmkaaQHg303FkL+Ywtmx
	y4OK1c3wBe8S56G7GKndFgZx1DCBKyRzwAIPQoRmWjdg3x2q/qmX/23xqUuuH6Zb
	c4GaNuUr5P0YQ0U64hFUsEU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=IJyF9bREJaMPaR1vQvJ1Wg8RCkBq0UnFI0DPlcXlRLXuo/
	QNx7yB+PiflHtFrvLltT0Q2waajMj6f9bbUTkpxIxvxx1GZlBwd5FArx3f29gtD8
	EcWWpEyAOzWfRoXAukAoJlpuSCCQEbSoTA2eE40o6qBGA6ZWkUbgh2AdWJuJk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 295BA2B0A;
	Sun, 16 Oct 2011 01:13:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9F5082B09; Sun, 16 Oct 2011
 01:13:10 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8A8B01E0-F7B5-11E0-8E7E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183690>

Thanks.
