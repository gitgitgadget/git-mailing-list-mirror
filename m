From: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
Subject: Re: tig show <commit> not working anymore?
Date: Thu, 16 Sep 2010 14:01:32 -0500
Message-ID: <20100916190132.GK5785@bowser.ece.utexas.edu>
References: <20100916125337.GG5785@bowser.ece.utexas.edu>
 <4C921FAC.9000108@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Naewe <stefan.naewe@atlas-elektronik.com>
X-From: git-owner@vger.kernel.org Thu Sep 16 21:01:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwJiH-0008KA-5s
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 21:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755951Ab0IPTBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Sep 2010 15:01:35 -0400
Received: from ironclad.mail.utexas.edu ([146.6.25.7]:49238 "EHLO
	ironclad.mail.utexas.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755404Ab0IPTBe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Sep 2010 15:01:34 -0400
X-IronPort-MID: 55079625
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAEoGkkyAU36U/2dsb2JhbACiDHHFYYVBBIRLNoUu
Received: from wb8-a.mail.utexas.edu ([128.83.126.148])
  by ironclad.mail.utexas.edu with ESMTP; 16 Sep 2010 14:01:34 -0500
Received: (qmail 51557 invoked from network); 16 Sep 2010 19:01:34 -0000
Received: from bowser.ece.utexas.edu (a.kumar@146.6.33.245)
  by wb8.mail.utexas.edu with (RC4-SHA encrypted) ESMTPSSA; 16 Sep 2010 19:01:34 -0000
Content-Disposition: inline
In-Reply-To: <4C921FAC.9000108@atlas-elektronik.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156345>

Dear Stefan,

On Thu, Sep 16, 2010 at 03:46:20PM +0200, Stefan Naewe wrote:
> On 9/16/2010 2:53 PM, Kumar Appaiah wrote:
> > I observed that, since commit
> > 53c089443cd9885fa677becee4bf7ffd56c3c357, tig show <commit> doesn't
> > seem to work the same way as I had expected it to. The documentation
> > update doesn't seem to indicate that this was to be expected (or I
> > didn't understand it properly). Could someone please confirm that
> > tig show <commit> should actually do something similar to git show <commit> | tig ?
> > 
> > Thanks!
> 
> Works as expected for me on Debian Linux 5.0.6 i686:
> 
> $ git version
> git version 1.7.2.3
> 
> $ git describe
> tig-0.16-11-gf1fe753
> 
> and on Cygwin with the same tig version and "git version 1.7.2.3.msysgit.1"
> 
> Your tig version, OS, etc. ?

Here are the details:

TIG_VERSION="0.16-11-gf1fe753"

[kumar@redsun ~/Software/tig/tig] git --version
git version 1.7.1

./tig show HEAD
./tig show HEAD^ # Both show me f1fe753be71ef3ce5abcbb16c2a359f97e5c7e7d

Now, if I check out 53c089443cd9885fa677becee4bf7ffd56c3c357^, then I
get back the expected behaviour.

Please let me know if I've made some mistake.

Thanks!

Kumar
