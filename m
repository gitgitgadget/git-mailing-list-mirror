From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Repo cleanup problem
Date: Fri, 11 May 2007 10:19:06 +0200
Message-ID: <20070511081906.GA21093@diana.vm.bytemark.co.uk>
References: <9909dee80705110103h5b848490m296c001beecfa1f1@mail.gmail.com> <vpqveezhjb0.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 11 10:19:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmQLN-0001ye-Qk
	for gcvg-git@gmane.org; Fri, 11 May 2007 10:19:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbXEKITK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 11 May 2007 04:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751555AbXEKITK
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 04:19:10 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2549 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090AbXEKITJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 04:19:09 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HmQLD-0005X4-00
	for <git@vger.kernel.org>; Fri, 11 May 2007 09:19:07 +0100
Content-Disposition: inline
In-Reply-To: <vpqveezhjb0.fsf@bauges.imag.fr>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46944>

On 2007-05-11 10:10:43 +0200, Matthieu Moy wrote:

> Then, to have git-gc remove the old, bad, history, you need to remove
> any reference you have to it: branches and tags. git-branch -d and
> perhaps git-tag -d will tell you.

The reflog is on by default nowadays, which essentially means that
dangling commits won't be pruned for 30 days or something -- unless
you delete the references in the reflog as well. "git reflog expire"
can probably help here.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
