From: Sean <seanlkml@sympatico.ca>
Subject: Re: git-cat-file "Not a valid object name"
Date: Fri, 28 Sep 2007 18:15:46 -0400
Message-ID: <BAYC1-PASMTP02FFAE9A97F102AC11A13EAEB20@CEZ.ICE>
References: <46FD7AA5.2080007@earthdetails.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Reza Roboubi <reza@earthdetails.com>
X-From: git-owner@vger.kernel.org Sat Sep 29 00:15:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbO7o-0000KN-1j
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 00:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753613AbXI1WPt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 18:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753457AbXI1WPt
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 18:15:49 -0400
Received: from bay0-omc2-s37.bay0.hotmail.com ([65.54.246.173]:30387 "EHLO
	bay0-omc2-s37.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753410AbXI1WPs (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Sep 2007 18:15:48 -0400
Received: from BAYC1-PASMTP02 ([65.54.191.162]) by bay0-omc2-s37.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 28 Sep 2007 15:15:48 -0700
X-Originating-IP: [69.156.110.168]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.110.168]) by BAYC1-PASMTP02.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Fri, 28 Sep 2007 15:15:47 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with smtp (Exim 4.43)
	id 1IbO7d-00040I-TI; Fri, 28 Sep 2007 18:15:45 -0400
In-Reply-To: <46FD7AA5.2080007@earthdetails.com>
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.0; i686-pc-linux-gnu)
X-OriginalArrivalTime: 28 Sep 2007 22:15:47.0901 (UTC) FILETIME=[1F17A6D0:01C8021D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59427>

On Fri, 28 Sep 2007 15:05:25 -0700
Reza Roboubi <reza@earthdetails.com> wrote:

> git-cat-file -t 9b22b50f814b22224d6f838433f1e9cd36bfc2
>
>
> says: "Not a valid object name".
> 
> So what is this thing in my .git:
> ../.git/objects/92/9b22b50f814b22224d6f838433f1e9cd36bfc2

Reza,

The first two digits of the sha1 appear before the final slash (/)..
Therefore the actual object name in the case you give is
929b22b50f814b22224d6f838433f1e9cd36bfc2.  So the following command
should work:

$ git cat-file -t 929b22b5

Sean
