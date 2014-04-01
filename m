From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2014, #08; Mon, 31)
Date: Tue, 01 Apr 2014 12:17:01 -0700
Message-ID: <xmqq38hw272q.fsf@gitster.dls.corp.google.com>
References: <xmqqppl128q8.fsf@gitster.dls.corp.google.com>
	<CACsJy8A9b2eccm_BJMjW5RwWLux90xs7HfUQEn0_jrzhHWeajQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 21:17:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV4BL-0002c9-Sd
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 21:17:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbaDATRG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 15:17:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36409 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751302AbaDATRE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 15:17:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9ACB578BD3;
	Tue,  1 Apr 2014 15:17:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/M3zdxPKYa11uz/Vva69DrirusY=; b=Yqt1wn
	aI2frlFUMfC9i5p0YpdairipyLMgc7E62To9FhfPuKYGz40QoSxGsL0NDm+hhlHE
	OKey3s6ZADz+FYuAc8Xoz53cyDIE1kqNSLmTx4Mo0XfuBJzsZSK+SPOEDbF/gbR7
	MvwhPfYX63TpWPlcodOpevzteF22uXvAcBpMs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yWN56/GblmQ0aEn1gqWWlTWxcdYp4S0M
	ri4ZlNbC13zbYod3HB9JFhvoTNsIlWeFSz7tFFvea5NuY32JqVO0hhG+VwzPYzsb
	1b10gHdUmXOXnO7gV3gZd8odkWYO/W0bm4lEYLU1gf2DN7VBprYKgVPtfl9gAx6V
	IjkMeKQCNQA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8170378BD2;
	Tue,  1 Apr 2014 15:17:03 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BFA2A78BCF;
	Tue,  1 Apr 2014 15:17:02 -0400 (EDT)
In-Reply-To: <CACsJy8A9b2eccm_BJMjW5RwWLux90xs7HfUQEn0_jrzhHWeajQ@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 1 Apr 2014 07:53:37 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 34986FA2-B9D2-11E3-999E-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245623>

Duy Nguyen <pclouds@gmail.com> writes:

> The basic support is there. Some bells and whistles (e.g. listing
> checkouts) are not, but we can add them when we see the needs. Eric
> and Torsten helped review but no, there hasn't much discussion about
> it, which may be because it's already perfect, or people are not
> interested.

;-)

> Unfortunately, this multiple checkout thing conflicts with how I
> use emacs (--daemon) so I'm not one of its heavy users either. I
> only occastionally make new, short-lived checkouts to test things.

FWIW, I do keep a permanent multi-checkout and I sometimes make
edits, but it is mostly for building other branches while I work on
something else.  When I edit working-tree files there, I do let
emacsclient talk to the emacs I have files open in the primary
working tree, though, so I am not sure what your issues are with
emacs (--daemon).
