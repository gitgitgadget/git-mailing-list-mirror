From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: allow sha1's as part of the path
Date: Mon, 17 Jun 2013 12:59:55 -0700
Message-ID: <7v8v28cxtw.fsf@alter.siamese.dyndns.org>
References: <20130615213459.GA24464@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Mon Jun 17 22:00:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uofas-00063I-Mh
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 22:00:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753403Ab3FQT76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 15:59:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44517 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753142Ab3FQT76 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 15:59:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9223228813;
	Mon, 17 Jun 2013 19:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3yPV1KSAH6/jjBrHt/H9rJO91DQ=; b=Tmqt7l
	xN6LHF/KvUbXB3g8mLrvX71O0iEZB7bavQg2CvFT6CngTudWtjSy3O3vxw+gN6XQ
	PfGyMpfZ1xjLCzELph1nZAxwRjOnQaL9kOUgh2xo1S9D40Tu/oI+cJXRF/K05GMu
	KLT0+APh8zmXZvE/tlo9THY3f+7rW7HDTpmMc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wn6Ogalorh1ppwtf8hiL13giaUM+PSWz
	yePwv94y+3q9k+0NXSUtTQszusoMraQqSpQaN0UjVP6IR1IAvjIE52SyqPdBEAsQ
	JKlJ+R9Uljh3etndp5241ymF2HJctxZZcYZAUGvOFI6C8SQGVJx+ve3M1qTO32Sz
	2XAOZeD13dg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8858D28812;
	Mon, 17 Jun 2013 19:59:57 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 07A9328811;
	Mon, 17 Jun 2013 19:59:56 +0000 (UTC)
In-Reply-To: <20130615213459.GA24464@kaarsemaker.net> (Dennis Kaarsemaker's
	message of "Sat, 15 Jun 2013 23:35:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7BFFB79C-D788-11E2-9F9F-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228106>

Makes sense; thanks.
