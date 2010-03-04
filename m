From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What should "git submodule summary" give before an initial 
 commit?
Date: Wed, 03 Mar 2010 22:22:40 -0800
Message-ID: <7vfx4gfvwv.fsf@alter.siamese.dyndns.org>
References: <4B8E5450.3040702@gmail.com>
 <7vhboxqje8.fsf@alter.siamese.dyndns.org>
 <20100303200239.GA28904@coredump.intra.peff.net>
 <7vhboxno38.fsf@alter.siamese.dyndns.org>
 <20100303204257.GA5501@coredump.intra.peff.net>
 <7v3a0hktga.fsf@alter.siamese.dyndns.org>
 <7vzl2phz8e.fsf@alter.siamese.dyndns.org>
 <7vhboxf4nx.fsf_-_@alter.siamese.dyndns.org> <4B8F00AA.5050007@web.de>
 <fabb9a1e1003032201l38b052ebk4c0061e9d40f68b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Ping Yin <pkufranky@gmail.com>,
	Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	A Large Angry SCM <gitzilla@gmail.com>,
	git <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 04 07:23:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nn4Sj-0000pU-JZ
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 07:23:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752301Ab0CDGXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Mar 2010 01:23:05 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65193 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578Ab0CDGXA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Mar 2010 01:23:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 55E159F76E;
	Thu,  4 Mar 2010 01:22:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W9oBuh0QYqusojT7Zxb9KRTeh28=; b=YDUYJr
	eHkI2f9a6ZvXGF8n80t8hCVno0yLZPxHj5QnHlUshddmu6bwJh4n440EiJvKQpFt
	erSfw5FJ3uOOxOn7fi/tw8nyUmZX3b6APFheOmMHefpY+EWGT2ELlxknLaMsJvJT
	3sppXiu3BqGhms2mQo/Ts3TiCL7Rm6jdHqUzU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KrMktRtpiIYj7Z0f4fAa2Our8v+tyH2A
	uIgXt/jLoW6EpMKKRB7U66hBxhIJIN82x3QRZ3vOI4gX2RdRY7cXJiEuycQCujdl
	Qt2BeUSbC5n5f3w7R4JFFa4wAps7FsV1jZZPUAMORUYyQ3htsaEU+0+DknjbUU73
	Uh/G9c9jf2E=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DC6B09F767;
	Thu,  4 Mar 2010 01:22:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D35189F766; Thu,  4 Mar
 2010 01:22:41 -0500 (EST)
In-Reply-To: <fabb9a1e1003032201l38b052ebk4c0061e9d40f68b6@mail.gmail.com>
 (Sverre Rabbelier's message of "Thu\, 4 Mar 2010 07\:01\:52 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5B69EDB2-2756-11DF-B216-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141510>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> ... pretending we do have a HEAD that's pointing at the empty tree when on
> an unborn branch might fix 'git reset' ...

I think "git reset HEAD" _should_ fail, but on the other hand, "git reset"
and "git reset paths..." would be Ok before HEAD points at a commit.
