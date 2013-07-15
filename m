From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/46] "struct pathspec" conversion and :(glob) and :(icase)
Date: Mon, 15 Jul 2013 12:08:26 -0700
Message-ID: <7v61wbbpzp.fsf@alter.siamese.dyndns.org>
References: <1373790969-13000-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 21:08:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uyo8P-0000Cd-LG
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 21:08:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755091Ab3GOTIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 15:08:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35399 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754993Ab3GOTI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 15:08:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E31A73018F;
	Mon, 15 Jul 2013 19:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=P+2mZy0qzCQvJgczCJh/rZCLOAo=; b=m0SL0dWz9Kdb8O5c1+3J
	ijrNeeo8k0qU+5orVC0uTyt366K4or5p9eNLTUUW9HAt+bm4KY7/jr9l3IYDSlLs
	V4NOoefCd4zEvn5cuNSdLgraqQL0dyPfX+P1yMqXzDbU1w4Sk5qyHRJaebWhhTGp
	QlCRZ0RRZwSGfVGkp5XaROY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=U+xQlihNdnCYwPrJbMTOuQ7J27DFs6NhjkdPju42IA8iZT
	YQ64XxfHfreBgpUUGjQ2GnkPH2BHQbh9erQ82PzWA2GcvDMDqcYGEDXbrbSfosPr
	moM8m8M+vZszeaJAzo9Clm2O4s5RCR7jeSCC9O280vADwf0qlJBDQ7AAXG9D8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D788F30186;
	Mon, 15 Jul 2013 19:08:28 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 434E230184;
	Mon, 15 Jul 2013 19:08:28 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EE859CF0-ED81-11E2-AD44-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230516>

Thanks for a reroll.  I am slowly reading it through ;-).
