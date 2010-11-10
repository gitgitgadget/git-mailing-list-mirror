From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Using gitrevisions :/search style with other operators
Date: Wed, 10 Nov 2010 09:23:58 -0800
Message-ID: <7vsjz9hz2p.fsf@alter.siamese.dyndns.org>
References: <20101109083023.783fad9b@chalon.bertin.fr>
 <13A8F1B3-39B0-4D11-8763-9C458F75487D@sb.org>
 <20101109102428.5ba8dc13@chalon.bertin.fr>
 <7vlj52jakh.fsf@alter.siamese.dyndns.org>
 <050F42EE-34FE-499F-B632-471597EB4881@sb.org>
 <20101110083209.6a1252ef@chalon.bertin.fr>
 <23523534-F7A7-4D61-A899-8B3B28566EA7@sb.org>
 <20101110084609.78f532a5@chalon.bertin.fr>
 <m3eiatfbg2.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Dirson <dirson@bertin.fr>, Kevin Ballard <kevin@sb.org>,
	Junio C Hamano <gitster@pobox.com>,
	git list <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 10 18:24:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGEPD-0006Nz-V5
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 18:24:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757146Ab0KJRYP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 12:24:15 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43379 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757117Ab0KJRYO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 12:24:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2AAE6220B;
	Wed, 10 Nov 2010 12:24:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Fpnvnyb/qSbqvBNGb2NrtvhS5W8=; b=Z15Bol
	tNIuTBosb0XH6JdEF/6XusOlhEUlWfWp/QMGCZjsMXyiA6b5UFIB6wWUtmqv1oyI
	g+IVbxqo93RVdj3Eiwkj1e3y3ureCWKLAAFtEjvbJAvFjsF8xwUEM7Nv6soOmnpp
	8or98p65W6dNsL8I7OCXeuMrUk/KvcG+JXQpg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t7rE3x0q+G+WLwJ8q4F6jneYZpjUqDRU
	tHC3c8G4WYv5eOHbA3XpbhgCDkzycrHbI4VQPEOGAICbcIZmxkWvg+zJe1nEz9z+
	1IvDJH1TpZ7rTd2Y0VpG0eN32DRyKbrcU/uBUCmCrjm35DBmli9k9DLA18ni5yF/
	/gNIcowuHYk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D074C2204;
	Wed, 10 Nov 2010 12:24:11 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 283272200; Wed, 10 Nov 2010
 12:24:03 -0500 (EST)
In-Reply-To: <m3eiatfbg2.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Wed\, 10 Nov 2010 07\:26\:20 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5560E4E8-ECEF-11DF-9ED6-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161160>

Jakub Narebski <jnareb@gmail.com> writes:

> The <ref>@<sth> is about reflogs

Wrong.  "@" in the olden days were limited about reflogs but not these
days.  <ref>@<something> is about refs; <objectname>^<operation> is about
objects (most often commits).
