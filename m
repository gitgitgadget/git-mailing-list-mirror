From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] pull: introduce a pull.rebase option to enable
 --rebase
Date: Sun, 06 Nov 2011 10:20:40 -0800
Message-ID: <7v1utl6rk7.fsf@alter.siamese.dyndns.org>
References: <7v8vnt7kvd.fsf@alter.siamese.dyndns.org>
 <1320573010-12296-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Herman <eric@freesa.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Fernando Vezzosi <buccia@repnz.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 06 19:20:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RN7Kx-0007jU-4f
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 19:20:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752933Ab1KFSUo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Nov 2011 13:20:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37923 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750736Ab1KFSUn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Nov 2011 13:20:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C75A65288;
	Sun,  6 Nov 2011 13:20:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=4234jASmtI+4
	YkhVGzZeERdiOpw=; b=gIUP5hxxO954WVXxdqMNreFvn8xF6BzAIJAArA9cpl2Q
	JwrPp9RuDOf6kwDw2nKMVgLhFurrY+0WZPVeKKbJXrlE2gA7XlbAf6LMPwa96IMQ
	qj09J3X+S79Q9ZnP84ryN3qfzTf3Dv9JSeOJh/OVIwgptnBQs6VO9L/t/5M4OGk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=jQp9Fx
	WdHL5/OcNgJdb4OuXuNbiJrfCVLJs4QcnQuqm75kgp2rMQPKDLiIcNhE7sbUyGYz
	MkIaf2D3AAflhTP2Q3zXJ+lVaoPrNwjmP3eYCf2Citcw3hknPEC5rvjvMivHONEW
	PzNkmQ5qD+9vzVn34p7pBLAk5jgEgZpeXb/ps=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB8A25287;
	Sun,  6 Nov 2011 13:20:42 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3D1215286; Sun,  6 Nov 2011
 13:20:42 -0500 (EST)
In-Reply-To: <1320573010-12296-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 6 Nov
 2011 10:50:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 095DC27E-08A4-11E1-92FB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184920>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> We all stood behind my laptop while I explained what it did and
> why. Sverre pointed out that I should use the test_when_finished()
> function for unsetting the config variables, Eric and Fernando looked
> it over as well.

Sounds like fun ;-)

Will re-queue. Thanks.
