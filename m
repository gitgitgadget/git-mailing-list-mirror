From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git log --author=me
Date: Tue, 03 Nov 2015 13:30:50 -0800
Message-ID: <xmqq1tc6db3p.fsf@gitster.mtv.corp.google.com>
References: <563764B8.4010101@exec64.co.uk>
	<CACsJy8D83-Mg8UHA-=CPJ3z37CQTn7USjEbfO8QcU1T+=tS0Bg@mail.gmail.com>
	<56388BEC.7050207@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>, Harry Jeffery <harry@exec64.co.uk>,
	Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Nov 03 22:31:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtjAg-0003Vu-Ie
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 22:31:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964916AbbKCVbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 16:31:09 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62480 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964798AbbKCVbI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 16:31:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 41E6F29F11;
	Tue,  3 Nov 2015 16:31:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8GxPACljC2hVnLpiuhfDs8XqvYQ=; b=Ig15ri
	50de1qtOFYki2EZqlDHxsDzMMFCjJlCMQPKc0sFtQ4yKB5ztEy2UjwfiSUFnUzI7
	K8K1mvLBluEYTieW/LXpjugHimdSaU6NFufMFOb09AvMvrU8QH80iAUb3zILgj3X
	6OvMHLgGF+uGmmyNKBValWw+VA95BgzkmPMeg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fNGCvGHiVEJeY4gggxEPSmZ4PK6pask9
	2Wmf2x+MYuADtcCdAKbu1qiynDikg0xELMGczvc8MTJODzj5YH3CqERnaQKGFFxk
	waCgU2ZsvLMcFqpqMBpwcbc6/K5l/X0ykNVDBJ63O9RfVj8ZAVNJXxeele6ocUIM
	O9BT2dHQW7U=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3906B29F10;
	Tue,  3 Nov 2015 16:31:07 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 575D229F0F;
	Tue,  3 Nov 2015 16:31:05 -0500 (EST)
In-Reply-To: <56388BEC.7050207@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Tue, 3 Nov 2015 11:26:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3059B756-8272-11E5-A2AF-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280821>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Alternatively: How about teaching git-completion to complete the
> argument to --author? Expensive, I know, but faster than typing it out
> or realising "Michael J" is not as unique as you think ;)

Or

    $ git log --author="$me"

with

    me='Michael J Gruber <git@drmicha.warpmail.net>'

in your $HOME/.profile or somewhere?

I personally would find "--author=me" not so bad (especially if
finding _my_ work were a very important workflow element), and I may
even tell people to do

    $ git log --author='[m]e'

if they want to find anybody with substring 'me' in their ident.

But that is only if it weren't for existing users, and we live in an
imperfect world where we seem to have many of existing users
already.
