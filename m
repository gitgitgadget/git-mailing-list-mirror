From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-svn not working when parent of cloned dir requires auth
Date: Mon, 08 Dec 2008 13:30:06 -0800
Message-ID: <7v4p1e73tt.fsf@gitster.siamese.dyndns.org>
References: <20081208205418.GA16418@cetel-004-xx6.admin.gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: "D. Stuart Freeman" <stuart.freeman@et.gatech.edu>
X-From: git-owner@vger.kernel.org Mon Dec 08 22:31:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9nha-0004UH-4O
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 22:31:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752200AbYLHVaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 16:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752140AbYLHVaP
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 16:30:15 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60252 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763AbYLHVaO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 16:30:14 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 34E1485743;
	Mon,  8 Dec 2008 16:30:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0B07185740; Mon,
  8 Dec 2008 16:30:07 -0500 (EST)
In-Reply-To: <20081208205418.GA16418@cetel-004-xx6.admin.gatech.edu> (D.
 Stuart Freeman's message of "Mon, 8 Dec 2008 15:54:18 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6544DD3C-C56F-11DD-A941-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102584>

"D. Stuart Freeman" <stuart.freeman@et.gatech.edu> writes:

> I'm trying to
> 'git svn clone https://mware.ucdavis.edu/svn/ucd-sakai/gradebook-gwt -s'
> that repo is setup to allow anonymous reading of that directory tree, but
> git-svn prompts me for a password.  I think git-svn is traversing up the
> directory tree and encountering a directory that needs authn, can I prevent
> it from doing that?

That sounds suspiciously similar to what I observed long time ago:

  http://thread.gmane.org/gmane.comp.version-control.git/46361/focus=46558

And $gmane/47151 in the thread, aka dc43166 (git-svn: don't minimize-url
when doing an init that tracks multiple paths, 2007-05-19), supposed to
have fixed it.

Hmm...  Eric?
