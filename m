From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] [BUG FIXED 2] git-add (-a|-u)  and -n support
Date: Mon, 15 Oct 2007 16:31:37 +0200
Message-ID: <20071015143137.GA7351@diana.vm.bytemark.co.uk>
References: <E1DCA1D1-1ED3-498A-A919-9EBAF3BA0870@mit.edu> <0458D1DA-6261-4DA6-91B0-739F4D35AADF@mit.edu> <E857D120-787F-460B-A167-4B5F4BD2C3B5@mit.edu> <vpq3awd25hs.fsf@bauges.imag.fr> <D44B7811-5A0F-4A31-9DB3-6D2BF645E543@MIT.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Mon Oct 15 16:52:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhQzd-00044a-1U
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 16:32:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756031AbXJOOcQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2007 10:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755907AbXJOOcQ
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 10:32:16 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3994 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755861AbXJOOcP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 10:32:15 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IhQyn-0002F4-00; Mon, 15 Oct 2007 15:31:37 +0100
Content-Disposition: inline
In-Reply-To: <D44B7811-5A0F-4A31-9DB3-6D2BF645E543@MIT.EDU>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61003>

On 2007-10-14 18:00:44 -0400, Michael Witten wrote:

> Here's compromise that is backwards compatible. For both git-add and
> git-commit:
>
>       -a dir [dir2 ...] =3D> all changes in the given dirs.
>       -a                =3D> all changes from the root.
>
> Then we can just leave -u in place for now, and mark it as
> deprecated.
>
> In any case, the goal is to make the intuition solid between
> git-commit and git-add.

As I recall, Junio had some specific reason for calling the flag -u
instead of -a. Search in the list archive for the patch that
introduced the flag, or wait till he gets back and ask him.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
