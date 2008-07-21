From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add a notice to the doc of git-ls-tree.
Date: Sun, 20 Jul 2008 21:28:59 -0700
Message-ID: <7vljzvyi5w.fsf@gitster.siamese.dyndns.org>
References: <1216592735-23789-1-git-send-email-code@istique.net>
 <20080720230846.GH32184@machine.or.cz>
 <7vy73w16nj.fsf@gitster.siamese.dyndns.org>
 <7vtzek15b5.fsf@gitster.siamese.dyndns.org>
 <20080721000824.GI10151@machine.or.cz>
 <7vljzw14br.fsf@gitster.siamese.dyndns.org>
 <20080721002248.GJ10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steve =?utf-8?Q?Fr=C3=A9cinaux?= <code@istique.net>,
	git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jul 21 06:30:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKn2J-0008DS-Bd
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 06:30:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751644AbYGUE3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 00:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbYGUE3M
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 00:29:12 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51201 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131AbYGUE3L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 00:29:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6E3E72E537;
	Mon, 21 Jul 2008 00:29:06 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C46A22E533; Mon, 21 Jul 2008 00:29:02 -0400 (EDT)
In-Reply-To: <20080721002248.GJ10151@machine.or.cz> (Petr Baudis's message of
 "Mon, 21 Jul 2008 02:22:48 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8E321814-56DD-11DD-A1D8-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89299>

Petr Baudis <pasky@suse.cz> writes:

> On Sun, Jul 20, 2008 at 05:14:16PM -0700, Junio C Hamano wrote:
>> I never thought you would think "showing relative to tree-root" is even an
>> option.
>
> I assume you mean "not filtering relative to tree-root"?

Sorry, I may have been unclear.  I meant "showing relative to tree-root,
unlike showing relative to cwd like we have done forever".

Changing the behaviour would affect usage like this:

	$ cd some/where
        $ git ls-files
        $ git ls-tree --name-only -r HEAD^

    cf. http://thread.gmane.org/gmane.comp.version-control.git/13028/focus=13080
