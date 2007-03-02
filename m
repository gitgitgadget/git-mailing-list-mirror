From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Git checkout preserve timestamp?
Date: Fri, 2 Mar 2007 10:14:26 +0100
Message-ID: <20070302091426.GA2605@diana.vm.bytemark.co.uk>
References: <17895.18265.710811.536526@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 10:15:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN3r1-0000an-21
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 10:15:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422741AbXCBJOa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 2 Mar 2007 04:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422748AbXCBJOa
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 04:14:30 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4011 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422741AbXCBJO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 04:14:29 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HN3qM-0000jz-00; Fri, 02 Mar 2007 09:14:26 +0000
Content-Disposition: inline
In-Reply-To: <17895.18265.710811.536526@lisa.zopyra.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41172>

On 2007-03-01 15:36:25 -0600, Bill Lear wrote:

> I often find myself in branch A, with everything checked in and
> compiled, wanting to look at something on branch B. I hop to branch
> B, look, and come back to branch A. Unfortunately, when I then do a
> make, files that differed between A and B will be recompiled, as
> well as any further dependencies.

Like others have already recommended, I usually just use separate
repositories to work around this problem. Of course, the proper fix is
to use a make-like tool that uses content hashes as well as timestamps
to decide if a file has been updated ...

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
