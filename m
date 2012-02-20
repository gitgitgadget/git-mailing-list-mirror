From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 0/5] diff --ignore-case
Date: Mon, 20 Feb 2012 15:06:30 +0100
Message-ID: <871upp4n15.fsf@thomas.inf.ethz.ch>
References: <1329704188-9955-1-git-send-email-gitster@pobox.com>
	<4F420749.9010206@kdbg.org> <7v8vjxnayn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Johannes Sixt <j6t@kdbg.org>, <git@vger.kernel.org>,
	Chris Leong <walkraft@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 20 15:06:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzTt0-0004IF-Gq
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 15:06:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752805Ab2BTOGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 09:06:33 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:44914 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752352Ab2BTOGd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 09:06:33 -0500
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 20 Feb
 2012 15:06:29 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 20 Feb
 2012 15:06:30 +0100
In-Reply-To: <7v8vjxnayn.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 20 Feb 2012 00:52:16 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191069>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Sixt <j6t@kdbg.org> writes:
>
>> Am 20.02.2012 03:16, schrieb Junio C Hamano:
>>> This teaches our "diff" machinery to optionally consider lines that are
>>> different only in upper/lower-cases to be equivalent.
>>
>> When would I want to use --ignore-case?
>
> I wouldn't myself; it was just I saw somebody asked if -G can be used to
> do case insensitive and then I realized we do not even support such in the
> diff machinery to begin with, but now this opens a way to do so by copying
> the xdl options when the pickaxe-grep codepath runs a subdiff.

I wonder which one of us misunderstood the original request ;-)

It was

} Is there any way to run diff -G with a case insensitivity flag?

and I took that to mean "I want to find addition/removal of a string
like -G does, but I don't know how it was capitalized".  OTOH you
interpreted it as "I want to run -G but ignore changes in case while
diffing".

So maybe Chris can comment on what was intended?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
