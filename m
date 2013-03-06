From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] help: show manpage for aliased command on git <alias>
 --help
Date: Wed, 06 Mar 2013 15:55:47 -0800
Message-ID: <7vtxoonkvw.fsf@alter.siamese.dyndns.org>
References: <1362494681-11419-1-git-send-email-avarab@gmail.com>
 <20130305173831.GB9379@sigill.intra.peff.net>
 <51374029.6080906@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Mar 07 00:56:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDOC0-0003WO-J5
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 00:56:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755022Ab3CFXzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 18:55:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55310 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753109Ab3CFXzu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 18:55:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 107E5A4E8;
	Wed,  6 Mar 2013 18:55:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y3DOYCrznug5qWHn8w5Vmhv8a3M=; b=OzbOxc
	z3sm9QgTFUwm2CERqOb9WPFAAJXbmn/O/J4RGRIKh5ykO6eVmoSWYLr6sXWHMzuL
	3NkwTaFxLlt6hIqp00o9CMWpCBLrvLyRgGgE6S5WQdJ9mRyYfT00q4cT7IL8yYQF
	FFk0mFAr/lZotZY99ZkF8WvyRo3/7Sjgm2L9I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YmQn12eZ1YNZPC18M93AaWXWyiFVXFek
	pZbS5kLa3u5Rpam6glDzz63kMrERiA1lPmVmVEDKo9BCZDDBxFaZg3jGk+JTuVYM
	tjIcyQFxYVeY1ZySr+Pv4/ZJzLEvgZvb22DhClOmClpKRy0cy4J4UxAgmtxshxiL
	wgmTGkk7kzc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 04D4CA4E7;
	Wed,  6 Mar 2013 18:55:50 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 76BD8A4E6; Wed,  6 Mar 2013
 18:55:49 -0500 (EST)
In-Reply-To: <51374029.6080906@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Wed, 06 Mar 2013 14:10:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5EFB8B8C-86B9-11E2-949A-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217561>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Well, even in the simple case one has to wonder: Why does the user
> invoke help for "co"? There are two very likely cases:
>
> A) User does not remember what "co" is aliased to.
> B) User wants to see the man page.
>
> If A is not the case then it's easy for the user to request help for
> "checkout" (or "commit" or ...).
>
> Removing the only easy way to look up the definition of an alias is a
> major regression.

Very well said ;-).
