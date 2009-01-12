From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: checking out by date
Date: Mon, 12 Jan 2009 22:24:36 +0100
Message-ID: <200901122224.37058.robin.rosenberg.lists@dewire.com>
References: <20090112193039.GO25823@eratosthenes.cryptobackpack.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Bryson <david@statichacks.org>
X-From: git-owner@vger.kernel.org Mon Jan 12 22:53:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMUiP-0001Wl-ND
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 22:52:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753339AbZALVve (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 16:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752678AbZALVvd
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 16:51:33 -0500
Received: from mail.dewire.com ([83.140.172.130]:28181 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752544AbZALVvd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 16:51:33 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 07D6B1474468;
	Mon, 12 Jan 2009 22:51:31 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pnPXU4wbaVO6; Mon, 12 Jan 2009 22:51:30 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 8A9221484F41;
	Mon, 12 Jan 2009 22:51:30 +0100 (CET)
User-Agent: KMail/1.10.92 (Linux/2.6.27-11-generic; KDE/4.1.85; i686; ; )
In-Reply-To: <20090112193039.GO25823@eratosthenes.cryptobackpack.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105394>

David Bryson <david@statichacks.org> writes:
> Hi All,
> 
> I have a very large repository that imported into git from CVS with
> about 5 years worth of history.
> 
> Today I decided to checkout some code from the past:
> 
> $ git checkout master@{"Mon Dec 31  2007"}
> warning: Log for 'master' only goes back to Tue, 2 Dec 2008 16:57:15
> -0800.

git checkout $(git rev-list -n1 --before="Mon Dec 31  2007 23:59:59")

-- robin
