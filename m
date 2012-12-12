From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 0/3] submodule update: add --remote for submodule's
 upstream changes
Date: Tue, 11 Dec 2012 21:42:48 -0800
Message-ID: <7vtxrr6d2f.fsf@alter.siamese.dyndns.org>
References: <20121204001717.GA17375@odin.tremily.us>
 <cover.1355251862.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Wed Dec 12 06:43:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tif67-0007kv-4V
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 06:43:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927Ab2LLFmy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 00:42:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39794 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750866Ab2LLFmx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 00:42:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 54F766784;
	Wed, 12 Dec 2012 00:42:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6b959xy9OxUR8SdfPjCigY0pSvE=; b=WI7k9r
	aXLXhtf73Kw0wllxF9+Ebe5sAIBiVZTDWFtD8Q/52x41tLCUS3fNLUEpab14FrVp
	dv/yCMoqUacti+dPOc15adQHpE9OilGpnZSDDmFXqzubh/R+QTxi6i8dEU6fJ5IY
	d2w9aEBMQA0s4AlVeR4nOJURU7jNtNS5CMLQI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XfXuTct2xDBOjG5Ll67kEILO5i3pYqH2
	sXjQHn88DI89f2ckB8Sf8rX+eNrS1sx+/FI7/KNbbtls6d0ftRCfNdH/S8vN5nnp
	R9va2q10IGtGfX8AcWmoYqu9bQ/3NRQ+IbsX1HKFyz2LJe2YdJ9YzSf30sfK5W2Y
	6UxoHLLabCg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 425A86782;
	Wed, 12 Dec 2012 00:42:52 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B1FE36781; Wed, 12 Dec 2012
 00:42:51 -0500 (EST)
In-Reply-To: <cover.1355251862.git.wking@tremily.us> (W. Trevor King's
 message of "Tue, 11 Dec 2012 13:58:14 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C4E3EF76-441E-11E2-8414-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211328>

What branch did you base this series on?

The preimage of git-submodule.sh in [2/3] does not seem to match
anything I have (I could wiggle the patch, but in general I would
rather prefer not having to).
