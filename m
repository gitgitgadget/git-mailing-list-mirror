From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Call Me Gitless
Date: Mon, 18 Aug 2008 15:30:27 -0700
Message-ID: <7vtzdiklbw.fsf@gitster.siamese.dyndns.org>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com>
 <alpine.LNX.1.00.0808181512160.19665@iabervon.org>
 <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0808181628420.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Aug 19 00:31:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVDGH-0001uh-6q
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 00:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753518AbYHRWag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 18:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753450AbYHRWag
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 18:30:36 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48955 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753205AbYHRWaf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 18:30:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3B50652B08;
	Mon, 18 Aug 2008 18:30:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6383C52B04; Mon, 18 Aug 2008 18:30:29 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0808181628420.19665@iabervon.org> (Daniel
 Barkalow's message of "Mon, 18 Aug 2008 17:31:21 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 44ADFD6C-6D75-11DD-8DD9-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92746>

Daniel Barkalow <barkalow@iabervon.org> writes:

> if you'd get:
>
> --- (index)/foo/bar
> +++ ./foo/bar
>
> people would at least be clear on what information they were getting, even 
> if they didn't know why they were getting that as opposed to a different 
> combination.

[Removed somebody who decided not use git from CC.]

I know you mentioned this as an example of differenciating the output
between the modes, and not as a serious suggestion.  The above may apply
cleanly because "(index)" and "." are both one level deep, but they look
ugly and the filenames do not align.

It does look an interesting approach, though.

I often make a quick patch all inside the work tree, never committing, and
then send it out by including "git diff --stat -p" output in the mail as a
suggested patch.  If we did what you suggest, people could tell such a
patch and a format-patch output.  I actually do like the fact that we
consistently say "a/" vs "b/", but some people actually may prefer to see
the difference.
