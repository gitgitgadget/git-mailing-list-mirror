From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 1/2] git-svn: don't append extra newlines at the end of commit messages.
Date: Fri, 13 Jun 2008 10:09:49 +0200
Message-ID: <20080613080949.GA26817@diana.vm.bytemark.co.uk>
References: <1213312251-8081-1-git-send-email-apenwarr@gmail.com> <48522055.6060006@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Jun 13 10:11:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K74NN-0004Ds-15
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 10:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754112AbYFMIKS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2008 04:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753740AbYFMIKS
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 04:10:18 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4024 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753547AbYFMIKQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 04:10:16 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K74M1-00070N-00; Fri, 13 Jun 2008 09:09:49 +0100
Content-Disposition: inline
In-Reply-To: <48522055.6060006@op5.se>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84846>

On 2008-06-13 09:23:01 +0200, Andreas Ericsson wrote:

> Are you proposing to remove extra whitespace from git commits when
> they are sent back to svn via dcommit? If so, wouldn't it be better
> to always strip extra newlines when importing from svn so they're
> never there in the first place?

That's what the patch does, unless I'm misreading it.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
