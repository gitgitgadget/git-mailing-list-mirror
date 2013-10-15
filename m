From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http.c: Spell the null pointer as NULL
Date: Tue, 15 Oct 2013 16:02:54 -0700
Message-ID: <xmqqzjqa9ly9.fsf@gitster.dls.corp.google.com>
References: <525DB9B6.8040701@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Oct 16 01:03:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWDdm-0003YF-0l
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 01:03:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933654Ab3JOXC6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Oct 2013 19:02:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61748 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933565Ab3JOXC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 19:02:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6670B4BD43;
	Tue, 15 Oct 2013 23:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uujh2rqOnRempa5jZTRGYerag4U=; b=fWzl6+
	eee0YjZvL9VENOmiJ4TL/lg5agV5DSyPgLFVGyBekf2RWsJym6SG5dHnS+iLOMNq
	NSqtQwp6VV2htuRPpty/89Gm492bTLXNBl2O/vA1RzKSHO+luqXtymbQaKDo0jcg
	6+5RMh3suOI4I72zGtphb44yHEnyyL4z9Hrro=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WCQpiAf4MfVnBclZYe3xeQTRXa6xI5KK
	3QWyEavGBpKZ7rsKaDNFU1HolLNyzDT0xUj90WGFOjVa+GgKs0NbHigVKPrjb0U6
	nHKiwOucFqqEi2F6EWKa1jXpwuSm4dzEMc1Dti4mii8hD1p3YWYZ7Jp0yL8nBymr
	2ni7KPMVLFo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 568F64BD42;
	Tue, 15 Oct 2013 23:02:57 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C373C4BD41;
	Tue, 15 Oct 2013 23:02:56 +0000 (UTC)
In-Reply-To: <525DB9B6.8040701@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Tue, 15 Oct 2013 22:55:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EE054532-35ED-11E3-847E-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236216>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> Also, I note that maint@kernel.org != maint@repo.or.cz/jrn

Thanks.
