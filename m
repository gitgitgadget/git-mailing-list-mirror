From: Raman Gupta <rocketraman@fastmail.fm>
Subject: Re: [PATCH 2/2] Add feature release instructions to gitworkflows
 man page
Date: Mon, 30 Mar 2009 14:40:11 -0400
Message-ID: <49D1120B.8060601@fastmail.fm>
References: <1238391319-4953-1-git-send-email-rocketraman@fastmail.fm> <1238391319-4953-2-git-send-email-rocketraman@fastmail.fm> <7vk567ijlf.fsf@gitster.siamese.dyndns.org> <49D10875.2060008@fastmail.fm> <7vljqmdgj0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 30 20:42:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoMR4-0001gv-Kg
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 20:42:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756770AbZC3SkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 14:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756718AbZC3SkV
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 14:40:21 -0400
Received: from smtp104.rog.mail.re2.yahoo.com ([206.190.36.82]:48190 "HELO
	smtp104.rog.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755205AbZC3SkU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Mar 2009 14:40:20 -0400
Received: (qmail 15558 invoked from network); 30 Mar 2009 18:40:17 -0000
Received: from unknown (HELO apollo.rocketraman.com) (rocketraman@99.224.155.40 with login)
  by smtp104.rog.mail.re2.yahoo.com with SMTP; 30 Mar 2009 18:40:17 -0000
X-YMail-OSG: cvCTlysVM1mCWByt5zEyLqIaKDHeUXKYbR2aVxsbQLeMYqCsRNt0xqO7HA5fRZfesg--
X-Yahoo-Newman-Property: ymail-3
Received: from localhost (localhost.localdomain [127.0.0.1])
	by apollo.rocketraman.com (Postfix) with ESMTP id 336AB638E38;
	Mon, 30 Mar 2009 14:40:17 -0400 (EDT)
X-Virus-Scanned: amavisd-new at rocketraman.com
Received: from apollo.rocketraman.com ([127.0.0.1])
	by localhost (apollo.rocketraman.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9-g4K0SC8nFB; Mon, 30 Mar 2009 14:40:11 -0400 (EDT)
Received: from [192.168.1.5] (zeus.rocketraman.com [192.168.1.5])
	by apollo.rocketraman.com (Postfix) with ESMTP id 706AB21C0519;
	Mon, 30 Mar 2009 14:40:11 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <7vljqmdgj0.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115186>

Junio C Hamano wrote:
> Raman Gupta <rocketraman@fastmail.fm> writes:
> 
>> Junio C Hamano wrote:
>> ...
>> If you wish to remove discussion of 'next' from this document, that is
>> probably better done in a separate followup change. Though personally
>> I think its a useful concept for readers to learn about as they are
>> setting up their own workflows.
> 
> I do not have a particularly strong feeling about 'next' either way.
> 
> As the document states at the top, it lists ingredients from git.git
> management and it is left up to the readers to adopt parts that suit their
> needs, while not using others.  In that spirit, the description of 'next'
> as "ahead of master that is supposed to be rock solid" may be a good thing
> to keep.  It is orthogonal if the project wants to rewind and rebuild
> 'next' after every feature release---they do not need to (and we didn't do
> so for quite some time).  One valid choice by readers is to adopt the
> concept of 'next' in their project but never rewind and rebuild it, and
> you made that clear that it is optional.  So I think this part of your
> patch is good as-is.

It might be useful to add some explanation of why one would want to
rewind and rebuild vs simply continue as is.

I guess the advantage is that the history for next starts out nice and
clean for the next release, without any cruft from repeated merging of
topic branches.

The disadvantage is that one must publish the operation and all forks
must deal with the rebase.

Any other thoughts?

Cheers,
Raman
