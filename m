From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] decoration: do not mis-decorate refs with same
 prefix
Date: Thu, 18 Aug 2011 10:58:36 -0700
Message-ID: <7vzkj6a439.fsf@alter.siamese.dyndns.org>
References: <1313593326-12077-1-git-send-email-pclouds@gmail.com>
 <1313670578-2939-1-git-send-email-pclouds@gmail.com>
 <1313670578-2939-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 21:54:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qu8fD-00025K-O6
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 21:54:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919Ab1HRTxu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 15:53:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43773 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751777Ab1HRTxt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 15:53:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 241344B58;
	Thu, 18 Aug 2011 15:53:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=C5dxhjdhpj/X/JH+sQf/+G1SQPY=; b=LQusYUZ10GYGBYTW5Nll
	sruBv61XIqPnZfDvGNKUdR29pSZs0z4gTagaylKWqgjwNGtzMx0CwXEi6fzSHBa1
	qD5GFZUMkR/tnp6XoHjKeku/beTN5YAxbgrYmA5jQxCorQGPuSqULGCeTL5Tmr36
	sbbHGlSm2OI3EiJ6OJUBvlY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=F2epMrVYAlOd/q9Lh6ebYIPQMaIN2qDxlcttLHufR7TpCn
	pI1C0Q7Qh0z+6xqiU0IFjafNxm4TsWfvIjNaCfJswz4y0aEguRopYC2XwzQlKT6j
	veWNjPl6NhN3FSGbAnbrrER5UZcp08ZHqGsXwk6OvUVAA/6yWQBTZpP0Kp3To=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A7BE4B57;
	Thu, 18 Aug 2011 15:53:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A5C504B56; Thu, 18 Aug 2011
 15:53:47 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C97E4BF6-C9D3-11E0-9AB4-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179618>

Good eyes; thanks.
