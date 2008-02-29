From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: stgit - continue rebase after merge conflict?
Date: Fri, 29 Feb 2008 08:58:21 +0100
Message-ID: <20080229075821.GA14773@diana.vm.bytemark.co.uk>
References: <20080226145725.GA24987@ldl.fc.hp.com> <b0943d9e0802260856j6e9b0053ne4916149d8e4387c@mail.gmail.com> <20080228173830.GA16045@ldl.fc.hp.com> <b0943d9e0802281350r3945d3f0qd0dd8ee61679e82d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex Chiang <achiang@hp.com>, git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 29 09:38:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JV0lZ-0002E3-31
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 09:38:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753077AbYB2IiI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Feb 2008 03:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753831AbYB2IiG
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 03:38:06 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1168 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753077AbYB2IiE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 03:38:04 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JV08L-0003uU-00; Fri, 29 Feb 2008 07:58:21 +0000
Content-Disposition: inline
In-Reply-To: <b0943d9e0802281350r3945d3f0qd0dd8ee61679e82d@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75514>

On 2008-02-28 21:50:04 +0000, Catalin Marinas wrote:

> It says that it's a merge conflict but isn't more precise than that.
> You can run 'stg status' to check the conflicts.
>
> The reason is that you are probably using the development branch of
> StGIT and we (actually Karl) are refactoring the GIT objects
> handling. The 'goto' command (but not 'push') was moved to the new
> infrastructure but missed some of the UI stuff. They'll be added
> back.

Yeah, I'd forgotten all about that. I rarely get conflicts when
running "stg goto".

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
