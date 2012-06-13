From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: remove credential helpers from porcelain
 commands
Date: Wed, 13 Jun 2012 13:25:55 -0700
Message-ID: <7v4nqfgdrg.fsf@alter.siamese.dyndns.org>
References: <1339575089-28264-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Jun 13 22:26:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Seu8g-00046t-5t
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 22:26:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752424Ab2FMUZ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 16:25:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60212 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751417Ab2FMUZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 16:25:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 04A3E8C25;
	Wed, 13 Jun 2012 16:25:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eHLZ+TN6o3YtgRa8bUS5BDHD+GI=; b=rLXKpo
	CGZHSyItA6HSeLKxFPtFtG/b6miqyDtF19Sbe4iZMjScRWFyxUWgK/k8H+718o5C
	louUPAQbZeflY7WaCXr7n9pqu2LsOrb+MqPm1qaSo2MhZkL2OCJb54JX7k/ba4ZX
	XAoBOd+SLK1NGMNOfQhqMtf42eKchljc0x/O8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IC21NSDqgNwwzKtq90VWTFNQKCnkvBEe
	6jey3iKkGDYmz9o5ju5jqWqJokKajizCcB9+JUz/kOXf+SOMwfsWVGV84vu+kQyB
	a3rQ4DDmGtLlpgOsKJrYMPc0DCngeXfHKgpAeBmWES8hdmxQhnAF1fLD1ysXVWxE
	y4eoC5DeuX0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EC3B38C24;
	Wed, 13 Jun 2012 16:25:56 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 81C488C23; Wed, 13 Jun 2012
 16:25:56 -0400 (EDT)
In-Reply-To: <1339575089-28264-1-git-send-email-szeder@ira.uka.de> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?= message of "Wed, 13 Jun 2012 10:11:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FB1B0786-B595-11E1-BA17-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199942>

Thanks; both patches queued.
