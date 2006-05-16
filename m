From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Handle branch names with slashes
Date: Mon, 15 May 2006 23:48:04 -0700
Message-ID: <7v64k6ea8r.fsf@assigned-by-dhcp.cox.net>
References: <20060515105810.GA27077@diana.vm.bytemark.co.uk>
	<20060516063541.GA11218@backpacker.hemma.treskal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 16 08:48:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FftLv-0000Ua-JF
	for gcvg-git@gmane.org; Tue, 16 May 2006 08:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751544AbWEPGsI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 16 May 2006 02:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751554AbWEPGsH
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 02:48:07 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:59628 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751552AbWEPGsG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 May 2006 02:48:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060516064805.IADT27327.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 16 May 2006 02:48:05 -0400
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
In-Reply-To: <20060516063541.GA11218@backpacker.hemma.treskal.com> (Karl
	=?iso-8859-1?Q?Hasselstr=F6m's?= message of "Tue, 16 May 2006 08:35:41
 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20106>

Karl Hasselstr=F6m <kha@treskal.com> writes:

> Teach stgit to handle branch names with slashes in them; that is,
> branches living in a subdirectory of .git/refs/heads.
>
> I had to change the patch@branch/top command-line syntax to
> patch@branch%top, in order to get sane parsing. The /top variant is
> still available for repositories that have no slashy branches; it is
> disabled as soon as there exists at least one subdirectory of
> refs/heads. Preferably, this compatibility hack can be killed some
> time in the future.

I wonder if using double-slashes is an easier alternative to
type than '%', like "patch@branch//top".  That way, you do not
have to forbid per-cent sign in branch names.
