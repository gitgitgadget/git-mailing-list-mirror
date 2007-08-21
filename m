From: Sean <seanlkml@sympatico.ca>
Subject: Re: empty directories
Date: Tue, 21 Aug 2007 13:40:30 -0400
Message-ID: <20070821134030.b763e9d3.seanlkml@sympatico.ca>
References: <1187716461.5986.71.camel@beauty>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Josh England" <jjengla@sandia.gov>
X-From: git-owner@vger.kernel.org Tue Aug 21 19:40:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INXih-0006Z8-JJ
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 19:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757702AbXHURko (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 13:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759503AbXHURko
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 13:40:44 -0400
Received: from bay0-omc1-s2.bay0.hotmail.com ([65.54.246.74]:31739 "EHLO
	bay0-omc1-s2.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755033AbXHURkn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Aug 2007 13:40:43 -0400
Received: from BAYC1-PASMTP05.bayc1.hotmail.com ([65.54.191.165]) by bay0-omc1-s2.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.2668);
	 Tue, 21 Aug 2007 10:40:43 -0700
X-Originating-IP: [64.231.205.174]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([64.231.205.174]) by BAYC1-PASMTP05.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Tue, 21 Aug 2007 10:40:42 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1 with smtp (Exim 4.43)
	id 1INXib-0004LW-JB; Tue, 21 Aug 2007 13:40:41 -0400
In-Reply-To: <1187716461.5986.71.camel@beauty>
X-Mailer: Sylpheed 2.4.2 (GTK+ 2.10.13; i686-pc-linux-gnu)
X-OriginalArrivalTime: 21 Aug 2007 17:40:42.0999 (UTC) FILETIME=[65B4F870:01C7E41A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56313>

On Tue, 21 Aug 2007 11:14:21 -0600
"Josh England" <jjengla@sandia.gov> wrote:

> Git doesn't seem to allow me to add an empty directory to the index, or
> even nested empty directories.  Is there any way to do this?  What is
> the reasoning?  I've got a use case where having empty directories in my
> git repository would be *very* valuable.  Any information and help is
> greatly appreciated.

Hi Josh,

Git doesn't track empty directories.  There is a brief note about it in
the FAQ:

 http://git.or.cz/gitwiki/GitFaq#head-1fbd4a018d45259c197b169e87dafce2a3c6b5f9

Sean
