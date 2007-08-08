From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: 'pu' branch for StGIT
Date: Wed, 8 Aug 2007 11:20:27 +0200
Message-ID: <20070808092027.GB7860@diana.vm.bytemark.co.uk>
References: <20070807022043.GA8482@diana.vm.bytemark.co.uk> <1186549433.2112.34.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>,
	Yann Dirson <ydirson@altern.org>
To: Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Wed Aug 08 11:20:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIhih-0005K4-61
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 11:20:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754799AbXHHJUo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 8 Aug 2007 05:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755705AbXHHJUo
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 05:20:44 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4506 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753737AbXHHJUn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 05:20:43 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IIhiN-0002G2-00; Wed, 08 Aug 2007 10:20:27 +0100
Content-Disposition: inline
In-Reply-To: <1186549433.2112.34.camel@dv>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55312>

On 2007-08-08 01:03:53 -0400, Pavel Roskin wrote:

> On Tue, 2007-08-07 at 04:20 +0200, Karl Hasselstr=F6m wrote:
>
> > So I finally got my act together and published a 'pu'-like branch
> > for StGIT. Get it at git://repo.or.cz/stgit/kha.git; gitweb at
> > http://repo.or.cz/w/stgit/kha.git.
>
> Just a word of warning. This version converts all branches to
> version 3, so that the standard StGIT won't work with them anymore.

I believe I said (or tried to say) as much towards the end of my mail.
Thanks for trying it out though! It seems my evil master plan is
working. :-)

> Also, "stg import" commits the patch, which seems wrong to me.

Hmm, I hadn't noticed. That would be an unintended side-effect of the
DAG patches, presumably. I'll look into it tonight.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
