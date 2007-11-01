From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 01 Nov 2007 13:57:02 -0700
Message-ID: <7vr6j9adlt.fsf@gitster.siamese.dyndns.org>
References: <20071022063222.GS14735@spearce.org>
	<7vzly84qwf.fsf@gitster.siamese.dyndns.org>
	<7vmytycykt.fsf@gitster.siamese.dyndns.org>
	<fgcbjr$3pc$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 21:57:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inh6S-0008LP-Ca
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 21:57:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370AbXKAU5J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Nov 2007 16:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753419AbXKAU5J
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 16:57:09 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:60759 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753290AbXKAU5I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Nov 2007 16:57:08 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 8EE242EF;
	Thu,  1 Nov 2007 16:57:28 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 1C79391235;
	Thu,  1 Nov 2007 16:57:25 -0400 (EDT)
In-Reply-To: <fgcbjr$3pc$1@ger.gmane.org> (Jakub Narebski's message of "Thu,
	01 Nov 2007 12:02:46 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62996>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>
>> * jc/stash-create (Mon Jul 9 00:51:23 2007 -0700) 2 commits
>> =C2=A0+ rebase: allow starting from a dirty tree.
>> =C2=A0+ stash: implement "stash create"
>>=20
>> Will revert at least the latter one, but perhaps both, from
>> 'next'. =C2=A0The traditional behaviour of refusing to work in a
>> dirty tree is much safer, as the tool cannot decide where to
>> unstash for you.
>
> One of frequently requested features is ability to rebase and merge
> in a dirty tree (CVS-like). Perhaps we should advocate git-stash bett=
er,
> e.g. in error message for git-rebase / git-merge / git-pull when in d=
irty
> state.

I am of two minds about that.  Suggesting to "stash first, do
your thing and unstash" certainly is helpful than not
suggesting.  But wanting to do things in a dirty state, only
because CVS did not allow you to do anything else, is a bad
inertia on the user's side in the first place, and that
helpfulness would actively _encourage_ to keep that bad inertia,
instead of educating the users to think in git-way.
