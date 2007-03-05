From: Bill Lear <rael@zopyra.com>
Subject: Re: Git checkout preserve timestamp?
Date: Mon, 5 Mar 2007 10:28:56 -0600
Message-ID: <17900.17736.918538.734811@lisa.zopyra.com>
References: <17895.18265.710811.536526@lisa.zopyra.com>
	<200703051213.52513.andyparkins@gmail.com>
	<17900.11612.872928.633406@lisa.zopyra.com>
	<200703051601.49370.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Karl =?iso-8859-1?q?Hasselstr=F6m?= <kha@treskal.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 17:29:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOG4G-0002Ij-DE
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 17:29:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777AbXCEQ3N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 11:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752799AbXCEQ3N
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 11:29:13 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61887 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752777AbXCEQ3M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 11:29:12 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l25GSx732747;
	Mon, 5 Mar 2007 10:28:59 -0600
In-Reply-To: <200703051601.49370.andyparkins@gmail.com>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41458>

On Monday, March 5, 2007 at 16:01:45 (+0000) Andy Parkins writes:
>On Monday 2007 March 05 14:46, Bill Lear wrote:
>
>> All very wrong if you ignore what I wrote as part of my original note:
>> keep compilation products separated by branch name, not in the same
>
>I realise why it's causing you troubles.  However, I was hoping that that 
>little example shows why it can never be right to use the timestamp out of 
>the repository.

I don't understand then.  If the timestamp is stored per-branch, as it
must be, then no effective change takes place whatsoever, and all
products are compiled properly, and in their proper place.

If master:source.c compiles to .master/source.o and has a timestamp
.master/source.c.timestamp, switching to branch1 and back, and
restoring the timestamp does not do anything wrong.  It just prevents
a recompilation.

>I'm afraid that the unnecessary recompile is just a by-product of that 
>organisation.  I still say that git is correct to touch the file dates.

Well, git is certainly correct for those who want the standard behavior.

I don't think the current submodule support will help, but I am keen
to see submodules for other reasons.


Bill
