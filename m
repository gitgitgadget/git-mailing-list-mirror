From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: "make quick-install-man" broke recently
Date: Mon, 17 Aug 2009 07:26:53 -0700
Message-ID: <861vna8qj6.fsf@blue.stonehenge.com>
References: <86my5z8cjd.fsf@blue.stonehenge.com>
	<7vy6pj449g.fsf@alter.siamese.dyndns.org>
	<86iqgn8brv.fsf@blue.stonehenge.com>
	<7vd46v3tp1.fsf@alter.siamese.dyndns.org>
	<8c9a060908162258ua50e34ah53c1ada9dbcd4aa0@mail.gmail.com>
	<7vhbw72ap3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jacob Helwig <jacob.helwig@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kjetil Barvik <barvik@broadpark.no>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 16:27:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md3As-0001eA-JD
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 16:27:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753406AbZHQO0x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 10:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753353AbZHQO0w
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 10:26:52 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:25783 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753004AbZHQO0w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 10:26:52 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id EE9421DE39E; Mon, 17 Aug 2009 07:26:53 -0700 (PDT)
x-mayan-date: Long count = 12.19.16.10.18; tzolkin = 4 Etznab; haab = 16 Yaxkin
In-Reply-To: <7vhbw72ap3.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Sun, 16 Aug 2009 23:53:12 -0700")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126186>

>>>>> "Junio" == Junio C Hamano <gitster@pobox.com> writes:

Junio> Merlyn noticed that Documentation/install-doc-quick.sh no longer correctly
Junio> removes old installed documents when the target directory has a leading
Junio> path that is a symlink.  It turns out that "checkout-index --prefix" was
Junio> broken by recent b6986d8 (git-checkout: be careful about untracked
Junio> symlinks, 2009-07-29).

It's good to know I wasn't hallucinating, in any case. :)

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.vox.com/ for Smalltalk and Seaside discussion
