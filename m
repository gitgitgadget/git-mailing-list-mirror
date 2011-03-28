From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/10] Docs: git tag
Date: Mon, 28 Mar 2011 11:04:25 -0700
Message-ID: <7v8vvzyvdi.fsf@alter.siamese.dyndns.org>
References: <1301327622-8595-1-git-send-email-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 20:04:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4Gnv-0001se-6Q
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 20:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754596Ab1C1SEh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 14:04:37 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65167 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754470Ab1C1SEg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 14:04:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4577F4CB2;
	Mon, 28 Mar 2011 14:06:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f67zvWPmyICU0OCkVu3o1FL1UMw=; b=u5v+5w
	AVO02Wfp5Pztiho4kFFQgsy+ekotTkFTm15KuorxgQUcVa4nmEj+h9PZh9T5yjsn
	IJWYR7oLUHtKRzGUqKeidCmN+rVdDB3HB6uZnSd31KWhxjiYElGfKve7WKxIJtmO
	YbbZiPD8ovgZgdUNHnTprtGETPNYj5/xCIKwI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rbfykXsewA6yQF7uULJqhAPF1WKxb/YC
	Bv81VdkhdGbeqcpiAiy7uMvOMPC+nL3wUsThPtfUvuBU4cCt1qb//FTKtE6W91+X
	x0vX5cjWmtQggtzX8K6Vdbz9QmymAxkBvoJm8yWNtflK1+qeA5ffguvwUpSafRj4
	H17Lp3mOjqQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2224D4CAE;
	Mon, 28 Mar 2011 14:06:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 39A9F4CAC; Mon, 28 Mar 2011
 14:06:13 -0400 (EDT)
In-Reply-To: <1301327622-8595-1-git-send-email-mfwitten@gmail.com> (Michael
 Witten's message of "Mon, 28 Mar 2011 15:32:06 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 138C0B4A-5966-11E0-B987-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170169>

Michael Witten <mfwitten@gmail.com> writes:

> Small patches fixing up the `git tag' docs.
>
> Michael Witten (10):
>   Docs: git tag: Add `the'
>   Docs: git tag: peoples back -> people's backs
>   Docs: git tag: Revise a paragraph.
>   Docs: git tag: other's -> the other person's
>   Docs: git tag: Streamline a sentence.
>   Docs: git tag: Add missing 'the'
>   Docs: git tag: Use 'who' again
>   Docs: git tag: Remove superfluous 'with'
>   Docs: git tag: Use semicolon
>   Docs: git tag: Rewrite discussion of GIT_COMMITTER_DATE

Thanks; all looked sensible changes, except for 7/10 which I somehow find
the original is more readable than the new text, partly because the
sentences are shorter but more importantly because the two sentences make
two separate assertions (the first is about what "one-shot" pull means,
the second is about why automatic tag following is not desired in that
situation).
