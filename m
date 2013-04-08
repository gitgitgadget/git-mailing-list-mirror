From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] clone: Fix error message for reference repository
Date: Mon, 08 Apr 2013 12:10:16 -0700
Message-ID: <7vobdox2hz.fsf@alter.siamese.dyndns.org>
References: <1365376629-16054-1-git-send-email-aaron@schrab.com>
 <20130407234810.GG19857@elie.Belkin> <20130408000658.GG27178@pug.qqx.org>
 <7vhajh15w0.fsf@alter.siamese.dyndns.org>
 <20130408145749.GJ27178@pug.qqx.org>
 <7vip3xyr8c.fsf@alter.siamese.dyndns.org>
 <20130408161745.GK27178@pug.qqx.org>
 <7vli8sykf0.fsf@alter.siamese.dyndns.org>
 <20130408185823.GL27178@pug.qqx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Aaron Schrab <aaron@schrab.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 21:10:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPHSS-0001tA-Fz
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 21:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935494Ab3DHTKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 15:10:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55020 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935469Ab3DHTKS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 15:10:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B77715154;
	Mon,  8 Apr 2013 19:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dEQ4rs5y8C33XjX2hwutRC0xlnk=; b=fCC7N7
	vksFQLpPGT7pbO0XIwHnpKpKOT4CVbcT8RRHc3m8ktiDBOyOp7JvOz/peBmSsIXx
	BlFiWtY32xcMLIt32xLbJgyuX8sQm0vzo+Tglenl2bX4sVjMQExsdwLTbJtierZo
	++9fDquEtKhhv+p4umFe0SNQdzpJ41Ttf1YnE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BadqcS3a1/FoVLbRroS1tNLI5d0KiSYa
	3C/8oddHPDbZuqYzy7eRbH6fuyPRxy+zhfDtu1tEG1H/+yRxOyhQcbQhOf1dCFT6
	+0/MaGf8FDG3U0oy04tADcnCPzONG9Z80aT93S3VBedUlp5jXMZwk0k1Qq9z1z1q
	hpC07zBZqy8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F5BE15153;
	Mon,  8 Apr 2013 19:10:18 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 971F015151; Mon,  8 Apr
 2013 19:10:17 +0000 (UTC)
In-Reply-To: <20130408185823.GL27178@pug.qqx.org> (Aaron Schrab's message of
 "Mon, 8 Apr 2013 14:58:24 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F336F09A-A07F-11E2-BF3D-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220498>

Aaron Schrab <aaron@schrab.com> writes:

>>You may be dealing with an old-style submodule checkout.
>
> No, the submodule in question was done with the new style.

I know that and I wasn't talking about _your_ particular case.

I just wanted to make sure people who are reading this thread from
sidelines (or finding with search engine later) applied that pattern
blindly.
