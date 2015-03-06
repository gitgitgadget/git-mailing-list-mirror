From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Suggest applicants to participate in review of other peoples' patches
Date: Fri, 06 Mar 2015 13:57:40 -0800
Message-ID: <xmqqd24lyejv.fsf@gitster.dls.corp.google.com>
References: <CAPc5daV7Dv8K8itmQhdf1CG-opMVw7DYyheHdcdL0r_9zFQR-Q@mail.gmail.com>
	<1425642837-31651-1-git-send-email-Matthieu.Moy@imag.fr>
	<20150306211048.GB24267@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 06 22:57:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YU0Fl-0005fe-15
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 22:57:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753943AbbCFV5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 16:57:48 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52004 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752608AbbCFV5r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 16:57:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3AAEF3EF4D;
	Fri,  6 Mar 2015 16:57:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SdvRLDYrVcZsTW5EsN0npdsVkoA=; b=wseE8V
	dpFPhJPdzGEa0koX3YS+2F49mBJK1NrdOWIycYhb7Ht6Ez+PdN4mpb2qre1ebyP3
	+Q2j8bEBvjKaQjzhlqw91rJogmyJfFy6i764arG9TPNfCpc7cure0vOwTN4udI+U
	SSQLXBkGsv/8s9IWyzr//ZtAu4EUBkLOvuDhs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RhNDBcoeju1LRwEIstuKvBB+G6iab2zE
	gnBsX+H8qqM9U/DbhoTCwM1WCtb6EZVCZWGXSXU7MZLrYHB/Gfwn9mhBdtdeqMf3
	q3jCLQrOA4AzEhZbxkvrQn3v9YO+xj/QfNnhJke0ghaq1NMJhuAsg54x7wgCDlp7
	xeHWSTAv35E=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 32B7D3EF4C;
	Fri,  6 Mar 2015 16:57:42 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A69513EF49;
	Fri,  6 Mar 2015 16:57:41 -0500 (EST)
In-Reply-To: <20150306211048.GB24267@peff.net> (Jeff King's message of "Fri, 6
	Mar 2015 16:10:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CFDD544E-C44B-11E4-8C6E-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264967>

Jeff King <peff@peff.net> writes:

> On Fri, Mar 06, 2015 at 12:53:57PM +0100, Matthieu Moy wrote:
>
>> Idea and most of the wording comes from Junio's message on the list. I
>> added a hint to include links to review in the application (which makes
>> the suggestion a bit stronger since it implies that it will be taken into
>> account in the selection).
>
> Seems reasonable. I do not know what the quality of reviews will be from
> applicants, but I guess we will find out. :)

I actually was hoping to see an applicant replaying the review
comments given to him to another applicant that makes the same kind
of mistakes.  That is a fairly easy entry to get into reviewing
process---even you may not yet know what you are suggesting the
other to do is the norm in this community, if a more experienced
person told you something similar, it would be likely it is.
