From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't add To: recipients to the Cc: header
Date: Mon, 26 Nov 2007 08:53:09 -0800
Message-ID: <7v3autgd8q.fsf@gitster.siamese.dyndns.org>
References: <1195470026-7389-1-git-send-email-ask@develooper.com>
	<7vr6ill5f1.fsf@gitster.siamese.dyndns.org>
	<7A3DDFA5-085D-4D92-BE96-A405FF1FB029@develooper.com>
	<7v8x4slovk.fsf@gitster.siamese.dyndns.org>
	<87ejekzpx3.fsf@osv.gnss.ru>
	<7vr6ikk6rf.fsf@gitster.siamese.dyndns.org>
	<87lk8orgpm.fsf@osv.gnss.ru>
	<7vejegu4in.fsf@gitster.siamese.dyndns.org>
	<87hcjcra10.fsf@osv.gnss.ru>
	<7vejegsejz.fsf@gitster.siamese.dyndns.org>
	<87wss5p177.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ask =?utf-8?Q?Bj=C3=B8rn?= Hansen <ask@develooper.com>,
	git@vger.kernel.org
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 17:56:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwhFb-0000jq-E8
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 17:56:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759329AbXKZQxS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 11:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758214AbXKZQxS
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 11:53:18 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:57871 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757282AbXKZQxR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 11:53:17 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 77CC62EF;
	Mon, 26 Nov 2007 11:53:37 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id EE61699F0C;
	Mon, 26 Nov 2007 11:53:33 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66084>

Sergei Organov <osv@javad.com> writes:

>> GNU folks even managed to insert text that allows a completely empty
>> line (not a line with a single SP on it) to express a context line
>> that is empty, which means...
>
> Really? That's a surprise for me. What I can tell for sure, Emacs' diff
> mode doesn't support this, as it does interpret plain empty line as a
> hunk delimiter, at least in Emacs 22.1.

See b507b465f7831612b9d9fc643e3e5218b64e5bfa (git-apply: prepare for
upcoming GNU diff -u format change).  Around the time that eventually
lead to this commit (mid October 2006) there was a discussion on this
mailing list on the issue, too.  I do not doubt you checked with your
version of Emacs diff mode that it does not support this yet, but it's
only prudent to assume that a new version someday will.
