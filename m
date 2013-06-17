From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git log: Add a switch to limit the number of displayed lines from the commit messages
Date: Sun, 16 Jun 2013 21:41:01 -0700
Message-ID: <7vd2rlic2q.fsf@alter.siamese.dyndns.org>
References: <1371319623.9845.34.camel@mattotaupa>
	<20130615191905.GA3363@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Menzel <paulepanter@users.sourceforge.net>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 17 06:41:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoRFe-0005ma-V2
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 06:41:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753135Ab3FQElG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 00:41:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44264 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750867Ab3FQElE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 00:41:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EAD8822717;
	Mon, 17 Jun 2013 04:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z3Vc0a+CaAfsnRd1BLFAM4fzK4w=; b=H+/QE1
	SEEIafXZ1NwkhLKwv0cnDZuEQiNPtbJsjWK7JKtDyUof9IZ0W2O0XOFqK1GBD8gE
	8CVs8lMnGE1xm8nNTqdeYtIlXqDr7CxUBS5T88XjOtz00eGbftwOVwzrxYSCpuJe
	kHs6jYb9muxMExfjesUT3q7j+uhH30o0rgpmE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xBBalfMgVTlhxR9eF7Lbx7hSR2eM5PU3
	ukTYZDhfj0+3c0zetwp8K8NZVPtA5tcLfcyxk9fHWtC8L/OqpGIRpGvm8LrLcEZW
	OtVNF1qa7pFQoTOogvzksSGgD8BHewmgw/ZoEJE9tWy/pIr4qqtnLhn1ox16riQh
	isjbeQu6Mi0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E1BF522716;
	Mon, 17 Jun 2013 04:41:03 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 665FA22715;
	Mon, 17 Jun 2013 04:41:03 +0000 (UTC)
In-Reply-To: <20130615191905.GA3363@elie.Belkin> (Jonathan Nieder's message of
	"Sat, 15 Jun 2013 12:19:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1DCDE05C-D708-11E2-B026-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228040>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> there are people out there disliking elaborate commit messages, as going
>> over `git log` is tedious as you have to scroll a lot. As I do not like
>> the suggestion to make commit messages shorter by omitting certain
>> details, a way to limit the number displayed lines of the commit
>> messages would be nice to have.
>
> Have you tried gitk or tig?  They split the screen so you can browse
> through commits, one per line, in one half and read the corresponding
> commit messages and patches in the other.

Or inside "less" that is spawned by "git log -p", I often say this:

    /^commit .*|^diff --git .*<ENTER>

and navigate with 'n' and 'p'.
