From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's in git.git (stable frozen)
Date: Mon, 07 Jan 2008 14:14:18 -0800
Message-ID: <7vve65xozp.fsf@gitster.siamese.dyndns.org>
References: <20071022061115.GR14735@spearce.org>
	<7vhchq11n2.fsf@gitster.siamese.dyndns.org>
	<18306.41093.376963.228802@cargo.ozlabs.ibm.com>
	<200801072305.59425.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Mon Jan 07 23:15:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JC0FI-0006ia-F3
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 23:15:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752993AbYAGWOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 17:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753058AbYAGWOd
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 17:14:33 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59859 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752925AbYAGWOc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 17:14:32 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E04AA86B;
	Mon,  7 Jan 2008 17:14:31 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F49FA86A;
	Mon,  7 Jan 2008 17:14:24 -0500 (EST)
In-Reply-To: <200801072305.59425.stimming@tuhh.de> (Christian Stimming's
	message of "Mon, 7 Jan 2008 23:05:58 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69821>

Christian Stimming <stimming@tuhh.de> writes:

> Am Montag, 7. Januar 2008 22:58 schrieb Paul Mackerras:
>> I'd like you to do a pull from the gitk.git master branch, but it
>> looks to me like there will be a conflict on the Makefile.
>> Unfortunately the Makefile that Christian Stimming gave me along with
>> the i18n changes is quite different from the one you currently have in
>> the gitk-git subdirectory.  I'm not quite sure what to suggest since
>> it isn't clear to me exactly what Christian's Makefile (which doesn't
>> actually work) is trying to do.  
>
> The Makefile from me was merely a placeholder where the i18n programs should 
> work, but it was clear that the installation rules need to be defined 
> differently anyway.
>
>> I guess the best thing would be to 
>> copy your Makefile over and then add the i18n stuff.
>
> Yes. I've just sent you a patch that does exactly this - that was what I 
> thought, too.

Thanks both of you.

>> Apart from the i18n changes, there is one more commit (b039f0a6) that
>> improves the appearance slightly when running under Tk8.5.
>
> Are you going to release a i18n-enabled gitk sometime soon? If yes, you should 
> consider notifying the translator(s) a few days in advance so that they can 
> finalize their translations, in case they want to avoid a half-translated 
> program to be shipped. Thanks a lot.

If I understand correctly, what Paul told me to pull contains
the i18n stuff, so assuming your adjustment to gitk Makefile
makes things cleanly merge and build inside git.git repository,
upcoming 1.5.4-rc3 will ship with the infrastructure and
existing translations, and updates to po/ files can be made
between -rc3 and the final (I do not mean there won't be -rc4.
That is also "between -rc3 and final").
