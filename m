From: Michele Ballabio <barra_cuda@katamail.com>
Subject: Re: New features in gitk
Date: Mon, 29 Oct 2007 15:04:08 +0100
Message-ID: <200710291504.08516.barra_cuda@katamail.com>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 29 15:00:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImVAV-00056b-BI
	for gcvg-git-2@gmane.org; Mon, 29 Oct 2007 15:00:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752832AbXJ2OAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 10:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752794AbXJ2OAY
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 10:00:24 -0400
Received: from slim-3a.inet.it ([213.92.5.124]:60813 "EHLO slim-3a.inet.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752462AbXJ2OAX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2007 10:00:23 -0400
Received: from host232-56-static.104-80-b.business.telecomitalia.it ([::ffff:80.104.56.232]) by slim-3a.inet.it via I-SMTP-5.4.4-547
	id ::ffff:80.104.56.232+rYrP5EpBBmn; Mon, 29 Oct 2007 15:00:19 +0100
User-Agent: KMail/1.9.7
In-Reply-To: <18211.59478.188419.397886@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62619>

On Sunday 28 October 2007, Paul Mackerras wrote:
> * Gitk now uses a new graph layout algorithm, which means it doesn't
>   have to generate the whole layout from top to bottom at startup
>   time, making startup faster.

This is probably causing gitk to eat my (admittedly old) CPU, sometimes.

For example, a

	gitk --all v1.5.2..v1.5.3

gives me problems when I scroll down to about half of the shown history:
that is when I reach the sequence of hundreds of "merge topic branch
into next" commits, and gitk tries hard to display the graph as best
as it can.

It can become unresponsive for one second at every PgDown.

Otherwise, gitk is way faster in other (non-pathological)
circumstances.
