From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: grafts generalised
Date: Wed, 02 Jul 2008 14:27:30 -0700
Message-ID: <7vlk0k7z99.fsf@gitster.siamese.dyndns.org>
References: <20080702143519.GA8391@cuci.nl>
 <37fcd2780807021019t76008bbfq265f8bf15f59c178@mail.gmail.com>
 <37fcd2780807021058r5ed820cfmdc98f98f36d5c8ae@mail.gmail.com>
 <20080702181021.GD16235@cuci.nl>
 <37fcd2780807021339u582f340dq2b2014951d5b7f63@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Stephen R. van den Berg" <srb@cuci.nl>, git@vger.kernel.org
To: "Dmitry Potapov" <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 23:28:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE9sb-0000VU-D2
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 23:28:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753709AbYGBV1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 17:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754414AbYGBV1q
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 17:27:46 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58290 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753546AbYGBV1p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 17:27:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E845796C0;
	Wed,  2 Jul 2008 17:27:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 39BC396BE; Wed,  2 Jul 2008 17:27:38 -0400 (EDT)
In-Reply-To: <37fcd2780807021339u582f340dq2b2014951d5b7f63@mail.gmail.com>
 (Dmitry Potapov's message of "Thu, 3 Jul 2008 00:39:24 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B49E9DF6-487D-11DD-B309-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87193>

"Dmitry Potapov" <dpotapov@gmail.com> writes:

> On Wed, Jul 2, 2008 at 10:10 PM, Stephen R. van den Berg <srb@cuci.nl> wrote:
>>
>> In that case, I will stick to extending git fsck to check grafts more
>> rigorously and fix git clone to *refrain* from looking at grafts.
>
> Linus suggested that "git-fsck and repacking should just consider
> it[grafts] to be an  _additional_ source of parenthood rather than
> a _replacement_ source."
>
> http://article.gmane.org/gmane.comp.version-control.git/84686

Yeah, thanks for a reminder.

    http://thread.gmane.org/gmane.comp.version-control.git/37744/focus=37866

is still on my "things to look at" list.
