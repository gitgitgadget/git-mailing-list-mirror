From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 7/8] revert/cherry-pick: add --quiet option
Date: Mon, 03 Jun 2013 11:59:23 -0700
Message-ID: <7vd2s3dnqs.fsf@alter.siamese.dyndns.org>
References: <1369799788-24803-1-git-send-email-felipe.contreras@gmail.com>
	<1369799788-24803-8-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@inf.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 20:59:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjZyt-0005Lo-BW
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 20:59:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757820Ab3FCS7a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 14:59:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59255 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757869Ab3FCS71 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 14:59:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DEDE24863;
	Mon,  3 Jun 2013 18:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HMqMeNZFoA1JyNAPBpVIUvYA5ww=; b=TWGc3a
	qm/Oitj8zQk45LIBxn17G8/Fzk/8lnTguYskTwConjHCCnEOfFSpJflgilYImeLm
	F+aVTbcOJ3SCTRX3Kqla078d1eMVhvB+1VSGSNw80xvcEOdqkW3YUJakw8jiMY9w
	gxkKitg6tWvIVJEHOeOmpOxnx8FmpoE1xiZP8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B3ufFM8NwDDP97MKcFi8PCYzgoZkfELh
	EmxWym0UKVjNKEeOdLsqgMN0yunH7iHsD/uHU8HE3b+d5u+tvbcotGTd82R6N3c1
	4ppzMEpENIgzVMDTXcQCU6T8GngeCTsej+mf4H2tApQ5eS89r/v9nZO314HAsgZO
	WC69W3WZb8c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 11F1624862;
	Mon,  3 Jun 2013 18:59:27 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5206C24857;
	Mon,  3 Jun 2013 18:59:25 +0000 (UTC)
In-Reply-To: <1369799788-24803-8-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Tue, 28 May 2013 22:56:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B59A9738-CC7F-11E2-B224-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226264>

Makes sense.
