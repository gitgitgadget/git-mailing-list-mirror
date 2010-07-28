From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Fix git rebase --continue to work with touched files
Date: Wed, 28 Jul 2010 10:23:36 -0700
Message-ID: <7vocdr4j1j.fsf@alter.siamese.dyndns.org>
References: <1280305216-59263-1-git-send-email-ddkilzer@kilzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "David D. Kilzer" <ddkilzer@kilzer.net>
X-From: git-owner@vger.kernel.org Wed Jul 28 19:23:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeAMA-0002yk-Bc
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 19:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755916Ab0G1RXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 13:23:47 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44769 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755908Ab0G1RXp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 13:23:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 00BBEC8C5C;
	Wed, 28 Jul 2010 13:23:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=NnWsfMy4xJ0eUm7dkRNNWmHMJNo=; b=ZFj+cxFwFLBtdc08YStzrVJ
	ur8I5Ke3lJh+qmCHZWa0loktai8iLW39aPSWNSdoD4OkWghbCLn8DPWTdKkauncT
	3n+rhMKHRXS5SVFIZnmzhClKm4Uyv8P1sS2GGA3AN/gqvMHhuUIoE+9i/LrsknMl
	kIf3aRLyNT4vhIlDSe4s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=CKdoTzyL8vQsmvsBR6ksFiuYDHyttmCUPDTz5mv22ydeHB/9f
	Im6rw/SAhJxeCkdC8iztwhjL1QQLqpA0aCziy+Fi2cJZ6teiday8EvhlCwvBkVP1
	mR0nux3kKUioXe1wcGjUnXcGI+mOkcRZj6Jaiy4513NbG99uSg0Pgjw4oM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BCCD4C8C47;
	Wed, 28 Jul 2010 13:23:41 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E963AC8C44; Wed, 28 Jul
 2010 13:23:37 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DE0F0BF6-9A6C-11DF-90CE-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152109>

Reasonable.  Thanks, both.
