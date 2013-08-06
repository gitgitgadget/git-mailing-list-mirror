From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 0/9] Removing deprecated parsing macros
Date: Mon, 05 Aug 2013 23:39:40 -0700
Message-ID: <7v4nb3iaqb.fsf@alter.siamese.dyndns.org>
References: <1375530686-2309-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Aug 06 08:39:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6avs-0000yo-2F
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 08:39:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753555Ab3HFGjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 02:39:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61923 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752057Ab3HFGjn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 02:39:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 02EAC32277;
	Tue,  6 Aug 2013 06:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PsaXxRTMUPS4TyoGuM9TilIwcc4=; b=ZtCcVC
	TPPhRSznJuy9N44//wrxaBp5ruPWT6Mgb1WlvdYEKuMQ5iXhSPJx2ymYw5sO7ZbA
	GYQek/Kg+ojpM8RsTZqOjqOuMz5YEnyTZN045uxuObkdGw4wUgcl826UFWJWCwfA
	uUGOK8PJnN3JXG7nF+LiYevcwSlClbtl/kaS8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CUmyY30MhmLscZjmVTOfOCiWjeCk46PP
	k+9lagyEs8PLV7LKzT0REm3P7qRzAOMzQT3Q2FTOpqiIkzYiP9IJ4CgcJshyn0F0
	GarfRmqgBbEyRZINbUfp/i03Kp4dwwsTfFGSRUF/4adG0idg1B5JvJtbtsTSRSfU
	tkahBftqwJo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA79232276;
	Tue,  6 Aug 2013 06:39:42 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4E95932274;
	Tue,  6 Aug 2013 06:39:42 +0000 (UTC)
In-Reply-To: <1375530686-2309-1-git-send-email-stefanbeller@googlemail.com>
	(Stefan Beller's message of "Sat, 3 Aug 2013 13:51:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F9A7A168-FE62-11E2-B280-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231724>

Thanks.  Queued this at the tip of 'pu'.  There seem to be some
fallouts found in the test suite, though.
