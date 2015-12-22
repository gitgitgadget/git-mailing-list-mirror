From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1] git-p4: ignore P4 changelists that only touch files
Date: Tue, 22 Dec 2015 15:30:02 -0800
Message-ID: <xmqq7fk6cb9h.fsf@gitster.mtv.corp.google.com>
References: <1450623579-17013-1-git-send-email-larsxschneider@gmail.com>
	<8EC36E87-CEC6-4E30-B606-4F4AC572B1DB@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, luke@diamand.org, sunshine@sunshineco.com
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 23 00:30:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBWNj-00018N-W3
	for gcvg-git-2@plane.gmane.org; Wed, 23 Dec 2015 00:30:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933449AbbLVXaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2015 18:30:10 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59349 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932205AbbLVXaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2015 18:30:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5D05136B71;
	Tue, 22 Dec 2015 18:30:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gb5QG0GbnMxARNymzVzgTcobLSg=; b=HvmReq
	5lQN0xGoraQaupoOpMUb/rTSXOcHOwjgHo7p1ZfJsJ+ClQyseF/Kk13PWUSZrZYK
	pKfJBjkrce/IviPdjFrozz0X2illEXLgbT9njOTvTjxNd6xWLH+eQZWZoWQAdN+q
	VWmQLD+fAJ3xWlWolQO8U23xPZcCOJYnXo8U4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jyaKuwOxAzi1ZpXXj0PTOJWG40AWvm/7
	z0ZAvcQG5LoCYanreGCWUrechfClV6ksSzPxxFk/8nYgLZYKHLkWZQBqV47O0BIk
	dcUtqwytpGJd93ZRCDLKxlronHIG+uhMy0+lcQIsMHsKxWrDFB8rwQRS535p+LtT
	vJoZDNGIxvQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5478336B70;
	Tue, 22 Dec 2015 18:30:07 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C6B8836B6A;
	Tue, 22 Dec 2015 18:30:04 -0500 (EST)
In-Reply-To: <8EC36E87-CEC6-4E30-B606-4F4AC572B1DB@gmail.com> (Lars
	Schneider's message of "Tue, 22 Dec 2015 10:18:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EE09FE2A-A903-11E5-B908-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282915>

Lars Schneider <larsxschneider@gmail.com> writes:

> Junio just made me aware of the inappropriate phrasing here.
> This is what I wanted to express:
>
> This patch is based on master as it depends on "git-p4: add option to keep empty commits" (4ae048e)"

Thanks.

It wasn't "inappropriate", but was merely prone to be misunderstood.
And I did misunderstand it.  Sorry for the noise.
