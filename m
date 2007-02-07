From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: git-fast-import
Date: Wed, 7 Feb 2007 10:13:51 +0100
Message-ID: <20070207091351.GA1632@diana.vm.bytemark.co.uk>
References: <20070206023111.GB9222@spearce.org> <45C81C33.6010704@gmail.com> <20070206061817.GB10508@spearce.org> <Pine.LNX.4.64.0702062347060.20138@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@gmail.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Feb 07 10:14:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEisW-0002j9-7f
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 10:14:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030227AbXBGJOH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 7 Feb 2007 04:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030603AbXBGJOH
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 04:14:07 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3012 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030600AbXBGJOG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 04:14:06 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HEisB-0000gr-00; Wed, 07 Feb 2007 09:13:51 +0000
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702062347060.20138@iabervon.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38897>

On 2007-02-06 23:55:46 -0500, Daniel Barkalow wrote:

> It might be nice to have a git-fast-export, which could actually be
> potentially useful for generating a repository with systematic
> differences from the original. (E.g., to make a repository of git's
> Documentation directory, with just the commits that affect it)

Or to solve problems like

  Gaaah! This file we've had in the repository for the last 17 months
  has copyright problems and we can't distribute it!

or

  Wouldn't it be nice to permanently include all that old Linux
  history that's currently grafted onto the "real" history?

In other words, general history rewriting, but fast.

(Disclaimer: I've never tried to use the history rewrite tool that
Cogito has, so I don't know its limitations, or how fast it is.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
