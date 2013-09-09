From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PULL REQUEST] initial pack v4 support
Date: Mon, 09 Sep 2013 15:28:44 -0700
Message-ID: <xmqqfvtd3a03.fsf@gitster.dls.corp.google.com>
References: <alpine.LFD.2.03.1309091526430.20709@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyn =?utf-8?Q?Th=C3=A1i?= Ngc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Sep 10 00:28:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ9x0-0004jY-E2
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 00:28:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756038Ab3IIW2v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 18:28:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43371 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756033Ab3IIW2u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 18:28:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 59A3C40C25;
	Mon,  9 Sep 2013 22:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WeYFXuyIVNzYnRWWii0MwO+5yXc=; b=azW7p/
	ufDL677ZLrXdwwhZfgBDKk3X/KoB3+J9W/cyH2O5ucZmL81Z785GiizzMC6ertKj
	z9H9hH6n65p8g42X3xLpIclVIZohnElnJfe1ju7w3m2KsRt4RCjB5GE3zpHCOzr+
	dQrunAwmjo/UWc66mwIOkEFOWOGPC82Ps5XkA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IHM1DTedY0ZDbdDtOSjLrVx+whQySjld
	4EOhGW8bh9/Ev2/YOr++s5OBp4hSNqZHqn/IWlxqJrBSW15oSw1g1DxdGg93yyiq
	Uidwzylr/gkXrSJIXMqop4pK2/voxeb/QTjZe+1x7xbUyZudc0bN4NuigEN6nyjr
	PbjsQjsY+Jg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2643540C23;
	Mon,  9 Sep 2013 22:28:49 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3F41240C1B;
	Mon,  9 Sep 2013 22:28:48 +0000 (UTC)
In-Reply-To: <alpine.LFD.2.03.1309091526430.20709@syhkavp.arg> (Nicolas
	Pitre's message of "Mon, 09 Sep 2013 15:52:10 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 321FF142-199F-11E3-88E8-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234387>

I am very excited, but I already am deep into today's integration
cycle, so I'd have to do this either tonight or early tomorrow.

Thanks.
