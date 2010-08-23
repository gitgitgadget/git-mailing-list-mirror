From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] optionally disable overwriting of ignored files
Date: Mon, 23 Aug 2010 08:57:38 -0700
Message-ID: <7veidp2ufh.fsf@alter.siamese.dyndns.org>
References: <4C6A1C5B.4030304@workspacewhiz.com>
 <7viq39avay.fsf@alter.siamese.dyndns.org> <20100818233900.GA27531@localhost>
 <vpqd3t9656k.fsf@bauges.imag.fr> <4C727E17.5070707@ira.uka.de>
 <20100823151146.GA15379@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Holger Hellmuth <hellmuth@ira.uka.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Aug 23 17:58:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnZPO-0007c1-2D
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 17:58:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754215Ab0HWP55 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 11:57:57 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59228 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754190Ab0HWP5z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 11:57:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CF501CF902;
	Mon, 23 Aug 2010 11:57:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=DSLf6ueYU1nU5gBXWJmtBp/JAK0=; b=K0cRBV
	TArciHjyBoi9GOBPliEpZKf2xw2LqGN4e7TFCmBA6kwldCJgL3lLiRfHtgRp5lnH
	bJXHEEA558LOVlYuTq5W+lQrBTN7PwmzFD1nMf1nVKi3KXXTvYiq7HLj1sN3GA66
	AzSbBT0XMGyT7LXfwLIxCBF/OmSVQ7nIB9ss0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Im8NyKXVpHDqYE+AhwC8XaV1B9doU1Mw
	VYiYSpE7cLpt3YTBfxEVW9cHt/loxnS8MLXz5n/eSemCGnSqwXZ9/jyQw4ndru9L
	T+1RjTO9yObzKW0mbBLqIs4FZ2doskPo+BoV+LEyC7yo52QTgHtM5mhqS4ysvtDD
	TtYtIpHKknE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CF89CF901;
	Mon, 23 Aug 2010 11:57:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8D042CF900; Mon, 23 Aug
 2010 11:57:39 -0400 (EDT)
In-Reply-To: <20100823151146.GA15379@localhost> (Clemens Buchacher's message
 of "Mon\, 23 Aug 2010 17\:11\:46 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2B73406C-AECF-11DF-B712-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154230>

Clemens Buchacher <drizzd@aon.at> writes:

> On Mon, Aug 23, 2010 at 03:56:39PM +0200, Holger Hellmuth wrote:
>> 
>> You've got my vote. This is the only option that combines safety with
>> minimal configuration hassle.
>> 
>> I didn't know about this subtle difference between .gitignore and
>> .git/info/exclude. And while this makes sense I expect a sizable
>> percentage of users will never even know that .git/info/exclude exists.
>
> I don't know if this subtle difference was even intentional.

I am sorry, what difference are you talking about?
