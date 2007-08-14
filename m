From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: call external editor from git-gui?
Date: Tue, 14 Aug 2007 09:00:00 +0200
Message-ID: <20070814070000.GA12052@diana.vm.bytemark.co.uk>
References: <20070810153008.GA31759@diana.vm.bytemark.co.uk> <20070814045511.GF27913@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 14 09:00:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKqO1-0002hV-3X
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 09:00:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbXHNHAH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 14 Aug 2007 03:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbXHNHAG
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 03:00:06 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1042 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbXHNHAE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 03:00:04 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IKqNk-0003As-00; Tue, 14 Aug 2007 08:00:00 +0100
Content-Disposition: inline
In-Reply-To: <20070814045511.GF27913@spearce.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55813>

On 2007-08-14 00:55:11 -0400, Shawn O. Pearce wrote:

> Karl Hasselstrm <kha@treskal.com> wrote:
>
> > git-gui is very good at composing commits. But for writing the
> > actual commit message -- especially if it's long and needs
> > paragraph reflowing, indentation, and so on -- I vastly prefer
> > emacs over git-gui's text field.
>
> Yea, I've been thinking about adding fancy features like those. But
> been lazy.

Yeah, every time I read the git list, I think to myself, "Wow, Shawn
sure is lazy!" :-)

You do a lot of seriously useful work on git.

> Spawning the user's preferred editor would be a nice way to get some
> of that.

Mmm. I wouldn't call it a _nice_ way: popping up an external program
just to get the right text editing behavior. More like the _only_ way,
if the user is picky enough.

> An annoying work-around would be to run your editor to create/edit
> .git/GITGUI_MSG (or .git/MERGE_MSG) then hit Rescan in git-gui. It
> loads that file into its editor buffer if the editor buffer is empty
> or has not been modified from within git-gui since the last time the
> file was read.

I just tend to git-commit --amend to accomplish that.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
