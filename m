From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2014, #05; Mon, 29)
Date: Tue, 30 Dec 2014 07:55:56 -0800
Message-ID: <xmqqiogtt9mb.fsf@gitster.dls.corp.google.com>
References: <xmqq387yywm6.fsf@gitster.dls.corp.google.com>
	<AC1A0FA97BFC4A1CA4D89EA6F74C9447@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Dec 30 16:56:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5z9a-0003ts-Mk
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 16:56:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbaL3P4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 10:56:09 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65199 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750833AbaL3P4H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 10:56:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A180B286EB;
	Tue, 30 Dec 2014 10:56:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ACV9kMYKUOcNjbGMW3Gdl4tsMCc=; b=MOcwR1
	locHJizOCn2sQWCgFXd2UssBaCCkdyndpxL9aNoOACYWSo+zb7XnJX2rcuViCWL+
	oZs6I9AbyhzpPYBoweExHPwhwaFTyg1eXEwvDb6sLIv7BqQfksE1KgxFFeDTZYth
	jTz6La8mn1N4znc0xAqdwhthVYzMht64+ACXE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OHZmiGDyRZnrcMwTeZwo9XOgfxw9JyXK
	3r9Ueo2jqBkoHrw6ZfBMyEICOCi7Hl5JUj+ENmwB7kVWnMjn3CelbLY4NUza6vDR
	IW4IxPSBffdQ29PpaVTMzqRqgG+PnBQEj/rNSztblaO6g8DLvPuOb3WpHkgSeFPJ
	QVh/nJqew+I=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C056286EA;
	Tue, 30 Dec 2014 10:56:01 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2F636286E7;
	Tue, 30 Dec 2014 10:56:00 -0500 (EST)
In-Reply-To: <AC1A0FA97BFC4A1CA4D89EA6F74C9447@PhilipOakley> (Philip Oakley's
	message of "Mon, 29 Dec 2014 23:37:05 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 59825A62-903C-11E4-B9E9-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261923>

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "Junio C Hamano" <gitster@pobox.com>
>
>> * po/doc-core-ignorestat (2014-12-12) 1 commit
>>  (merged to 'next' on 2014-12-23 at d2b3e84)
>> + doc: core.ignoreStat clarify the --assume-unchanged effect
>>
>> Will merge to 'master'.
>>
> I was hoping to re-roll but family Christmas / New Year visits have
> disrupted plans.
>
> Could you hold for another week or so? (though happy either way)

Surely I will as requested, but I think the patch is an improvement
with or without a further incremental updates ;-)

Thanks.
