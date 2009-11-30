From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Give the hunk comment its own color
Date: Mon, 30 Nov 2009 01:00:59 -0800
Message-ID: <7vvdgstmic.fsf@alter.siamese.dyndns.org>
References: <7v4oogzo74.fsf@alter.siamese.dyndns.org>
 <1259304918-12600-1-git-send-email-bert.wesarg@googlemail.com>
 <7vhbsfi4bz.fsf@alter.siamese.dyndns.org>
 <36ca99e90911280408v186777f1h22254744fb61bf1f@mail.gmail.com>
 <36ca99e90911292307w769913fdn1f610eeb065b41e@mail.gmail.com>
 <7v4ooczdoe.fsf@alter.siamese.dyndns.org>
 <36ca99e90911292341o524840ebo47d79f06b1588d5c@mail.gmail.com>
 <7vtywcwj1o.fsf@alter.siamese.dyndns.org>
 <fabb9a1e0911300009j1574c06cy500dde75fc68662f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 30 10:01:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF28F-0006BH-8K
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 10:01:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649AbZK3JBH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 04:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbZK3JBG
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 04:01:06 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52496 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217AbZK3JBF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 04:01:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 22B1E18DC;
	Mon, 30 Nov 2009 04:01:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=m1NvSWArmIyM2G2irmwtZIMTrR0=; b=Oxd8PIBhEYh6ZjmRStRVx+A
	Kp+4Wfr8GruloN0huvkg9FeEF732dchku4Jm6lUnXw3rHgFaiBrOxVUA29SS00Oh
	8yvByIM40JlMEfLvzw906jtpX23RGC97ZhoP0mhDouJZwVU96jcusQHonxlQZUvu
	KPSPK5SppHnAQbyfERTM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=j9j/vUis3/X1rHdkTIrhdciSUHRbOjue55N1oPQofin/g93ju
	HxONxyrtr8n2l1P72o6Glh1Epo8LCefZPIy5esBYzP1IVvlTyGbeKyMEMZKt/Eva
	H4+7cEPa2BdGPRAKsW5qax1WgRD18Zw4ev0TqpC+hvZIvNUJFYbsHkvKA4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D130718DB;
	Mon, 30 Nov 2009 04:01:06 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2637718DA; Mon, 30 Nov
 2009 04:01:00 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E533FA5E-DD8E-11DE-8702-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134086>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Mon, Nov 30, 2009 at 08:47, Junio C Hamano <gitster@pobox.com> wrote:
>
>> I'll merge the updated (i.e. rewound and then rebuilt) tip
>> of the topic branch when the topic graduates to the master (hopefully
>> before 1.6.6-rc1), so we won't see the botched one in the end result.
>
> I'm curious how you do this. Do you keep a list of replacements, that
> is "when merging branch foo from next to master, instead merge bar",
> or is it something the original author should remind you of when it's
> time to merge to master?

If you run "git log --oneline --first-parent master..pu", you will notice
that there is no "Merge ... into next" at all.

I maintain a private 'jch' branch that merges everything that has been
merged so far to 'next' and the branch always builds on top of 'master'
whenever 'pu' is pushed out.  The tree object recorded by the tip of 'jch'
is designed to always match that of 'next'.  And 'pu' is built on top of
'jch', instead of 'next', these days.

The Reintegrate script fron 'todo' (recall that I have a checkout of the
branch in "Meta/" directory) is used this way:

    ... update 'jch' by merging topics that had new commits
    $ git checkout jch && git merge xx/topic && ...
    ... update the list of topics
    $ Meta/Reintegrate master..jch >/var/tmp/redo-jch.sh

    ... update 'master' with commits and merges
    $ git checkout master
    $ git am trivially-correct-patch.mbox
    $ git merge yy/topic

    ... update 'next'
    $ git checkout next
    $ git merge master
    ... will merge new topics and topics that had new commits
    $ sh /var/tmp/redo-jch.sh

    ... rebuild 'jch' on top of the updated master
    $ git checkout jch
    $ git reset --hard master
    $ sh /var/tmp/redo-jch.sh

    ... then this shouldn't produce any output
    $ git diff next

This time, what I did _after_ Bert noticed my typo was:

    $ git checkout bw/diff-color-hunk-header
    $ edit diff.c ;# fix my typo
    $ git commit --amend -a
    $ git diff HEAD@{1} >P.diff
    $ git checkout next
    $ git apply --index P.diff
    $ git commit -m 'typofix'

After this, while rebuilding 'jch' branch the next time, Reintegrate
script will notice that the bw/diff-color-hunk-header topic has been
rebased.  I can simply edit that note out in the /var/tmp/redo-jch.sh
script and rebuild 'jch' branch---the result will exactly match 'next'.

The end result is that the commit merged in 'next' is not the tip of
bw/diff-color-hunk-header anymore, but merging the _current_ tip of that
branch together with all the other topics on top of 'master' would produce
the desired result without "oops---that was a stupid typo" fixups.
