From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3] daemon: give friendlier error messages to clients
Date: Sat, 15 Oct 2011 13:13:11 -0700
Message-ID: <7vzkh1vrdq.fsf@alter.siamese.dyndns.org>
References: <7vvcrs181e.fsf@alter.siamese.dyndns.org>
 <20111014131041.GC7808@sigill.intra.peff.net>
 <20111014192326.GA7713@sigill.intra.peff.net>
 <20111014210251.GD16371@elie.hsd1.il.comcast.net>
 <20111014211244.GA16429@sigill.intra.peff.net>
 <20111014211921.GB16429@sigill.intra.peff.net>
 <CAMK1S_g0aKUa=+ndAm7rqeoPAobjVb6oJ1Z4DqSeNrdauXNH3w@mail.gmail.com>
 <7vk486x0hq.fsf@alter.siamese.dyndns.org>
 <CAMK1S_gkB49qhnt8U=3G3UPnjo2vzFx5mL4cOM1Ubu68ySJrDA@mail.gmail.com>
 <m3r52e7js7.fsf@localhost.localdomain>
 <20111015082647.GA7302@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 16 00:09:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFCQO-0006o3-KZ
	for gcvg-git-2@lo.gmane.org; Sun, 16 Oct 2011 00:09:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594Ab1JOWJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Oct 2011 18:09:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45380 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751224Ab1JOWJk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2011 18:09:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA6745B11;
	Sat, 15 Oct 2011 18:09:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=g5L+ydGHZoJwXC+s+XE/bAnZnBo=; b=dZBywGjW2hIuHvKCi8Za
	l9+PYgLVvpsW4lj64IPzt/rvgiwqTI1Nn3y2wGDiECHbgCyPPudLKq5YDFwDD1DE
	sx8pRIsqH6PV2SM7QSiaIHrd4BqbyE6BUtaigxlxiq+lycBR0UpQKCkJZ4/vztge
	uHlTlKGIKekdIcg+RUQ2FKw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=X39zL6qqXPShpR3fqNtgzajah4R/rzZz4Duqh54xSzx9Xl
	StJh71a9dAraQziezviLFtavgXM7sBmshuT1KPW+SIakseqLKA0FM1FfvaKbPH+7
	nUJ4XznH6vpNSzqW7v+pTmF+x/U4Rl7yE/swQvtjXNEuTDK2yR+dJquguY/TE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E15515B10;
	Sat, 15 Oct 2011 18:09:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 690085B0F; Sat, 15 Oct 2011
 18:09:39 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 604BCC2E-F77A-11E0-A0C4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183676>

Jonathan Nieder <jrnieder@gmail.com> writes:

> ... The admin who is eventually forwarded this message
> will be reminded ...

The admin has access to logs that record the real cause anyway, no?
I thought this was all about how the error is given to the end user.
