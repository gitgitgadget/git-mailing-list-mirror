From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Add submodule-support to git archive
Date: Sun, 25 Jan 2009 12:35:16 -0800
Message-ID: <7veiyrdszf.fsf@gitster.siamese.dyndns.org>
References: <1232844726-14902-1-git-send-email-hjemli@gmail.com>
 <20090125135340.6117@nanako3.lavabit.com>
 <8c5c35580901250018x6827291cj36e6bcb10afa9b27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 25 21:36:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRBir-00017I-4e
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 21:36:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbZAYUf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 15:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbZAYUfZ
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 15:35:25 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35255 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127AbZAYUfY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 15:35:24 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id F2E711D471;
	Sun, 25 Jan 2009 15:35:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4FCC21D472; Sun,
 25 Jan 2009 15:35:18 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B12A338E-EB1F-11DD-96D2-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107095>

Lars Hjemli <hjemli@gmail.com> writes:

> On Sun, Jan 25, 2009 at 05:53, Nanako Shiraishi <nanako3@lavabit.com> wrote:
>> What would I do to try this new series? Fork a branch from Junio's master branch,
>> apply your new patches, and merge the result to Junio's next?
>
> Yes, that sounds right (btw: the series is buildt on top of 5dc1308562
> (Merge branch 'js/patience-diff') and can be pulled from
> git://hjemli.net/pub/git/git lh/traverse-gitlinks).
>
> But before merging with 'next', you'll need to `git revert -m 1 bdf31cbc00`.

Yuck, that is too much to ask for regular testers and users.

Could we switch to incremental refinements once a series hits next, pretty
please?
