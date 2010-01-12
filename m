From: Adam Megacz <adam@megacz.com>
Subject: Re: [PATCH] Display author and committer after "git commit"
Date: Tue, 12 Jan 2010 01:51:51 +0000
Organization: Myself
Message-ID: <xuu2zl4kks3s.fsf@nowhere.com>
References: <xuu2fx6m4vdi.fsf@nowhere.com> <fabb9a1e1001041232h4e5827d1pb5c648b33ecfb5ce@mail.gmail.com> <xuu2zl4tfuij.fsf@nowhere.com> <20100106073806.6117@nanako3.lavabit.com> <7v4omz17xz.fsf@alter.siamese.dyndns.org> <xuu28wc9xd42.fsf@nowhere.com> <7vskagh9fg.fsf@alter.siamese.dyndns.org> <xuu2fx6d9rzb.fsf_-_@nowhere.com> <7vzl4lw160.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 12 02:52:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUVvi-0002el-VN
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 02:52:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752520Ab0ALBwS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 20:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751635Ab0ALBwS
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 20:52:18 -0500
Received: from lo.gmane.org ([80.91.229.12]:46334 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750934Ab0ALBwS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 20:52:18 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NUVvb-0002ce-Md
	for git@vger.kernel.org; Tue, 12 Jan 2010 02:52:15 +0100
Received: from gentzen.megacz.com ([65.23.129.159])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 Jan 2010 02:52:15 +0100
Received: from adam by gentzen.megacz.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 Jan 2010 02:52:15 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: gentzen.megacz.com
X-Home-Page: http://www.megacz.com/
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Cancel-Lock: sha1:doT9XVBjqpWo2OuduuggiPqHNYU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136682>


Junio C Hamano <gitster@pobox.com> writes:
> Why isn't the "# Author:" and "# Committer:" information you see along
> with "git status" output in the editor "git commit" gives you sufficient
> if it is to avoid unconfigured/misconfigured names and e-mail
> addresses?

It is sufficient!  But, as others have mentioned, it is not displayed
when "git commit -m" is used.  The patch in this thread rectifies that
omission.

> Too much clutter for too little gain, except for a very first few commits
> in the repository.

Funny, I think of those "+++" "-----" histogram things as clutter.  I
guess it's subjective.

  - a
