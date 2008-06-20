From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH 1/2] t3404: extra checks and s/! git/test_must_fail git/
Date: Fri, 20 Jun 2008 21:00:37 +0200
Message-ID: <20080620190037.GE7369@leksak.fem-net>
References: <alpine.DEB.1.00.0806201407230.6439@racer> <1213986614-19536-1-git-send-email-s-beyer@gmx.net> <X-0hXtX7hZGzbL_zS7e4VUMsiMfWiIfABUCFp28XZx0@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Jun 20 21:01:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9lrq-0005l4-C3
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 21:01:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752921AbYFTTAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 15:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753123AbYFTTAr
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 15:00:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:58634 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752838AbYFTTAr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 15:00:47 -0400
Received: (qmail invoked by alias); 20 Jun 2008 19:00:45 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp019) with SMTP; 20 Jun 2008 21:00:45 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19E1pV5oEtEEvG8ex6Cx5ZOwwf5FXJHpMyGmdyaci
	wdHaDwB3noRlYE
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K9lqf-0005L3-NI; Fri, 20 Jun 2008 21:00:37 +0200
Content-Disposition: inline
In-Reply-To: <X-0hXtX7hZGzbL_zS7e4VUMsiMfWiIfABUCFp28XZx0@cipher.nrlssc.navy.mil>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85673>

Hi,

> > @@ -380,7 +397,7 @@ test_expect_success 'interrupted squash works as expected' '
> >  	! FAKE_LINES="1 squash 3 2" git rebase -i HEAD~3 &&
> 
> These can be converted to use test_must_fail by using a sub-shell
> as Junio demonstrated:
> 
> 	(
> 		FAKE_LINES="1 squash 3 2" &&
> 		export FAKE_LINES &&
> 		test_must_fail git rebase -i HEAD~3
> 	) &&

Perhaps I'm not consequent, but I thought that it's not worth it ;-)

(There is also another reason: I use a dirty test-lib.sh _hack_ locally,
that allows me to exactly see where a failing test_expect_success patch
fails (that saves some time), but the hack does not work on tests with a
subshell invocation.)

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
