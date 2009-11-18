From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Hey - A Conceptual Simplication....
Date: Wed, 18 Nov 2009 14:30:11 +0100
Message-ID: <200911181430.13537.trast@student.ethz.ch>
References: <005a01ca684e$71a1d710$54e58530$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, <torvalds@osdl.org>
To: George Dennie <gdennie@pospeople.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 14:31:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAkd3-0005fT-Uh
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 14:31:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757018AbZKRNbO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 08:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756988AbZKRNbO
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 08:31:14 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:46403 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751534AbZKRNbN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2009 08:31:13 -0500
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 18 Nov
 2009 14:31:18 +0100
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 18 Nov
 2009 14:30:57 +0100
User-Agent: KMail/1.12.3 (Linux/2.6.27.37-0.1-default; KDE/4.3.3; x86_64; ; )
In-Reply-To: <005a01ca684e$71a1d710$54e58530$@com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133170>

George Dennie wrote:
>
> Instead, Git is treating a manually maintained list of files within the
> working tree as the versioned document, this list being initialized and
> manually amended by the "Git add/rm/mv" commands, etc. 

This feature is called the "index", and is not merely a list of the
files, but also their content.  Please read

  http://tomayko.com/writings/the-thing-about-git

for a nice explanation why this is a good and useful thing.

> 	"Git commit -x"   -- performs a "Git add ." then a "Git commit"
> 	"Git checkout -x" -- that clean the working tree prior to perform a checkout

That would require supernaturally good maintenance of your .gitignore
to avoid adding or (worse) nuking files by accident.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
