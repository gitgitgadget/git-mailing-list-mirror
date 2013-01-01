From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/8] Use %B for Split Subject/Body
Date: Mon, 31 Dec 2012 21:58:31 -0800
Message-ID: <7vpq1pbg1k.fsf@alter.siamese.dyndns.org>
References: <1357012655-24974-1-git-send-email-greened@obbligato.org>
 <1357012655-24974-2-git-send-email-greened@obbligato.org>
 <87wqvxv96q.fsf@waller.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Techlive Zheng <techlivezheng@gmail.com>
To: greened@obbligato.org
X-From: git-owner@vger.kernel.org Tue Jan 01 06:58:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TpusI-0006iy-Os
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 06:58:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941Ab3AAF6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 00:58:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64745 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751932Ab3AAF6e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 00:58:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1641560F2;
	Tue,  1 Jan 2013 00:58:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vaZFndnJ6zQvm25zpCJ42ZvYdRA=; b=fPA2xR
	KFsRr8jkVAb3laGwXzb8R61AeaaZF7DlIvHzp6l9dVt962sC6YmR3hijJVa+490l
	xh5KJlGpO5PpyVZ35ugb5sIDiqPL4PGfUhUnPDqB9/2RFUnz+SKy1jDiQvtcVebO
	59RELKy4CCf+E/i79b/NK+lQOVsNCdwOaKKf8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K7n8/0knQO0dlfZJPqBziAc53rjkV0pP
	QK0bmDsQiMMQpLcCmvDFd1qf6J2FG0TcTpCBdCRdIFsa/RZOCCJ4Sy/OScjhD0Ji
	MY2nEOdk4Iy+/sDcB/aZ5Sp2wa53W4z8Fd4ca/6PCVRG8wY3bIfje0xjDKOLxlKl
	T7rqEKfKj0Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F341460F1;
	Tue,  1 Jan 2013 00:58:33 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 60F0B60F0; Tue,  1 Jan 2013
 00:58:33 -0500 (EST)
In-Reply-To: <87wqvxv96q.fsf@waller.obbligato.org> (greened@obbligato.org's
 message of "Mon, 31 Dec 2012 22:06:21 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 466BD518-53D8-11E2-B09D-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212416>

greened@obbligato.org writes:

> "David A. Greene" <greened@obbligato.org> writes:
>
>> From: Techlive Zheng <techlivezheng@gmail.com>
>>
>> Use %B to format the commit message and body to avoid an extra newline
>> if a commit only has a subject line.
>
> Wow.  So that was a spectacular fail.  Sorry about th duplicate patch
> e-mails.  I have no idea how that happened.
>
>                         -David

Also, please be careful about the subject line.  I doubt that these
8 patches will stand out as relating to "contrib/subtree", when mixed
in 200 line output of "git shortlog --no-merges".

Thanks.
