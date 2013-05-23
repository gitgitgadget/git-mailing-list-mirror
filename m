From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] Add new git-related helper to contrib
Date: Thu, 23 May 2013 16:47:26 -0700
Message-ID: <7vvc69b6nl.fsf@alter.siamese.dyndns.org>
References: <1368978823-18247-1-git-send-email-felipe.contreras@gmail.com>
	<7vr4gyizti.fsf@alter.siamese.dyndns.org>
	<CAMP44s0pXLmjVUwsVWiN2G5QReh80spXjvy_6GuUGRz1RmUbLQ@mail.gmail.com>
	<7vd2siiqsr.fsf@alter.siamese.dyndns.org>
	<CAMP44s2ETSxebGxXJV_BYEqTC5gJMVdQLbnTUomrie2rHhdmDg@mail.gmail.com>
	<7v8v36iq3e.fsf@alter.siamese.dyndns.org>
	<7v4nduipvb.fsf@alter.siamese.dyndns.org>
	<7vzjvmh98r.fsf@alter.siamese.dyndns.org>
	<CAMP44s1_=HSgZA=abHJ3sgDbUyfkF78qO+sR1+Aact3o7bAgLA@mail.gmail.com>
	<7vvc6ah81g.fsf@alter.siamese.dyndns.org>
	<CAMP44s37a0_wVVef+QVnLNvc8Uos_XpCZAtpX0RmQyMcuJHUHw@mail.gmail.com>
	<CAMP44s18ps9JtY7+mvXVbuZu3cm7bHnK1vCzMWqBdvawLr+zzA@mail.gmail.com>
	<7v8v35hc11.fsf@alter.siamese.dyndns.org>
	<CAMP44s0X-79Pn4gq_rqBbti-xUobyYDc8Gy-3-g=sq8siZqq8g@mail.gmail.com>
	<7vppwhcqjq.fsf@alter.siamese.dyndns.org>
	<CAMP44s3LcEkTghg-cBRux7sA54L-U93w5Znqa1jz2MnUWj8Rhw@mail.gmail.com>
	<7vhahtco5b.fsf@alter.siamese.dyndns.org>
	<CAMP44s14Gdadmgy2zi6dRnKLYdZ=HO85OiPSVxGZ8Hquv_58=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 24 01:47:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UffEW-0004YY-UX
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 01:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759923Ab3EWXr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 19:47:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51268 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759898Ab3EWXr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 19:47:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6275121AB0;
	Thu, 23 May 2013 23:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lFUyxr+HNQ5JSdJhZA8greRJ18o=; b=vD1KHK
	giI/vhTsJrhUJ3sThF6q8nf+DLuK3+iW8bYba4IXLcX6NL85fug+3cUEia122HDH
	RwDNb2xUtJ6pRKs00jktS+COOaNSGtk1YvgStlMoaOaky93cK7srRQy8p2pNGi1F
	WTpcp9iYczruBg/XFMY1h7ThJzZqIYNuivHi8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HYdNuou7+LmjG0p5LNFYJISxyyzMtRsp
	v5Y2e/vMP07ESKC4dMNvzEAL3RvAhx6ZPrLDr3g3yH4XcgOkqpVXCsbGYp5lod67
	7XTXDPbQhz9SXmh4jVM8DBKZYBalfDOre92wIg/xJZ0qbZ/p7OEtLWhDE6fOAH13
	xBZhFdIbViY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 561F221AAE;
	Thu, 23 May 2013 23:47:28 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A987921AAB;
	Thu, 23 May 2013 23:47:27 +0000 (UTC)
In-Reply-To: <CAMP44s14Gdadmgy2zi6dRnKLYdZ=HO85OiPSVxGZ8Hquv_58=g@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 23 May 2013 17:59:37 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 201A1974-C403-11E2-815C-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225320>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> If the change in HEAD^ in the above example were to copy the whole A
>> and C from a different file, then your !found_guilty logic would
>> kick in and say all lines of A where copied from elsewhere in HEAD^,
>> but again we would not learn the same information for C.
>
> We would, when it's the turn for C, which is not guilty at this point.

In _this_ round of the while(1) loop, pass_blame_to_parent() gets
the scoreboard and two origins (HEAD^ that we are looking at and
HEAD^^ that is its parent); it does not even know what blame entry
this request came from.

It runs a single diff using diff_hunks(), and asks blame_chunk() to
split all the blame entries in the scoreboard that suspect it is
looking at may be guilty for.  Blame entry for A and C are both
processed exactly the same way when HEAD^ is given to pass_blame()
for the first time, which is when assign_blame() decided to call it
with HEAD^ because it happened to have seen A before seeing C.  At
that point, both A and C are processed, and the post-processing loop
"Take responsibility for the remaining" will clean up remnants from
both A and C.  After this round ends, the suspect for A and C are
both set to HEAD^^.

In the next round of the while(1) loop, C already forgot that its
line movement happened in HEAD^.  Its suspect is now HEAD^^.  When
"it's the turn for C" [*1*], you can say "These lines originate in
that different path in HEAD^^", but it is too late to say "But the
first time they appeared in the original file was HEAD^" (which is
when they were moved from the different path in HEAD^^), isn't it?


[Footnote]

*1* It does not make much sense to say "turn for C", by the way.
    pass_blame() work per suspect (not per blame entry), so what you
    are talking about really is "when it is turn for HEAD^^", at
    which point we will discover that these lines in C originate in
    that different path in the commit.  And in the scenario we are
    discussing, we will decide to check HEAD^^ because the blame ent
    for A is also the same origin as C's suspect in HEAD^^, so
    technically it is still "turn for A" ;-).

    The sample would be like

	(cat A; cat C) >file0; git commit file0	 ; HEAD^^
	(cat A; cat C) >file1; git commit file1	 ; HEAD^
        (cat A; cat B; cat C) >file1; git commit file1 ; HEAD
        git blame -C -C -C file1 HEAD


        
