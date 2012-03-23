From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] gitweb(1) Fixed English issues
Date: Fri, 23 Mar 2012 16:46:25 +0100
Message-ID: <878vircoby.fsf@thomas.inf.ethz.ch>
References: <0316A9BA-627B-4B43-8BF1-392DD7408146@bbn.com>
	<1332509111-sup-2763@pinkfloyd.chass.utoronto.ca>
	<53140318-34FA-4EF1-80F9-CFAD8828B3A1@bbn.com>
	<08B31D69-CE1F-4D27-8AE6-C1C0D76BEED5@spamcop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: git <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: D Waitzman <djw@spamcop.net>
X-From: git-owner@vger.kernel.org Fri Mar 23 16:46:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SB6hF-00039S-Ka
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 16:46:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758857Ab2CWPq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Mar 2012 11:46:29 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:42341 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754872Ab2CWPq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 11:46:28 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 23 Mar
 2012 16:46:23 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 23 Mar
 2012 16:46:25 +0100
In-Reply-To: <08B31D69-CE1F-4D27-8AE6-C1C0D76BEED5@spamcop.net> (D. Waitzman's
	message of "Fri, 23 Mar 2012 11:02:43 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193769>

D Waitzman <djw@spamcop.net> writes:

> This is a trivial patch to correct the english in the man page.  Ben Walton suggested an additional english fix which I have added and squashed with my change.  And then I added it again when he pointed out I missed something in his original email.
>
> --
>
> Fixed improper use of "it's" when it should be "its".
> Added missing "the"; noted by Ben Walton bwalton@artsci.utoronto.ca
>
>     Signed-off-by: David Waitzman <djw@bbn.com>
> ---
>  Documentation/gitweb.txt |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
> index 605a085..168e8bf 100644
[snip patch]

Note that the correct way to put commentary in the patch mail that does
not go into the commit message is putting it after the --- marker.
Also, we write commit messages in the imperative.  The above should
probably look roughly like

  Subject: Documentation/gitweb: trivial English fixes

  Change "it's" to "its" where a possessive is intended.

  Also add two missing "the" that were noticed by Ben Walton
  <bwalton@artsci.utoronto.ca>.

  Signed-off-by: David Waitzman <djw@bbn.com>
  ---
  This is a trivial patch to correct the english in the man page.  Ben
  Walton suggested an additional english fix which I have added and
  squashed with my change.  And then I added it again when he pointed
  out I missed something in his original email.

   Documentation/gitweb.txt |    4 ++--
   1 file changed, 2 insertions(+), 2 deletions(-)

  diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
  index 605a085..168e8bf 100644

Note that I added "Subject:" here to make it an inline patch (though you
obviously need to remove my extra formatting indent).  If there's no
Subject pseudoheader, the patch gets the subject of your email, and
similarly for From and author.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
