From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 0/5] git-config and large integers
Date: Mon, 09 Sep 2013 11:58:48 -0700
Message-ID: <xmqqsixd3jpz.fsf@gitster.dls.corp.google.com>
References: <20130820223953.GA3429@sigill.intra.peff.net>
	<20130908082724.GA27184@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 09 20:59:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ6fv-0005Bg-EP
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 20:59:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181Ab3IIS66 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 14:58:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64966 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752580Ab3IIS65 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 14:58:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C428040AF3;
	Mon,  9 Sep 2013 18:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6fFhufGU2B4wxp73fVk7dmUmIhA=; b=DV431a
	9OMC/1KsXEVssuVKfVag2PLCQvH1XuGWiIpzlJyjUG1H6z02T6tZ6b3EchBTwibO
	S3OXgbNTrzAxNgOzhK7lRG92mw/3UgWBOiyCMHK4nFmjP2dMSoDOh1XSg2g4pIL+
	6/zBIk45cOIdB+M5UIE/UMk39std6VsaV5qp0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EqOiE3PJDk8bbeARLnfDAjt2kiuAf6oX
	XgnZhDu0lO2sFU4YvJi4hZ9mjfXfrEjr7UZv32PGOtp184ajSHHGxrVz026mQTkZ
	IqMQmW+WpoW24PQe+RUDImyAXyjWtzISKwSy8/z/NZc010R4n29bTPrXwl1iaHtr
	NL0QDe2mhPM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 543F640AF2;
	Mon,  9 Sep 2013 18:58:56 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 475AE40AE7;
	Mon,  9 Sep 2013 18:58:53 +0000 (UTC)
In-Reply-To: <20130908082724.GA27184@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 8 Sep 2013 04:27:24 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DEF8824E-1981-11E3-8D7D-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234359>

Yikes. The updated series looks very sensible, but I already have
the previous one in 'next'.

Will do the usual "revert and requeue" dance...
