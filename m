From: greened@obbligato.org
Subject: Re: [PATCH 13/13] contrib/subtree: Remove --annotate
Date: Mon, 18 Feb 2013 12:39:56 -0600
Message-ID: <87sj4t4gar.fsf@waller.obbligato.org>
References: <1360037173-23291-1-git-send-email-greened@obbligato.org>
	<1360037173-23291-14-git-send-email-greened@obbligato.org>
	<7vobfzwd8g.fsf@alter.siamese.dyndns.org>
	<87pq0frnmb.fsf@waller.obbligato.org>
	<CABVa4NiyVksEn4+NqBPXpaWGYnP6FeUqeacLOnAOHtw9FgMJdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: James Nylen <jnylen@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 19:41:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7VeQ-0002V8-8W
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 19:41:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753828Ab3BRSkr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 13:40:47 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:45134 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753710Ab3BRSkp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 13:40:45 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1U7Vfl-00087s-Th; Mon, 18 Feb 2013 12:42:42 -0600
In-Reply-To: <CABVa4NiyVksEn4+NqBPXpaWGYnP6FeUqeacLOnAOHtw9FgMJdA@mail.gmail.com>
	(James Nylen's message of "Tue, 5 Feb 2013 08:27:34 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  James Nylen <jnylen@gmail.com> writes: > I don't agree that
    removing `--annotate` obviates the need for `--unannotate`. > > I responded
    on 1/17 with what I think is a typical and normal use case > for that option:
    [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216493>

James Nylen <jnylen@gmail.com> writes:

> I don't agree that removing `--annotate` obviates the need for `--unannotate`.
>
> I responded on 1/17 with what I think is a typical and normal use case
> for that option:

Sorry, I must have missed that reply.

>  - add "fancylib" as a subtree of "myprog"
>  - commit to "myprog" repo: "fancylib: don't crash as much"
>  - split these commits back out to "fancylib" main repo, and remove
> the "fancylib: " prefix

I can see how that would be useful.

> `--unannotate` is a clunky name, but I think this functionality is
> worth taking another look at.  Maybe it could be called
> `--remove-prefix` ?

Should this really be a function of git-subtree?  It seems like it would
fit better in a history-rewriting command.  Wouldn't rebase -i or even
filter-branch be a better way to do this?

If there's no --annotate I don't see why git-subtree should have the
--unannotate functionality.

Again, I agree that your example is relevant, maybe even common, but I
don't necessarily think git-subtree should be in the business of
rewriting commit messages at all.

I'd appreciate more thoughts from you on this.  I want to make sure we
can support your use case.

                         -David
