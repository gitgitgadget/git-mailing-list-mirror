From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/5] git-prompt: cleaning and improvement
Date: Thu, 27 Jun 2013 08:22:06 -0700
Message-ID: <7v8v1vvash.fsf@alter.siamese.dyndns.org>
References: <cover.1372211661.git.erdavila@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: "Eduardo R. D'Avila" <erdavila@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 27 17:22:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsE1X-0000vv-Ci
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 17:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753912Ab3F0PWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 11:22:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32800 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753902Ab3F0PWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 11:22:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D08222968D;
	Thu, 27 Jun 2013 15:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aWMFQnszOCdYttMLAciXDFHFQy8=; b=ahZpOD
	WUTyhfHiiH6oIvnl7ZhlQF9FMEJTDsPjF4wZogfqFDuFMcBFNaHuXthcqlBeSMTM
	v1//0iqxPC8DncwYpsQhYBH46urf6+JXnsZzVeT3NDQ444XjW5sVWlhJOS1bk9Z0
	bfeuPSJYRGewWPkgGjonPptuNTKcR43Ss79Gw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JmYmHc7gw0dksEJVpeORfNVwnXDyE3hU
	qTq5IS/+fxtgeEZgO9MuxHN1JuburS0FWt4r3SXc8XKxrhwRyxcVImOmOELHdJcD
	P6VBj0+ztWVGfh3pk7kC1OKiKmeMlITXg0Mw2M0EyEZ5mJdnUIkBt8J8AVPyjySR
	P8c+4Fzb13U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD9052968C;
	Thu, 27 Jun 2013 15:22:08 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 47DE72968B;
	Thu, 27 Jun 2013 15:22:08 +0000 (UTC)
In-Reply-To: <cover.1372211661.git.erdavila@gmail.com> (Eduardo R. D'Avila's
	message of "Wed, 26 Jun 2013 00:05:12 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 54C9B152-DF3D-11E2-8481-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229110>

Queued, and merged to 'pu' without the previous merge with the older
iteration.  If you two can double check the merged result, it would
be very much appreciated.

Thanks.
