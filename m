From: Michael Stefaniuc <mstefani@redhat.com>
Subject: Re: [PATCH] git-am: Run git gc only once and not for every patch.
Date: Sat, 05 Jan 2008 17:23:49 +0100
Message-ID: <477FAF15.6020202@redhat.com>
References: <20080104185926.GA11912@redhat.com>	<alpine.LFD.1.00.0801041437190.2649@xanadu.home>	<7vhchtjphk.fsf@gitster.siamese.dyndns.org>	<477EA06A.5090606@redhat.com>	<7vmyrli73h.fsf@gitster.siamese.dyndns.org> <7vve68ep78.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 17:24:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBBp8-0005QS-4n
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 17:24:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755265AbYAEQYK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 11:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755453AbYAEQYJ
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 11:24:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:35940 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754704AbYAEQYI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 11:24:08 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m05GNpSW012514;
	Sat, 5 Jan 2008 11:23:51 -0500
Received: from pobox.stuttgart.redhat.com (pobox.stuttgart.redhat.com [172.16.2.10])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m05GNoZb026855;
	Sat, 5 Jan 2008 11:23:50 -0500
Received: from argon.maulnet (vpn-4-50.str.redhat.com [10.32.4.50])
	by pobox.stuttgart.redhat.com (8.13.1/8.13.1) with ESMTP id m05GNnot005117;
	Sat, 5 Jan 2008 11:23:50 -0500
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <7vve68ep78.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69677>

Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> ...
>> I do not think moving "gc --auto" outside the loop hurts in
>> practice because you are not likely to be rebasing a truly huge
>> series every day, but cruft can accumulate during "git am" run
>> and the "gc --auto" inside loop was meant to clean them up.  The
>> idea was taken from importers that run repack every once in a
>> while (e.g. cvsimport runs every 1k commits), but "gc --auto"
>> was designed to be much more lightweight than a full repack and
>> that was the reason it was placed in the loop without counting
>> "every N commits".
> 
> Having said all that, I'll take your patch as-is except that I'd
Thanks.

> drop the later part of the commit log message that explains
> Wine's practice.
Yeah, sorry about that. That should have been outside of the commit
message anyway. But forgot about it as the Wine maintainer takes only
the subject as commit message.

bye
	michael
