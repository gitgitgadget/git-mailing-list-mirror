From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v11 00/11] Add interpret-trailers builtin
Date: Tue, 29 Apr 2014 14:43:02 -0700
Message-ID: <xmqqzjj3izh5.fsf@gitster.dls.corp.google.com>
References: <20140425185719.28550.27059.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 23:43:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfFo3-0005se-31
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 23:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932881AbaD2VnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 17:43:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35551 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751365AbaD2VnI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 17:43:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F9577FE52;
	Tue, 29 Apr 2014 17:43:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=75+uRrpjbidY4E+NYGQPADIEYKc=; b=nK2HTv
	UH3WMLFYoSBQH/zGxbOeBHhiO8XrRFoxqpWsRWsMG1J2ZYaPGbTGKyDV7NJqADmO
	sFOB/gAduD+tAjia3PfktkeUBaL/scOB1jV8bg+UXYDBkClNwVKTGS/0RBWWxPUs
	N2qbT668usXBdIN4i6H2y5NRTh+sFETv2LzG0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F3TP16A23UgT6NgNs7JLiKi3s0lbAgy8
	LozU2AhtMuc3EX8UULM/Y8y4bZwstUHk3KKEBYoPU1zJlodCPhJJnkImmRMDklp4
	IFBW03/YVINho8GKbK67eBxtZlL/Vj21+e3hADHgmH5QU2MoTspnum5XZTCnBzQe
	14kOlhW8uUw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 11F927FE50;
	Tue, 29 Apr 2014 17:43:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 32E337FE49;
	Tue, 29 Apr 2014 17:43:04 -0400 (EDT)
In-Reply-To: <20140425185719.28550.27059.chriscool@tuxfamily.org> (Christian
	Couder's message of "Fri, 25 Apr 2014 21:06:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3E72CAB0-CFE7-11E3-8056-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247611>

Thanks and sorry for taking a bit longer than usual; will push this
series out, replacing the previous round, when I am done for today's
integration cycle.
