From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2 1/4] Documentation/git-merge: reword references to "remote" and "pull"
Date: Sun, 10 Jan 2010 13:24:45 +0100
Message-ID: <201001101324.47025.trast@student.ethz.ch>
References: <cover.1263081032.git.trast@student.ethz.ch> <57bddb115331a23816af772172531fb56fceace4.1263081032.git.trast@student.ethz.ch> <20100110041357.GF1083@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 10 13:24:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTwqm-0002GI-8M
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 13:24:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180Ab0AJMYx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jan 2010 07:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751579Ab0AJMYw
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jan 2010 07:24:52 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:7902 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750709Ab0AJMYw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jan 2010 07:24:52 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.213.0; Sun, 10 Jan
 2010 13:24:50 +0100
Received: from thomas.localnet (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.213.0; Sun, 10 Jan
 2010 13:24:50 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.8-0.1-desktop; KDE/4.3.90; x86_64; ; )
In-Reply-To: <20100110041357.GF1083@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136575>

Jonathan Nieder wrote:
> Thomas Rast wrote:
> >   * Look at the diffs.  'git diff' will show a three-way diff,
> > -   highlighting changes from both the HEAD and remote versions.
> > +   highlighting changes from both the HEAD and their versions.
> >  
> >   * Look at the diffs on their own. 'git log --merge -p <path>'
> 
> This is a bit awkward, since 'they' is playing two roles.  Also,
> the context does not make it obvious what 'our' and 'their'
> versions are.
> 
> Maybe:
> 
> |   * Look at the diffs.  'git diff' will show a three-way diff,
> |     highlighting changes from both the HEAD and MERGE_HEAD
> |     versions.

I like this idea, as it nicely assigns terminology to the "their"
side.  We need to explain MERGE_HEAD (it's not in the manpage yet),
but that should fit in somewhere.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
