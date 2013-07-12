From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] t4203: test mailmap functionality directly rather than indirectly
Date: Thu, 11 Jul 2013 22:48:42 -0700
Message-ID: <7v7ggwpbut.fsf@alter.siamese.dyndns.org>
References: <1373554528-15775-1-git-send-email-sunshine@sunshineco.com>
	<1373554528-15775-4-git-send-email-sunshine@sunshineco.com>
	<7vhag0rk3u.fsf@alter.siamese.dyndns.org>
	<CAPig+cS7rxFzY8Q3gfTtJkggp-K62SVqsjCotbM3Bkm47L44gg@mail.gmail.com>
	<20130712005517.GA8482@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 07:48:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxWDp-0000qw-Tb
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 07:48:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752431Ab3GLFsq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 01:48:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35984 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752136Ab3GLFsp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 01:48:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 165CC2A0E9;
	Fri, 12 Jul 2013 05:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jndFTrhNKB3wI5s4EEU9pji/61o=; b=opYiod
	rz85z3275jzoCzjW/1EubKmQcsRX7aB/l12C7cWTREPmyYnPIWB4U12dKEkgPCNX
	YnNgJ/7yENTWb6u3ukuWL6lPv4fAzVM3eIscbZHbOo4G+czjDdFe+OEnN5QBvYzK
	s0KB0qSQtRlghy1DzFkfC4nfUVGH2MZ4lEPi0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oBkAVhl8IL7acrd8BwrEeD8ztximzQ07
	qX7gnXXAT04ZTwPApIEIa11VJ0CxdBC56H6UfojzoG6YvJQ1X401pihlV8jKk4sA
	FsTiFC+E/eHfm/cMsr8g0xsRwyeVmdSROeJDIS75vAEkbbBPlK4/VCRSWk7X3ink
	ZUjf7NEotX0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C59E2A0E7;
	Fri, 12 Jul 2013 05:48:45 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 67F4D2A0E4;
	Fri, 12 Jul 2013 05:48:44 +0000 (UTC)
In-Reply-To: <20130712005517.GA8482@google.com> (Jonathan Nieder's message of
	"Thu, 11 Jul 2013 17:55:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B6ADF390-EAB6-11E2-BAAD-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230161>

Jonathan Nieder <jrnieder@gmail.com> writes:

> My current thinking is "no" --- the patch has as a justification "Now
> we can test these aspects of .mailmap handling directly with a
> low-level tool instead of using the tool most people will use, so do
> so", which sounds an awful lot like "Reduce test coverage of commonly
> used tools, because we can".

Yes, that was exactly my reaction that prompted my response.
