From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: rev-list --parents --full-history + path: something's fishy
Date: Sun, 25 May 2008 21:58:22 +0200
Message-ID: <200805252158.22514.johannes.sixt@telecom.at>
References: <e1dab3980805230808s59798351r9ed702c7d0dedd2a@mail.gmail.com> <1211660214.483877b69a107@webmail.nextra.at> <alpine.LFD.1.10.0805241817500.3081@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Tweed <david.tweed@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun May 25 21:59:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0MNW-0004P3-BL
	for gcvg-git-2@gmane.org; Sun, 25 May 2008 21:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757544AbYEYT60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 May 2008 15:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757539AbYEYT60
	(ORCPT <rfc822;git-outgoing>); Sun, 25 May 2008 15:58:26 -0400
Received: from smtp3.srv.eunet.at ([193.154.160.89]:36153 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756566AbYEYT6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 May 2008 15:58:25 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp3.srv.eunet.at (Postfix) with ESMTP id 2E5EC10A6E2;
	Sun, 25 May 2008 21:58:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id E8AAA64464;
	Sun, 25 May 2008 21:58:22 +0200 (CEST)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LFD.1.10.0805241817500.3081@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82877>

On Sunday 25 May 2008 03:21, Linus Torvalds wrote:
> On Sat, 24 May 2008, Johannes Sixt wrote:
> > but this does not:
> >
> > $ git rev-list --full-history --parents HEAD -- a
> > M A B
> > B A
> > A
>
> That is the "correct" output.

But why does this:

$ git rev-list --full-history HEAD -- a
B
A

not list M (note the lack of --parents)?

-- Hannes
