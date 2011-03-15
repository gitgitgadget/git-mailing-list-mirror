From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Question about used Workflows.
Date: Tue, 15 Mar 2011 10:57:13 -0700
Message-ID: <7voc5c9shy.fsf@alter.siamese.dyndns.org>
References: <20110315134331.GA5165@kudu.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git-List <git@vger.kernel.org>
To: Valentin Haenel <valentin@fsfe.org>
X-From: git-owner@vger.kernel.org Tue Mar 15 18:57:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzYUx-0005ez-1c
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 18:57:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758260Ab1COR50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2011 13:57:26 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45444 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758250Ab1COR50 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2011 13:57:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 821A14456;
	Tue, 15 Mar 2011 13:58:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=koROmWmYJSEHCZwYepqRyKTi+30=; b=lYZVIg
	2Kb83rlK2Ol6caMah1vad97gT9RpiKtaHmB58udfrymgI9ta9KNqBYtkfCevgaCb
	s69MGLOqFETWouxD7+OvwpWreJkX8mfOffVEXHmNmYajITzfA0Ptu1wt4wiEee+l
	EupCPUSBOp7cAZxzz2jQf7D23BYe3dN65tYV0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ofug9cG98X/0ste5vFCcLMxlRxP53M73
	XHxpGj+/wYxj4DP7+6NAOEJnyZ26/KZMDzW8A+W3lu688axz/TB6ogtVM2NvejFH
	X3iA7GJwjQFAQwcMwlb8ry01nZKaMu3yAnegPXGDinRYX7/9d5KgwsEz9KD7qL/l
	HXaZImHFW4s=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5C7594455;
	Tue, 15 Mar 2011 13:58:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5E0CB4453; Tue, 15 Mar 2011
 13:58:47 -0400 (EDT)
In-Reply-To: <20110315134331.GA5165@kudu.in-berlin.de> (Valentin Haenel's
 message of "Tue, 15 Mar 2011 14:43:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E1E184EA-4F2D-11E0-994A-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169083>

Valentin Haenel <valentin@fsfe.org> writes:

> I was wondering what kind of workflow the Git project itself uses. From
> what I gather much of the development takes place using the list, and
> patches sent by mail. Do any of the core contributers maintain public
> developer repos? And how many developers on average have push privileges
> to http://git.kernel.org/?p=git/git.git;a=summary?

Only I push into that repository, but first of all, everybody should stop
thinking "push" as a privilege.  That repository is like "my" home, and
the statement "I have a privilege to enter my home" does not have much
meaning.  It may be technically correct, but other people have the same
privilege to enter their homes (i.e. have their own public repositories
that only they can push into, and others can pull their work from there),
so it is not noteworthy.

Changes are reviewed on the list in patch form, and most of the time I've
been applying these changes to my tree and pushing the results out to my
public repository, but from time to time, other people do give me a pull
request, and I pull from them to integrate their work. The result again is
published by pushing it out to my public repository.

In a distributed world, the "primary" repository exists only by social
convention. My repository happens to be the primary one for now, but if
somebody wants to fork git and starts making a lot of good changes at a
rapid pace that neither I nor the current list reviewers can keep up with,
the repository of that person may become a more popular source of the
cutting-edge version of git, and if that continues, it may become the
"primary" one, at which point the list (including me) may decide that it
is a good idea to turn the maintainership to that new person.

When I had to leave the net for extended period of time (which happened a
few times in the past), I don't give the key to my home ("push privilege")
to an interim maintainer. Instead, the interim maintainer keeps his own
public repository ("his home"), and pushes to that repository by playing
exactly the same role as I do, picking up well-reviewed patches from the
mailing list and responding to pull requests. In the meantime, people work
off of his repository. When I come back, I can pull from the interim
maintainer and the continuity of the end-result history is maintained.
