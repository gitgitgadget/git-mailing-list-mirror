From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GSoC 2016: applications open, deadline = Fri, 19/2
Date: Thu, 18 Feb 2016 19:20:23 -0800
Message-ID: <xmqq7fi1e688.fsf@gitster.mtv.corp.google.com>
References: <vpqoabox66p.fsf@anie.imag.fr> <20160217172407.GD1831@hank>
	<448280D1-3EEB-40DF-9886-C9B620E32E3C@gmail.com>
	<vpqh9h7f9kz.fsf@anie.imag.fr>
	<CACsJy8D-bHOLGKq0ZELcPYWpKXgct3HBF9Btp3UPw+tqGUR5Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Lars Schneider <larsxschneider@gmail.com>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 04:20:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWbcM-0005eN-Dk
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 04:20:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161050AbcBSDU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 22:20:26 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64844 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161032AbcBSDUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 22:20:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0A09E454B3;
	Thu, 18 Feb 2016 22:20:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I+IXFeSi0lOzMC0vrzFVWxPwb3A=; b=sSp0JS
	hyCg9kLngl3LkM6NwgsMOSEpLe0UhaooD9gK15gOH0wAYwLM11BBibPYKEgP624i
	TH45EtNidqHaM34hLOWXu0ARNeu9jlcqcLgFs7wVxOskgOnjm3T4JmtWvstIfqlR
	MCDGlcGgtjXScvd53SlnTls5wpenghwXj03ZU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fNc9VGYkPo4fEjVDNjzLsDMViMjWzGHS
	820i7ydEIrJQDO+ZLfxNqx222VoGp0Kjegg9+8W9F46NVrCTexDXdojKCw4ZM5/T
	YB0NDtX6wYe802CsChfgTSjGgL+987gPTNnw7HWMAx40vOKaMpYWNqdakInfpd56
	wG+Xq+MECh4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EED88454B2;
	Thu, 18 Feb 2016 22:20:24 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 51568454B1;
	Thu, 18 Feb 2016 22:20:24 -0500 (EST)
In-Reply-To: <CACsJy8D-bHOLGKq0ZELcPYWpKXgct3HBF9Btp3UPw+tqGUR5Bw@mail.gmail.com>
	(Duy Nguyen's message of "Fri, 19 Feb 2016 10:09:45 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B71DA524-D6B7-11E5-A3CE-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286656>

Duy Nguyen <pclouds@gmail.com> writes:

> Probably too late now, anyway.. with David's multiple ref backend
> work, we could have a third, no-dependency backend. We can use index
> format to store refs. Then we can avoid case-sensitivity issue with
> filesystems.

I'd actually vote for a ref backend that is based on a tree object ;-)

    http://thread.gmane.org/gmane.comp.version-control.git/282677
