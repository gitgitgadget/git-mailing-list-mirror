From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/3] automatically skip away from broken commits
Date: Tue, 09 Jun 2009 11:35:50 -0700
Message-ID: <7vljo1mf09.fsf@alter.siamese.dyndns.org>
References: <20090606043853.4031.78284.chriscool@tuxfamily.org>
	<7vskidcf9s.fsf@alter.siamese.dyndns.org>
	<200906070932.36913.chriscool@tuxfamily.org>
	<4A2CAA56.1030707@zytor.com> <7vws7n6vcf.fsf@alter.siamese.dyndns.org>
	<4A2D337C.70203@zytor.com> <7vzlcixwue.fsf@alter.siamese.dyndns.org>
	<c07716ae0906082124n4a5bfe88md80ba8076c928b76@mail.gmail.com>
	<c07716ae0906090526i714bb6c9g4e3d8cf61021af77@mail.gmail.com>
	<4A2E7EEC.2050807@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	Ingo Molnar <mingo@elte.hu>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 20:36:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME6Ay-0008Jp-MT
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 20:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754070AbZFISfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 14:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753761AbZFISft
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 14:35:49 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:50020 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753528AbZFISft (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 14:35:49 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090609183551.KEKK2915.fed1rmmtao103.cox.net@fed1rmimpo03.cox.net>;
          Tue, 9 Jun 2009 14:35:51 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 1ubr1c0044aMwMQ04ubrj8; Tue, 09 Jun 2009 14:35:51 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=ZlvubiwuF4QA:10 a=BRJNLUJM0I0A:10
 a=oGMlB6cnAAAA:8 a=zwRR5x3o4JkwMWB41OEA:9 a=T1_1D57_KFEquJzk2dfOLD3_17QA:4
 a=CY6gl2JlH4YA:10 a=p6VVfPvSLIypP3EF:21 a=Tuj_BnhgsaliMuC0:21
X-CM-Score: 0.00
In-Reply-To: <4A2E7EEC.2050807@zytor.com> (H. Peter Anvin's message of "Tue\, 09 Jun 2009 08\:25\:32 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121201>

"H. Peter Anvin" <hpa@zytor.com> writes:

> My main objection to the "skip in goodness space" is exactly the same as
> Junio's... it doesn't really buy you what it claims to sell.

It is no worse than the original "pick the next best in goodness space";
neither try to avoid the ones close to untestable ones.

So as long as it does not claim "we intelligently try to skip away from
untestable ones", I am actually Ok with Christian's patch.  It might do
worse than the random walk in pathological cases, but I suspect not by a
big margin.
