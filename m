From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] git/gitweb.git repository
Date: Mon, 03 Sep 2007 22:42:40 -0700
Message-ID: <7v8x7n7zqn.fsf@gitster.siamese.dyndns.org>
References: <20070831000149.GK1219@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jnareb@gmail.com, ltuikov@yahoo.com
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Sep 04 07:43:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISRBe-0001EG-FW
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 07:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbXIDFmu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 01:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbXIDFmu
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 01:42:50 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:34761 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277AbXIDFmt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 01:42:49 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 1811212DB10;
	Tue,  4 Sep 2007 01:43:03 -0400 (EDT)
Importance: high
In-Reply-To: <20070831000149.GK1219@pasky.or.cz> (Petr Baudis's message of
	"Fri, 31 Aug 2007 02:01:49 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57522>

Here is my impressions on patches in:

	git://repo.or.cz/git/gitweb.git/ next

* Removal of git_blame

  I think this makes sense; we do not need two not-so-different
  implementations, and the other one has been the default for
  quite some time.

* Extra columns in blame

  I can see why some people especially with wide screen would
  want this, and toggling the display for extra columns is also
  a good idea.  But this makes me wonder if the single button at
  the very top is easy to locate (maybe explain what [+] does?)
  and easy to access (maybe have it at the top and at least at
  the bottom as well?).

* Incremental blame

  It does not seem to break the blame, but at least from where I
  sit accessing repo.or.cz this does not look incremental to me.
  The entire browser session freezes until the blame page
  displays in full.  My local installation behaves the same way.



  
