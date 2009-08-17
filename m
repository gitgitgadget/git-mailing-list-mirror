From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: "make quick-install-man" broke recently
Date: Sun, 16 Aug 2009 18:33:24 -0700
Message-ID: <86iqgn8brv.fsf@blue.stonehenge.com>
References: <86my5z8cjd.fsf@blue.stonehenge.com>
	<7vy6pj449g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 03:33:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mcr6H-0005i6-Nj
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 03:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756514AbZHQBdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2009 21:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756512AbZHQBdX
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 21:33:23 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:43811 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756471AbZHQBdX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2009 21:33:23 -0400
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id E26431DE5A7; Sun, 16 Aug 2009 18:33:24 -0700 (PDT)
x-mayan-date: Long count = 12.19.16.10.17; tzolkin = 3 Caban; haab = 15 Yaxkin
In-Reply-To: <7vy6pj449g.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Sun, 16 Aug 2009 18:29:15 -0700")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126104>

>>>>> "Junio" == Junio C Hamano <gitster@pobox.com> writes:

Junio> "Something broke" is bit too vague a problem description if you expect
Junio> me to look into it.

Very sorry.  Let me include some text.

% rm -rf /opt/git/share/man
% make prefix=/opt/git quick-install-man
make -C Documentation quick-install-man
    SUBDIR ../
make[2]: `GIT-VERSION-FILE' is up to date.
'/bin/sh' ./install-doc-quick.sh origin/man /opt/git/share/man
% make prefix=/opt/git quick-install-man
make -C Documentation quick-install-man
    SUBDIR ../
make[2]: `GIT-VERSION-FILE' is up to date.
'/bin/sh' ./install-doc-quick.sh origin/man /opt/git/share/man
error: git checkout-index: unable to create file /opt/git/share/man/man1/git-add.1 (File exists)
error: git checkout-index: unable to create file /opt/git/share/man/man1/git-am.1 (File exists)
error: git checkout-index: unable to create file /opt/git/share/man/man1/git-annotate.1 (File exists)
error: git checkout-index: unable to create file /opt/git/share/man/man1/git-apply.1 (File exists)
[...]

So it fails the second time.  This is new behavior.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.vox.com/ for Smalltalk and Seaside discussion
