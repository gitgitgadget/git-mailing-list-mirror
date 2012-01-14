From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Sending patches with KMail (Re: [PATCH] git-blame.el: Fix
 compilation warnings.)
Date: Fri, 13 Jan 2012 16:59:49 -0800
Message-ID: <7vlipbxfne.fsf@alter.siamese.dyndns.org>
References: <2608010.fNV39qBMLu@descartes> <20120112162617.GA2479@burratino>
 <2304907.sEfEeC6Eon@descartes> <20120113233158.GD7343@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?R=C3=BCdiger?= Sonderfeld <ruediger@c-plusplus.de>,
	git@vger.kernel.org, davidk@lysator.liu.se,
	Sergei Organov <osv@javad.com>, Kevin Ryde <user42@zip.com.au>,
	Michele Ballabio <barra_cuda@katamail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 14 01:59:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlryR-0002MG-CY
	for gcvg-git-2@lo.gmane.org; Sat, 14 Jan 2012 01:59:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758161Ab2ANA7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jan 2012 19:59:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50817 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759548Ab2ANA7w (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2012 19:59:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52A806C52;
	Fri, 13 Jan 2012 19:59:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RbtB/JuEHqXAgvd+oVdz+GZ3ctk=; b=omCyb1
	5ga8nfXmKVhZTG8F7J7zzu7XpyZDVWYaapTVc7M1wxBUOZLc0YpMVZEWViboWyoi
	3CPFdyHjGiFSgi+MWKqR7h2x+eXGTteQRHxsztjtx7YTQdhid5a2QATxZyWMrW1y
	6TaouMoQ8trxnsvu2xAq2mFhNaY1N/6DiKF8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mXzoReUnD7UEdhXY1Updz/p5FNkv2gnl
	hmy7dNVdSEL7IMdZPCWS2Y3h1ulkkiui9ZjVcGkQVeokJOCwFAxiQGjzjHovneA3
	HXbwnHkQ+MKLxQbuA8yqdAGD159d2tBC1AYjcsZus+hOyhqzDb+8dgC3R4kd24Md
	ePB3TuNI/Yg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 496586C51;
	Fri, 13 Jan 2012 19:59:51 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C224C6C50; Fri, 13 Jan 2012
 19:59:50 -0500 (EST)
In-Reply-To: <20120113233158.GD7343@burratino> (Jonathan Nieder's message of
 "Fri, 13 Jan 2012 17:31:58 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0FEACAC4-3E4B-11E1-9BD6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188544>

Jonathan Nieder <jrnieder@gmail.com> writes:

> The hints at [1] might also be useful, in case you would like to try
> and consider improving the manpage to document them if they work.

Don't you need similar updates to sections for other MUAs and procedures?

I suspect that the reason why you added the new text there is because you
know KMail users are very lazy bunch, and once they see a "KMail"
subsection, they will skip everything outside the subsection. Thunderbird
users would also be lazy---after choosing one of the three approaches
presented, they will skip anything outside the subsubsection. So I can
understand that we would need something in these individual subsections,
but the advice does not logically belong there.

Perhaps rephrasing the early part of the Discussion section, with an
illustration that is designed to be more visible, would be a better
approach?

For example, we could take your log message and stuff it there:

    The opening "From " line and following lines in "git format-patch" are
    for your mailer and should be omitted except for fields that differ from
    the mail header when reading your patch into an email body. For example,
    the output of your format-patch may begin like this:

          From 13c41b41b832d41680ccd33a2422ef8217965566 Mon Sep 17 00:00:00 2001
          From: Jonathan Nieder <jrnieder@gmail.com>
          Date: Fri, 13 Jan 2012 17:22:41 -0600
          Subject: Documentation/format-patch: mention removal of in-body headers

          The opening "From " line and following lines in ...

    The part you should send in the body of your e-mail message begins at the
    first blank line. The "From $SHA1 $magic_timestamp" line and other header
    lines are there to make it look like a mbox, and if you send it in e-mail,
    they will become redundant.

    You can leave "From:" and/or "Subject:" lines in, if they are
    different from the e-mail you will be sending out (e.g. you are
    forwarding a patch written by somebody else, as a follow up to an
    ongoing discussion and do not want the subject of your e-mail message
    to help threading).  E.g. your message _may_ begin like this:

          From: Jonathan Nieder <jrnieder@gmail.com>
          Subject: Documentation/format-patch: mention removal of in-body headers

          The opening "From " line and following lines in ...

    when you are not Jonathan, and you are sending it as a response to
    an existing discussion thread.

Or something like that?
