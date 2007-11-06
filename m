From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-revert is one of the most misunderstood command in  git, help users out.
Date: Tue, 06 Nov 2007 11:42:26 -0800
Message-ID: <7vir4fgnz1.fsf@gitster.siamese.dyndns.org>
References: <1194289301-7800-1-git-send-email-madcoder@debian.org>
	<CD2E6759-9E7E-41E6-8B58-AB6CA9604111@midwinter.com>
	<7vlk9cmiyq.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0711052325090.4362@racer.site>
	<7vsl3kjdct.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0711060317220.4362@racer.site>
	<7vode8j7o5.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0711061230540.4362@racer.site>
	<7v8x5bi703.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0711061827030.4362@racer.site>
	<20071106193959.GB4382@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Nov 06 20:43:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpUKF-00075x-Ef
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 20:43:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755116AbXKFTme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 14:42:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755057AbXKFTme
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 14:42:34 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:44631 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754877AbXKFTmd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 14:42:33 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 3B3762EF;
	Tue,  6 Nov 2007 14:42:55 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 59CEE92AF8;
	Tue,  6 Nov 2007 14:42:50 -0500 (EST)
In-Reply-To: <20071106193959.GB4382@artemis.corp> (Pierre Habouzit's message
	of "Tue, 06 Nov 2007 20:39:59 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63708>

Pierre Habouzit <madcoder@debian.org> writes:

> On Tue, Nov 06, 2007 at 06:27:54PM +0000, Johannes Schindelin wrote:
>> Hi,
>> 
>> On Tue, 6 Nov 2007, Junio C Hamano wrote:
>> 
>> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> > 
>> > > Well, I think that _if_ we allow "git revert <path>" to mean "revert the 
>> > > changes to <path>, relative to the index" (which would be the same as "git 
>> > > checkout <path>"), then committing that change just does not make sense.
>> > >
>> > > And it is this behaviour that people are seeking, not "git revert <commit> 
>> > > <path>".
>> > 
>> > Heh, I found this in the recent log somewhere.
>> > 
>> > <gitte> Really, I wonder how difficult git is for people who are not
>> > 	brainwashed by cvs/svn, and unfortunately enough, partly by bzr and hg.
>> > <gitte> From a user perspective, you might be correct.  But then we have to
>> > 	add 1000 commands to reflect the English language.
>> > <gitte> Not what I want.						[06:46]
>> > 
>> > I am wondering who said it ;-).
>> 
>> Now, that is not fair, using my own words against me ;-)
>
>   That's very funny actually :]

Yeah, it was doubly funny after I saw you posted a list of "$scm revert"
and Dscho still sided with you in that thread.
