From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: how to list all files that will be comitted
Date: Wed, 25 Jun 2008 18:14:39 +0200
Message-ID: <20080625161439.GA1794@diana.vm.bytemark.co.uk>
References: <644094BE-2835-41EF-B1B4-615B8A4BD509@gmail.com> <alpine.LFD.1.10.0806251154180.5755@sys-0.hiltweb.site> <17C0F998-66C0-4DFC-90EB-B85FF6E07844@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ian Hilt <Ian.Hilt@gmx.com>, git@vger.kernel.org
To: "Rhodes, Kate" <masukomi@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 18:16:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBXf3-00043U-2h
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 18:15:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756396AbYFYQOz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Jun 2008 12:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756276AbYFYQOz
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 12:14:55 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4566 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755421AbYFYQOy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 12:14:54 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KBXdo-0000WW-00; Wed, 25 Jun 2008 17:14:40 +0100
Content-Disposition: inline
In-Reply-To: <17C0F998-66C0-4DFC-90EB-B85FF6E07844@gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86297>

On 2008-06-25 12:01:49 -0400, Rhodes, Kate wrote:

> yeah, but i was hoping for plumbing, not porcelain, that showed just
> what i wanted so that i didn't have to parse status' output.

Unless you want a listing of all the files in the index, you probably
want to call diff-index.

  git diff-index --cached <tree-ish>

gives you the diff between the index and a tree-ish. With the
--name-only option, you get only the filenames and not all the modes,
blob sha1s, etc.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
