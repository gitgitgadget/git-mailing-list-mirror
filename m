From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC/GSoC 01/17] perf: introduce performance tests for
 git-rebase
Date: Mon, 21 Mar 2016 08:54:35 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603210853570.4690@virtualbox>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com> <1457779597-6918-2-git-send-email-pyokagan@gmail.com> <alpine.DEB.2.20.1603160855390.4690@virtualbox> <CACRoPnS=qg=a3xYKHyk-7E2HN5HhTimGirZcwL8hMa0xLY6KdA@mail.gmail.com>
 <alpine.DEB.2.20.1603161656130.4690@virtualbox> <20160318110134.GA16750@hank> <alpine.DEB.2.20.1603181659200.4690@virtualbox> <20160320140000.GB32027@hank>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Paul Tan <pyokagan@gmail.com>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Sam Halliday <sam.halliday@gmail.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 08:54:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahufu-0001D5-0a
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 08:54:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752221AbcCUHyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 03:54:51 -0400
Received: from mout.gmx.net ([212.227.15.18]:61493 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751730AbcCUHyt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 03:54:49 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MfVU3-1aRln5335n-00P7Dj; Mon, 21 Mar 2016 08:54:36
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160320140000.GB32027@hank>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:5UOwCVGu3w4cX2NN+ZGLYO4Z9xuc3RUzzTI3qPoMdDXtnj05+aB
 zGYjJ2PaaAZ0bKMZdVdn8WpKc0KIyumb88YYLoKQYnBGCMOl0TZpJ7MtUxhtDL3CG5NyQrA
 Vb0UXxz74S+ECbmAwGZX5+BMpmKijTpQiUicY8Wpmtkfn133ueAe4Oy99Jvy9q/CfNGLa5F
 JbrYrE39DKfQVRjQLPLNA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YRJG/rwamvs=:IUu0rYsAHE1Q0zqumqexeT
 LAlEnmPnFTfyDVSMBDlSIdFVmE3bCe+Ltixxe0kfqksY46MlMHV+ZH1Q3bOfY0B2u/rfbD4gE
 6LLympb1qk/PDmiBwp4lEeWk2ZsB9L2/IcnBf2v5+aRdjL9p5ZXDoXvnTeA90RVwlik5je8t+
 4e4Cf8knFjSew8Be8PW13iyCFSxmKK3XYGqkRM8QCkoYtppvADlI0KFAg3Fvy1aVlbS2owI4W
 YoKbnbwPw+Mgo3TLKOpUZ2QL/DvyQV4s5iuZXhbtMIRF46m7NwLEQXtVC2+RvTuvGMydD2xRg
 849bCb42DTi0gYALs7ij9YHAoAaJOrUesgfktuWd/gzKKbG1G1hxlDQnSXRkLGlR8p6PXRM7y
 owzDVyoObFeSxjolFQ28TFRvul4mFuJ1Nez0oQl2NCqQJpf4h27C3oleNcH2VAfXM/x51wJPN
 UrRVegSvU/5T5kW0q44hrt87zE3MsaltNZGyqztqwYOs7o7aT67KQUfd2K7eNxAnWuC3tBpcI
 Qh2pJBpIBHEKl33PtUVVZCWOiKWqQMqBniaxctAUexvYABLkfP6lbWqGZ0SUtCJYIeNkW0nG5
 z7bem8ttgf40BsgZVUMZnswxnHXjI3uGz41zDidnVEMsdaGJdZpQLiC4qPGaeJ+VkIkLBBPC0
 taWPLAxaBFaWsvegAgqo3G3BI3gtEEwXYcjUMkOhi4Mkp2NWbEES98lviZf01oVIFsDmJUDl7
 aScMKCoU+TAI4qmQn7DQ7L+TbUtf7ifGE119bG+appFTvphpDf8aTYXxb5XlS22zhVgmh5Y/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289409>

Hi Thomas,

On Sun, 20 Mar 2016, Thomas Gummerer wrote:

> On 03/18, Johannes Schindelin wrote:
> > 
> > On Fri, 18 Mar 2016, Thomas Gummerer wrote:
> > 
> > > [1] http://thread.gmane.org/gmane.comp.version-control.git/1379419842-32627-1-git-send-email-t.gummerer@gmail.com
> > 
> > Yes, I agree that something like that is needed. The proposed commit
> > message suggests that things get simpler, though, while I would
> > contend that timings get more accurate.
> > 
> > And I think you could simply move the test_start command, but that's
> > just from a *very* cursory reading of the patch.
> 
> Is it possible that you might have missed patch 2/2 [1]?

Yes, I did not read that patch. Sorry for the noise.

Ciao,
Dscho
