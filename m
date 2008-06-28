From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [q] git-diff --reverse 7def2be1..7def2be1^
Date: Sat, 28 Jun 2008 15:08:30 -0700
Message-ID: <7vk5g9kyap.fsf@gitster.siamese.dyndns.org>
References: <20080620082034.GA24913@elte.hu> <vpqiqw42vk6.fsf@bauges.imag.fr>
 <20080620135004.GB8135@elte.hu> <m34p7ombie.fsf@localhost.localdomain>
 <20080626093726.GA24577@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ingo Molnar <mingo@elte.hu>, Jakub Narebski <jnareb@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jun 29 00:09:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCic2-0003tF-1k
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 00:09:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753184AbYF1WIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 18:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753210AbYF1WIl
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 18:08:41 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44024 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752980AbYF1WIk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 18:08:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0323413978;
	Sat, 28 Jun 2008 18:08:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4980713977; Sat, 28 Jun 2008 18:08:33 -0400 (EDT)
In-Reply-To: <20080626093726.GA24577@elte.hu> (Ingo Molnar's message of "Thu,
 26 Jun 2008 11:37:26 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C2E48122-455E-11DD-9BDA-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86746>

Ingo Molnar <mingo@elte.hu> writes:

> * Jakub Narebski <jnareb@gmail.com> wrote:
> ...
>> contrib/completion/git-completion.bash in git repository.  
>
> btw., i had to turn this off - it made certain types of file completions 
> almost unusable, by adding a 2-3 seconds delay (during which bash would 
> just spin around burning CPU time calculating its completion guesses).
>
> and that was on a 3 GHz dual-core box ...
>
> so please do not remove the git-* commands, they are really useful.

The slowness of the completion script (especially the time it takes before
it decides to complete pathnames) has been bothering me for some time, so
I share Ingo's frustration, but it hasn't got to the point to disable it.

After typing:

	$ git checkout master -- Docu

and then hitting the "Tab" key to complete before I see "mentation/", it
takes about 2-3 seconds for the first time, and after that it becomes
torelable.  Is it the command table bootstrapping that is taking this
long?

<offtopic> I'll be mostly offline for the rest of the day, so you do not
have to respond in a hurry. </offtopic>
