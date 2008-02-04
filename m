From: Bill Lear <rael@zopyra.com>
Subject: Re: Possible kinder GIT-VERSION-GEN?
Date: Mon, 4 Feb 2008 16:32:10 -0600
Message-ID: <18343.37482.618436.999319@lisa.zopyra.com>
References: <18343.30080.67524.3427@lisa.zopyra.com>
	<7vve54ids2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 23:33:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM9se-0006SF-Jj
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 23:33:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754216AbYBDWdE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 17:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755022AbYBDWdD
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 17:33:03 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61412 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752925AbYBDWdB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 17:33:01 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id m14MWAq17510;
	Mon, 4 Feb 2008 16:32:10 -0600
In-Reply-To: <7vve54ids2.fsf@gitster.siamese.dyndns.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72583>

On Monday, February 4, 2008 at 13:59:25 (-0800) Junio C Hamano writes:
>Bill Lear <rael@zopyra.com> writes:
>
>> I have my home directory under git control, and I have a build
>> directory (not tracked by git) under my home directory into which I
>> untar files and then in which I build things, including git.
>
>Let me make sure I understand you by rephrasing.  You are
>extracting git tarball as an untracked subdirectory in an
>unrelated project, and GIT-VERSION-GEN misbehaves.  One such
>misbehaviour is that it adds -dirty.

Yes, that is correct.

>And I think you are right.  The -dirty suffix should be relative
>to the output of "git describe".  Version string derived from
>any other codepath should not get the suffix, simply because we
>do not even know if it is dirty.  In fact, we should not even
>attempt to run that diff-index to figure out if it is dirty.

Ok, I trust you know what you are talking about with git-describe.:-)


Bill
