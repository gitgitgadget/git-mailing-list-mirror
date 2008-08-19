From: Mike Hommey <mh@glandium.org>
Subject: Re: Call Me Gitless
Date: Tue, 19 Aug 2008 11:36:46 +0200
Organization: glandium.org
Message-ID: <20080819093646.GA17123@glandium.org>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com> <alpine.LNX.1.00.0808181512160.19665@iabervon.org> <7vfxp2m5w8.fsf@gitster.siamese.dyndns.org> <905315640808181624w58918a0ao939a3f0462f9dc9e@mail.gmail.com> <48AA7BE9.4040108@sneakemail.com> <7vk5edfn6g.fsf@gitster.siamese.dyndns.org> <ee521d6f0808190157s6a676a75t2ba3ef095f608431@mail.gmail.com> <vpqk5edid2y.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander E Genaud <alex@genaud.net>,
	Junio C Hamano <gitster@pobox.com>,
	Peter Valdemar =?iso-8859-15?Q?M=F8rch?= 
	<4ux6as402@sneakemail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Aug 19 11:38:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVNfg-0006hy-KR
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 11:38:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752810AbYHSJhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 05:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752819AbYHSJhc
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 05:37:32 -0400
Received: from vuizook.err.no ([194.24.252.247]:57133 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751684AbYHSJhb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 05:37:31 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=vaio.glandium.org)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1KVNdw-00037x-S2; Tue, 19 Aug 2008 11:36:55 +0200
Received: from mh by vaio.glandium.org with local (Exim 4.63)
	(envelope-from <mh@glandium.org>)
	id 1KVNdu-0004Tm-32; Tue, 19 Aug 2008 11:36:46 +0200
Content-Disposition: inline
In-Reply-To: <vpqk5edid2y.fsf@bauges.imag.fr>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mh@glandium.org
X-SA-Exim-Scanned: No (on vaio.glandium.org); SAEximRunCond expanded to false
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92843>

On Tue, Aug 19, 2008 at 11:11:33AM +0200, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> "Alexander E Genaud" <alex@genaud.net> writes:
> 
> > There is no indication in the documentation distinguishing porcelain
> > from plumbing.
> 
> Well, there is somehow one: "git" and "git help" show just the
> porcelain. Still, I agree with you: marking plumbing as such more
> explicitely could help newbies not to bother with it. For example,
> "man git-update-index" could say right after the synopsys something
> like "This command is meant for scripting purpose. See git-add and
> git-rm for a user-friendly interface".
> 
> > Git-add adds to the index but does not create, however git-rm
> > removes from the index and does delete (an --index-only or --keep
> > flag might be nice).
> 
> git rm actually had a documented --cached flag now, and git rm
> gives an error message pointing to it in the case where it would lose
> data and --force is not provided.
> 
> > A single term for cache and index should be decided upon.
> 
> +1 on this.
> 
> I find "staging area" the most explicit wording for users, but I say
> that as a non-native english speaker.
> 
> Unfortunately, it's not only a matter of documentation. Renaming "git
> diff --cached" to "git diff --staged" would cause backward
> compatibility problems for example.

Not only that, but also, it would hide the fact that --cached and
--index have a different meaning.

See http://marc.info/?l=git&m=121201719116766&w=2

Mike
