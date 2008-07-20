From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-add -a: add all files
Date: Sun, 20 Jul 2008 11:30:21 -0700
Message-ID: <7v4p6k8l36.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0807161804400.8950@racer>
 <alpine.DEB.1.00.0807171915420.8986@racer>
 <7vtzeofjpi.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807171940160.8986@racer> <48806897.1080404@fastmail.fm>
 <76718490807181318o228171f9j836aaca2edb9b377@mail.gmail.com>
 <7vsku5grpr.fsf@gitster.siamese.dyndns.org>
 <7vk5fhgrm6.fsf_-_@gitster.siamese.dyndns.org>
 <905315640807192120k45b8c0e3k5b341e77c466dde@mail.gmail.com>
 <alpine.DEB.1.00.0807201250530.3305@eeepc-johanness>
 <76718490807200545l653bbda1l4d13f1e1e698c855@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	Tarmigan <tarmigan+git@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Michael J Gruber" <michaeljgruber+gmane@fastmail.fm>
To: "Jay Soffian" <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 20 20:31:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKdgx-0001nD-AH
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 20:31:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbYGTSac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 14:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750702AbYGTSac
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 14:30:32 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58297 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794AbYGTSab (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 14:30:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 3BE2A34644;
	Sun, 20 Jul 2008 14:30:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 915733461E; Sun, 20 Jul 2008 14:30:23 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EF10E38A-5689-11DD-A611-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89209>

"Jay Soffian" <jaysoffian@gmail.com> writes:

> On Sun, Jul 20, 2008 at 6:56 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> Two things:
>>
>> - add and commit are two _different_ operations, not only in name, but
>>  also in nature.  The fact that "commit -a" calls "add" is a _pure_
>>  convenience.  It does not change the fact that "add" and "commit" are
>>  completely, utterly different.
>>
>> - if you are a heavy user of "commit -a", chances are that your history is
>>  not really useful, because you committed unrelated changes accidentally
>>  in the same commit.
>>
>> The latter point, BTW, is the reason I _never_ teach the "-a" option
>> (actually, I teach no option at all) in my first two Git lessons.
>
> I don't like "commit -a" and never use it and wonder why a
> short-option was wasted on it.
>
> I do like the new "add -a" (thank you Junio) but I will rarely use it.

I do not understand either of you.  If for whatever reason "add -A" makes
sense in your workflow, it's a sign that you are extremely disciplined
that changes in your working tree at one point of time where you would
issue "add -A" are concentrated on a single topic, and at one of such
points you may want to commit.  For such a disciplined person, "commit -a"
would make perfect sense there.

So for such people who would find "add -A" useful, "commit -a" will not be
"unrelated changes in the same commit".  And for such people, I would even
say "commit -A" would be even more useful, too.

I'll never be in that camp of perfect people myself, though..
