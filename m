From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: git-{diff,ls}-files from a subdirectory fails ...
Date: Wed, 24 Oct 2007 12:40:55 +0200
Message-ID: <20071024104055.GB3908@diana.vm.bytemark.co.uk>
References: <20071024012038.GA31326@diana.vm.bytemark.co.uk> <Pine.LNX.4.64.0710241104560.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 24 12:41:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ikdfi-0006wK-Ji
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 12:41:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762AbXJXKk7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Oct 2007 06:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752545AbXJXKk7
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 06:40:59 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2326 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554AbXJXKk6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 06:40:58 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IkdfT-000185-00; Wed, 24 Oct 2007 11:40:55 +0100
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710241104560.25221@racer.site>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62206>

On 2007-10-24 11:06:43 +0100, Johannes Schindelin wrote:

> On Wed, 24 Oct 2007, Karl Hasselstr=F6m wrote:
>
> > However, it doen't seem to work from a subdirectory:
> >
> >   kha@yoghurt:~/stgit-lib/stgit> git-diff-files --name-only
> >   stgit/utillib.py
> >
> >   kha@yoghurt:~/stgit-lib/stgit> GIT_DIR=3D/home/kha/stgit-lib/.git=
 GIT_INDEX_FILE=3D/home/kha/stgit-lib/.git/index GIT_WORK_TREE=3D/home/=
kha/stgit-lib git-diff-files --name-only | wc
> >       170     170    3560
>
> From looking at it (very) briefly, it seems that you encountered the
> same bug that was fixed in
>
> dd5c8af176bb935a0b01a7dc2d5e022565c3aac3(Fix setup_git_directory_gent=
ly()
> with relative GIT_DIR & GIT_WORK_TREE).
>
> IOW if you run git version v1.5.3.4-14-gdd5c8af or newer, you should
> not experience this.

Thanks for the pointer; that looks like it might indeed fix this bug.
Will hopefully have time to verify later today.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
