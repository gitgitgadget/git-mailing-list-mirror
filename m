From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] remote-hg: more improvements
Date: Wed, 14 May 2014 15:34:37 -0700
Message-ID: <xmqq1tvwhtvm.fsf@gitster.dls.corp.google.com>
References: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
	<xmqq8uqdbgqg.fsf@gitster.dls.corp.google.com>
	<536a83097302f_76ff7a52ec6c@nysa.notmuch>
	<xmqqvbth8ha9.fsf@gitster.dls.corp.google.com>
	<536a999e2c0c_76ff7a52ec1e@nysa.notmuch>
	<xmqqoaz95ees.fsf@gitster.dls.corp.google.com>
	<536ad9601b73b_3caaa612ecdc@nysa.notmuch>
	<CAGK7Mr4DYuU34Zf_3fRQFkT+1TGOkpfLPUnQh=tYh6EMtBEt9A@mail.gmail.com>
	<xmqq8uq6rd30.fsf@gitster.dls.corp.google.com>
	<CAGK7Mr7AcqKnEBk1NwzJFJVSSQE9uWTE00zi+B9z6i0V5tBrEg@mail.gmail.com>
	<87mweku2pt.fsf@fencepost.gnu.org>
	<xmqq61l8hubw.fsf@gitster.dls.corp.google.com>
	<87a9akro14.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philippe Vaucher <philippe.vaucher@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu May 15 00:34:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkhlA-0001i6-1e
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 00:34:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754157AbaENWeo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 18:34:44 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60254 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753537AbaENWen (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 18:34:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6CE751815F;
	Wed, 14 May 2014 18:34:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YV84W8UCyYhdzZ4H4gb3daSyLTQ=; b=GsZ3bN
	R6wfT6VMl0n1x3fwOYRPnEzhtJlcluCn1n2MYBv5nviuECYuGmgE1Wlf7YxMM5PY
	HYEosrxvOAHYLMa1PlAteldn6Vzr3PZCNp96m37kzWJo1vxG9XY6RFoIHONcZFPE
	Dgo2+81qIiiGhDRV4W21f3y/68jQjtHPNzVak=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dTIvVPX8mqBgprlC08Q24CLp6ljsying
	D0NE8VzjiPKWtVQKAskPFYYD52Rgma4fdcPRxoSGRGfbHuGUY8jtkMiYar6SlM8h
	n2EKDTKc7zmp/3AXvV/W+peluW+cYbH+TcMvAvHGGXoryE1os7h3zlMB91PfW99G
	1aJMnFeH1mI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 630831815E;
	Wed, 14 May 2014 18:34:42 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4284D1815C;
	Wed, 14 May 2014 18:34:39 -0400 (EDT)
In-Reply-To: <87a9akro14.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Thu, 15 May 2014 00:30:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EF60B342-DBB7-11E3-81C2-DDB853EDF712-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249043>

David Kastrup <dak@gnu.org> writes:

>>> I'm not entirely convinced of that: there is something akin to drop-dead
>>> gorgeous code: code that is so well done that it would not matter with
>>> regard to its maintenance whether or not its author dropped dead because
>>> it's both done well as well as documented in a manner where the original
>>> author could not offer significant additional help.
>>
>> I would have to say that you are living in a fantasy land.  During
>> the entire life of Git, I do not think I ever saw such a code that
>> is perfect from the get-go and did not require any maintenance to
>> adjust to the changing time.
>
> You are attacking a straw man.  "where the original author could not
> offer significant _additional_ help" does not at all equate "does not
> require any maintenance".

Ahh, I realize that I misread what you wrote.  Yes, I do agree with
you that we have a lot of pieces of code, with log messages we can
find with the help of blame, that the author himself does not need
to be present for them to be maintained properly.  Making all the
code in Git like that may be an unattainable goal, but calling the
effort to make that happen "living in a fantasy land" is utterly
wrong.  Sorry about confusion.
