From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3] gitk: add --no-replace-objects option
Date: Fri, 20 Nov 2009 21:42:39 +0100
Message-ID: <200911202142.39520.chriscool@tuxfamily.org>
References: <20091120194046.4469.53971.chriscool@tuxfamily.org> <7vocmxvu7c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	bill lam <cbill.lam@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Paul Mackerras <paulus@samba.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 21:40:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBaHT-0005dj-Vj
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 21:40:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754843AbZKTUkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 15:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754714AbZKTUkV
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 15:40:21 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:41031 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754551AbZKTUkU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 15:40:20 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 25C09818062;
	Fri, 20 Nov 2009 21:40:17 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 1AE2981817D;
	Fri, 20 Nov 2009 21:40:14 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <7vocmxvu7c.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133375>

On vendredi 20 novembre 2009, Junio C Hamano wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
> > This option simply sets the GIT_NO_REPLACE_OBJECTS environment
> > variable, and that is enough to make gitk ignore replace refs.
>
> This is a much less interesting implementation detail than everything
> else you should talk about the new feature you are adding; why is it the
> first sentence of the message?

This patch was previously the second patch in a 2 patch series so the 
previous patch was already explaining some context. Perhaps I should have 
sent the first patch again with this one.

> > The GIT_NO_REPLACE_OBJECTS is set to "1" instead of "" as it is
> > safer on some platforms, thanks to Johannes Sixt and Michael J
> > Gruber.
>
> And this is even less interesting.
>
> > Replace refs are useful to change some git objects after they
> > have started to be shared between different repositories. One
> > might want to ignore them to see the original state.
>
> This is what the reader needs to see to understand why this patch is
> worthy of consideration.  It is a minor offense that the paragraph does
> not end with "... original state, and --no-replace-objects option can be
> used from the command line to do so", but this could be excused if this
> is made the first paragraph in the message, close to the subject.

Ok, I will send the full series again with these changes.

> I wonder if this switch deserves run-time flippability, though...

The following patch in master added run-time flippability to many commands:

http://git.kernel.org/?p=git/git.git;a=commit;h=b0fa7ab51b29d34579d8f6bb4443dfbcb8278c7a

and Michael J Gruber wrote "we need a way to specify
--no-replace-objects for gitk" in this message:

http://article.gmane.org/gmane.comp.version-control.git/132576/

Best regards,
Christian.
