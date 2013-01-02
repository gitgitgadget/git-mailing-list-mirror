From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Test failures with python versions when building git 1.8.1
Date: Wed, 02 Jan 2013 08:35:59 -0800
Message-ID: <7vehi34k5s.fsf@alter.siamese.dyndns.org>
References: <CAEik5nOqge8ix4WGf-h+0Dmz1CanH_XtQdB-CxvPsggSu1-LzQ@mail.gmail.com>
 <7va9ss5fhq.fsf@alter.siamese.dyndns.org>
 <20130102065345.GA8685@sigill.intra.peff.net>
 <7v1ue459yh.fsf@alter.siamese.dyndns.org>
 <20130102085935.GB9328@sigill.intra.peff.net>
 <CAEik5nMRAoHdx166Q7Zb5Yve6DiyVgN6EXQWGF=GgUtSyjiuSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, GIT Mailing-list <git@vger.kernel.org>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	David Michael Barr <b@rr-dav.id.au>,
	"Eric S. Raymond" <esr@thyrsus.com>
To: Dan McGee <dan@archlinux.org>
X-From: git-owner@vger.kernel.org Wed Jan 02 17:36:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqRIk-00046c-Ab
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 17:36:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752990Ab3ABQgD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 11:36:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35217 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752736Ab3ABQgB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 11:36:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52CC5B4D6;
	Wed,  2 Jan 2013 11:36:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qQ9xhXhXGdhgiY6C7eXR11TPJv4=; b=XLJ8GF
	0CCkK/AAAnOsdZhUDFwv+DiFW+Qb66Jf3obvkGY0v8sRI7PFSEaabP6r4oq30A62
	wA/8HGLVwGd2wIjTBpiAzQSJCPeF74msIAs1+l4St5hXS2lXFdu3uNuSpZPMKw5w
	5gyLUf2+pRSULT6hjIS/uG50AK7eYTpwLkC7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QYSaLL1fbL/a7LsIuMNjKANe8LsQeN33
	9mH0cad1NNzh2zdxjsCWe8FrRWXSukEfeXOX818LsqcAAJszKSp0e83ZVepCZZAh
	t6ImFdKmhqDJsVjv7MRTx3YmfS2+8rEKbGHvTUiqMj1ujGlijpVMjN/l29aw8o9R
	nmw2GaJuhw8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 410C7B4D5;
	Wed,  2 Jan 2013 11:36:01 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A9B24B4D4; Wed,  2 Jan 2013
 11:36:00 -0500 (EST)
In-Reply-To: <CAEik5nMRAoHdx166Q7Zb5Yve6DiyVgN6EXQWGF=GgUtSyjiuSA@mail.gmail.com> (Dan
 McGee's message of "Wed, 2 Jan 2013 08:18:12 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7E041742-54FA-11E2-BD87-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212520>

Dan McGee <dan@archlinux.org> writes:

> This works great now, thanks! I ran it through our package build
> scripts and all tests now pass as expected.

If you have a chance, could you try tip of the 'next' branch without
this patch applied?  We had an equivalent patch cooking there for
some time by now.

Thanks.
