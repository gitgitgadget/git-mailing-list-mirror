From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git svn fetch loses data
Date: Sun, 15 Nov 2009 14:33:53 +0100
Message-ID: <200911151433.54797.trast@student.ethz.ch>
References: <7d4f41f50911140907n285d72dcp7bbe802900f8bae5@mail.gmail.com> <4AFF3EB7.5080606@gmail.com> <7d4f41f50911150156x4cc07dcch977c90e5bd134d17@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Johan 't Hart <johanthart@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, <git@vger.kernel.org>
To: Victor Engmark <victor.engmark@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 15 14:34:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9fFd-0002lC-ND
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 14:34:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752860AbZKONef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 08:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752857AbZKONee
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 08:34:34 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:47665 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752851AbZKONee (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 08:34:34 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Sun, 15 Nov
 2009 14:34:39 +0100
Received: from thomas.localnet (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Sun, 15 Nov
 2009 14:34:37 +0100
User-Agent: KMail/1.12.3 (Linux/2.6.27.37-0.1-default; KDE/4.3.3; x86_64; ; )
In-Reply-To: <7d4f41f50911150156x4cc07dcch977c90e5bd134d17@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132937>

Victor Engmark wrote:
> On Sun, Nov 15, 2009 at 12:35 AM, Johan 't Hart <johanthart@gmail.com> wrote:
> > Sverre Rabbelier schreef:
> > 
> > > $ git rebase git-svn
> > 
> > Why not just
> > $ git svn rebase
> 
> What is the difference between the two?

'git svn rebase' magically[*] picks the right remote branch to rebase
against, and also first talks to the network to update said branch.


[*] actually it looks at the first git-svn-id line found in git log
--first-parent.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
