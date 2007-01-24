From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How to pull only a few files from one branch to another?
Date: Wed, 24 Jan 2007 21:46:49 +0100
Organization: At home
Message-ID: <ep8ght$dlf$3@sea.gmane.org>
References: <17846.53626.895660.762096@lisa.zopyra.com> <Pine.LNX.4.64.0701231937310.3606@woody.linux-foundation.org> <20070124203913.GD4083@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 24 21:50:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9p4L-0001HP-IL
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 21:50:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932639AbXAXUuG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 24 Jan 2007 15:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932662AbXAXUuG
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 15:50:06 -0500
Received: from main.gmane.org ([80.91.229.2]:35684 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932639AbXAXUuE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 15:50:04 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1H9p4E-0005et-JA
	for git@vger.kernel.org; Wed, 24 Jan 2007 21:50:02 +0100
Received: from host-81-190-20-200.torun.mm.pl ([81.190.20.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Jan 2007 21:50:02 +0100
Received: from jnareb by host-81-190-20-200.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Jan 2007 21:50:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-200.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37680>

Yann Dirson wrote:

> What was particular about this tree, is that we are several people
> working on it, namely developpers taking care of the app, and me as
> build manager taking care of the build mechanics as well as kernel+OS=
=2E
> So the task was logically divided: one dev would merge the app, and I
> would merge everything else. =A0As you see, it's far from one-file
> merges, but the problem is quite similar.

This I think would be best handled by (future/prototype) submodules
support.


I wonder if fake-recording resolutions in git-rerere would help
in that case...
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
