From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] Add function to checkout a branch in git.el
Date: Wed, 13 Feb 2008 17:30:02 +0100
Message-ID: <20080213163002.GA5670@diana.vm.bytemark.co.uk>
References: <87wsp8u9m7.dlv@maison.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Alexandre Julliard <julliard@winehq.org>
To: =?us-ascii?B?PT91dGYtOD9xP1I9QzM9QTltaT0yMFZhbmljYXQ/PQ==?= 
	<vanicat@debian.org>
X-From: git-owner@vger.kernel.org Wed Feb 13 17:31:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPKWC-0004js-Vd
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 17:31:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761358AbYBMQak convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Feb 2008 11:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760527AbYBMQak
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 11:30:40 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2997 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759997AbYBMQaj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 11:30:39 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JPKUk-0001VI-00; Wed, 13 Feb 2008 16:30:02 +0000
Content-Disposition: inline
In-Reply-To: <87wsp8u9m7.dlv@maison.homelinux.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73801>

On 2008-02-13 16:53:12 +0100, =3D?utf-8?q?R=3DC3=3DA9mi=3D20Vanicat?=3D=
 wrote:

> - checkout an existing branch with M-x git-change-branch
> - create and checkout a new branch with C-u M-x git-change-branch

Why the prefix? Wouldn't it be easier to just have one "switch branch"
prompt that would tab complete existing branch names, and

  * if the user enters the name of an existing branch, just switch to
    it;

  * if the user enters a name that's not the name of an existing
    branch, ask for confirmation, and then create the new branch and
    switch to it.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
