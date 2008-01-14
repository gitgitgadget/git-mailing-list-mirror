From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [msysGit] Re: safecrlf not in 1.5.4
Date: Mon, 14 Jan 2008 11:41:29 -0800
Message-ID: <7vsl10jity.fsf@gitster.siamese.dyndns.org>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>
	<1200022189-2400-2-git-send-email-mlevedahl@gmail.com>
	<7v1w8o4ws0.fsf@gitster.siamese.dyndns.org>
	<30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com>
	<7v63xzzszp.fsf@gitster.siamese.dyndns.org>
	<478855B5.9070600@gmail.com>
	<7vbq7ry405.fsf@gitster.siamese.dyndns.org>
	<47885B2C.8020809@gmail.com>
	<7v7iify2wm.fsf@gitster.siamese.dyndns.org>
	<4788BFA8.2030508@gmail.com>
	<7vwsqeubj8.fsf@gitster.siamese.dyndns.org>
	<47891658.3090604@gmail.com>
	<7vbq7qssd7.fsf@gitster.siamese.dyndns.org>
	<47893E1A.5020702@gmail.com>
	<7v4pdislrf.fsf@gitster.siamese.dyndns.org>
	<alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de>
	<7vir1xmazm.fsf@gitster.siamese.dyndns.org>
	<31687420-EB17-4651-AD6C-07213311ABDA@zib.de>
	<7vejcklv84.fsf@gitster.siamese.dyndns.org>
	<E4FD5B11-F61A-4838-B9AD-1E6F6C2B0AD6@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Jan 14 20:42:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEVCF-00070y-1E
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 20:42:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753872AbYANTlo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2008 14:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753506AbYANTlo
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 14:41:44 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40952 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197AbYANTln (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2008 14:41:43 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D7B982A19;
	Mon, 14 Jan 2008 14:41:41 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 117142A18;
	Mon, 14 Jan 2008 14:41:35 -0500 (EST)
In-Reply-To: <E4FD5B11-F61A-4838-B9AD-1E6F6C2B0AD6@zib.de> (Steffen Prohaska's
	message of "Mon, 14 Jan 2008 09:29:04 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70471>

Steffen Prohaska <prohaska@zib.de> writes:

> On Jan 14, 2008, at 8:30 AM, Junio C Hamano wrote:
>
>> By definition of 'maint', 1.5.4.X are to fix bugs in the
>> features that are in 1.5.4, so the answer is no.
>
> I expected this answer.

And it won't change.

>> But we could end up having a short cycle for 1.5.5 if we agree
>> that the lack of crlf=safe is a severe bug that is worth fixing
>> post 1.5.4.
> ...
> So I should try harder to find better arguments.  But this has
> time until the 1.5.4 release is out.  For now, I am being quiet.

Instead, you could be louder and convince people that it is a
severe bug worth fixing before 1.5.4, like Linus did with the
issue with performance regression on a partial commit.  It's
entirely your choice.

> (Well, I'll continue to improve the safecrlf patch and most
> likely will send it to the list, too...)

Please do.  "I am currently not convinced" does not mean "I am
always right" nor "I won't reconsider".
