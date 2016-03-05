From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch-pack: update the documentation for "<refs>..." arguments
Date: Sat, 05 Mar 2016 11:35:42 -0800
Message-ID: <xmqqvb50u38x.fsf@gitster.mtv.corp.google.com>
References: <xmqqd1r8vjqi.fsf@gitster.mtv.corp.google.com>
	<1457206444-26134-1-git-send-email-gabrielfrancosouza@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 20:35:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acHzR-0006LU-B8
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 20:35:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbcCETfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2016 14:35:47 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54553 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750724AbcCETfp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2016 14:35:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 77B1F4AA19;
	Sat,  5 Mar 2016 14:35:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8RyTzOqG73tbU0uPToDt7luF+RA=; b=kdWtPv
	EZ+qWYHamL58KzHr76fytHr/QcwyoWb8bZEWfY6g3hXclGEUTUP6TaezJDTt0nZU
	WnYgp2JC6w3kKXkV6wZiAMl/6DKCzGyX5PeD7p4EWqQnX2I67mnfVQWEBYZ2pADx
	2M692zzA18pa8a7S+elKM4QkR8nhv/He8MPZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M7KZWeN5RvpuBvpjNTRPT6GYF0KG2H88
	I4BQeS1OwnCTax41KXxCmteNlkvA26AIasrgP6GbVtPEl5UqeXlQkkLK13rEr/s3
	4XO30GQeX8X1niv8GfXRDsBFMxTQSXQ7CjzPuMDf0YXF1Dw8XPBpESLB8BpRTb34
	DOlYO7YYhTA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6F1214AA18;
	Sat,  5 Mar 2016 14:35:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E15BE4AA15;
	Sat,  5 Mar 2016 14:35:43 -0500 (EST)
In-Reply-To: <1457206444-26134-1-git-send-email-gabrielfrancosouza@gmail.com>
	(Gabriel Souza Franco's message of "Sat, 5 Mar 2016 16:34:04 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 73A91DE2-E309-11E5-9802-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288324>

Gabriel Souza Franco <gabrielfrancosouza@gmail.com> writes:

> When we started allowing an exact object name to be fetched from the
> command line, we forgot to update the documentation.
>
> Signed-off-by: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
> ---

Thanks for resending ;-)
