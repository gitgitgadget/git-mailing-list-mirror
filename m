From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/14] submodules: Add the lib-submodule-update.sh test library
Date: Tue, 17 Jun 2014 14:05:34 -0700
Message-ID: <xmqqlhsvl00x.fsf@gitster.dls.corp.google.com>
References: <539DD029.4030506@web.de> <539DD09A.7010200@web.de>
	<xmqqwqcgo4gc.fsf@gitster.dls.corp.google.com>
	<53A07BCE.5010100@web.de>
	<xmqqwqcfl6jh.fsf@gitster.dls.corp.google.com>
	<53A0A93A.9050305@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jun 17 23:20:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wx0o7-0002VM-Vo
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 23:20:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965121AbaFQVFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2014 17:05:42 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63483 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965116AbaFQVFl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 17:05:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B32B81F101;
	Tue, 17 Jun 2014 17:05:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HZ8n6wXV4iC64ozKHPGoKPdxYwE=; b=vO3SVp
	nCjW6idZBz9ZbADhY3jFn3abWJJWDPjcYqGknf8HSDlKpQRL6h7b5TScfZEn79ZZ
	FW/+h8fv3JAIEuSvuE0ZDI7+XDzJi46qL9WYl3oHkFiQ2hLbSdsLhMIE44UQR5DC
	ib7zKd/YCuXMc7f4a47/dXv86QeEnsvxFFwwU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xMzO+CATYzNqotLIPGOATbftBf0XuLyt
	UfAVFczYbqLSMzT541BiQuao4GemR0WtUPAzlFncEW+DPWkeSBmMdPdl6na01Rob
	s/l97Bps/WpJNuTAAA+FvnUT3E8DwjUTDZJHMXRmvoJxhGM2RVcqe2eUNXWrKo0/
	eerdMYo+1BE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 340D01F100;
	Tue, 17 Jun 2014 17:05:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 661841F0FF;
	Tue, 17 Jun 2014 17:05:33 -0400 (EDT)
In-Reply-To: <53A0A93A.9050305@web.de> (Jens Lehmann's message of "Tue, 17 Jun
	2014 22:46:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1F0BCCE2-F663-11E3-9C8E-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251950>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Oh, I forgot to add a smiley there, I haven't been serious about
> that statement. I don't care too deeply about it but feel a bit
> more confident with the two explicit tests. Do you want me to
> change them to a single "test -e"?

I have no strong preference.
