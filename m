From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] clone: always fetch remote HEAD
Date: Tue, 07 Jun 2011 16:18:09 -0700
Message-ID: <7vhb8144em.fsf@alter.siamese.dyndns.org>
References: <20110603050901.GA883@sigill.intra.peff.net>
 <20110603051805.GC1008@sigill.intra.peff.net>
 <7vipsi8zwl.fsf@alter.siamese.dyndns.org>
 <20110606220821.GB13697@sigill.intra.peff.net>
 <20110607230013.GA23409@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 08 01:18:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU5XZ-00027U-A4
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 01:18:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757897Ab1FGXSY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 19:18:24 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53086 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148Ab1FGXSY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 19:18:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 33A9763AC;
	Tue,  7 Jun 2011 19:20:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1kMUnn1UF2bBX1+N8zqo7hbka18=; b=DwM+1x
	8oSuwxEnUr/1DseNqTJYcTRXumjhtqXmnQcECl98p+Wo2yhPpQ09v3sQ5RFjXHZg
	qzBXN7pbjJjk/hJj3abPme4JOMU4BSGpajcGvDhMt5e5e0I5LBfA4nM+nnf3MscT
	ftPdsOWUzREWSkyJnzcUO4PWbuI9sGuP4dgkY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lz9iZA5TilYY/qV8Kf+smJ+MsrWsZNIM
	6YoUkVtpzXq+MhiaCopq5qazQLIuLkGEUVHZ9OuriQoQdTgQqk2DeosKqWMpyYoa
	Jif8B+OsSlhCLz3h7tN1FPmC5VAgvbhDdCOVrGewkMgMVSC7pHPttGSkAoB16lfa
	XUhAUg+E7aY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D331663AB;
	Tue,  7 Jun 2011 19:20:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B3AA463AA; Tue,  7 Jun 2011
 19:20:20 -0400 (EDT)
In-Reply-To: <20110607230013.GA23409@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 7 Jun 2011 19:01:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B6785B78-915C-11E0-975A-85C8C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175287>

Jeff King <peff@peff.net> writes:

>> It should definitely be an exact match. I'll fix it in my re-roll.
>
> OK, here is the re-roll. I've omitted the first two patches, which are
> the same as before. So this replaces the old 3/3.

Looked sane. Thanks; will replace.
