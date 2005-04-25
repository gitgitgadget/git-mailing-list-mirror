From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: Git-commits mailing list feed.
Date: Sun, 24 Apr 2005 22:43:40 -0400
Message-ID: <20050425024340.GI29939@delft.aura.cs.cmu.edu>
References: <426A5BFC.1020507@ppp0.net> <1114266907.3419.43.camel@localhost.localdomain> <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org> <20050423175422.GA7100@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0504231125330.2344@ppc970.osdl.org> <2911.10.10.10.24.1114279589.squirrel@linux1> <Pine.LNX.4.58.0504231234550.2344@ppc970.osdl.org> <Pine.LNX.4.62.0504250008370.14200@sheen.jakma.org> <426C4168.6030008@dwheeler.com> <20050425023420.GA14696@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Apr 25 04:39:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPtVG-0001XY-7p
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 04:39:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262480AbVDYCoB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 22:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262471AbVDYCoB
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 22:44:01 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:10961 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S262480AbVDYCnr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2005 22:43:47 -0400
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 3.36 #1 (Debian))
	id 1DPtZU-0002h7-00; Sun, 24 Apr 2005 22:43:40 -0400
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050425023420.GA14696@lists.us.dell.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 24, 2005 at 09:34:20PM -0500, Matt Domsch wrote:
> On Sun, Apr 24, 2005 at 09:01:28PM -0400, David A. Wheeler wrote:
> > It may be better to have them as simple detached signatures, which are
> > completely separate files (see gpg --detached).
> > Yeah, gpg currently implements detached signatures
> > by repeating what gets signed, which is unfortunate,
> > but the _idea_ is the right one.
> 
> I solve this with two simple scripts, "sign" calls "cutsig".
...
> gpg --armor --clearsign --detach-sign --default-key "${DEFAULT_KEY} -v -v -o - ${1} | \
> ${CUTSIG} > ${1}.sign

You could also just leave out the --clearsign option and it will DTRT.

Jan
