From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: configure submodules
Date: Mon, 24 Sep 2012 13:36:40 -0700
Message-ID: <7vr4prxinb.fsf@alter.siamese.dyndns.org>
References: <1348385867-17359-1-git-send-email-orgads@gmail.com>
 <7vr4pt16ep.fsf@alter.siamese.dyndns.org> <505F5151.2080208@web.de>
 <7vmx0g0xpm.fsf@alter.siamese.dyndns.org>
 <7v39271j3n.fsf@alter.siamese.dyndns.org> <5060A32D.1060902@web.de>
 <7vlifzz2vo.fsf@alter.siamese.dyndns.org>
 <CAGHpTB+F3=mW9m3ESQe1wAkLzSBcp+5Kgw1Kb-D-rk2T1q_-iw@mail.gmail.com>
 <7vy5jzxmts.fsf@alter.siamese.dyndns.org>
 <CAGHpTB+0GLJJ-e1JFTXQ0Qot9An90MXxDFbP+63+pG2uA3UhmA@mail.gmail.com>
 <5060BADB.2000505@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Orgad Shaneh <orgads@gmail.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Sep 24 22:36:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGFOf-0006ng-CJ
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 22:36:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757977Ab2IXUgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 16:36:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33663 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757874Ab2IXUgn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 16:36:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 938339FF8;
	Mon, 24 Sep 2012 16:36:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t75cHhZgzJysGVBLns9tcN3fJBw=; b=afS7M6
	B4DEMvRbe2vSeOdtfN5gRp9w+fum6EgRU8QRe3kJmHJ/p9/I3Goj++oXwBmFFGmo
	neiirLZZZ1PD3LT4t7s58sij78qzbbZLrNgv7Bxo/ceU5W8MvLoWa/M0MIvDUypX
	Icvs+FwU61jX6coyOEadPvjK5YIukW3n3Wvmc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C7XRPs3txcYT0RWzMTqc4szacQLB4sHr
	Ij4sG6cT/PJ+kXwTF7AiZekYdwRgretv/76O31M3sfY+KUSz4FKxNJFMrdoJMoNe
	0dbiBBvotu2M0UPnqoOqWq3UN5kFWz/Cz9/ZrXTR91AJJhvyKduSY9NmOYQrtrq5
	AJZWo5U4eTM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8143C9FF7;
	Mon, 24 Sep 2012 16:36:42 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 01F049FF5; Mon, 24 Sep 2012
 16:36:41 -0400 (EDT)
In-Reply-To: <5060BADB.2000505@web.de> (Jens Lehmann's message of "Mon, 24
 Sep 2012 21:56:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8C629AE6-0687-11E2-BA46-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206327>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> But submodule.mod.path should only be set in .gitmodules, not in
> $GIT_DIR/config. Did you just remove the ignore setting from
> .gitmodules or the path too?

Without that in $GIT_DIR/config, how would path<->name mapping
correctly work???

Confused...
