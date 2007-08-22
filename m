From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH 0/6] Use git conflict handling on push
Date: Wed, 22 Aug 2007 11:17:57 +0200
Message-ID: <20070822091757.GA30748@diana.vm.bytemark.co.uk>
References: <11875975232619-git-send-email-davidk@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: catalin.marinas@gmail.com, git@vger.kernel.org
To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Wed Aug 22 11:18:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INmM1-0003Vc-N3
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 11:18:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756064AbXHVJSM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 22 Aug 2007 05:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762200AbXHVJSK
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 05:18:10 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3235 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764107AbXHVJSF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 05:18:05 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1INmLd-000850-00; Wed, 22 Aug 2007 10:17:57 +0100
Content-Disposition: inline
In-Reply-To: <11875975232619-git-send-email-davidk@lysator.liu.se>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56358>

On 2007-08-20 10:11:57 +0200, David K=E5gedal wrote:

> This series of patches updates "stg push" to leave conflicts in the
> index, in the normal git fashion.

Great initiative! This will make stg conceptually simpler to anyone
who already knows git (which ought to be a large fraction of the user
base), _and_ get rid of a lot of complicated code.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
