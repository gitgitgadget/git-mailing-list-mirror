From: Michael Witten <mfwitten@MIT.EDU>
Subject: Re: [PATCH 3/3] git-cvsexportcommit.perl: git-apply no longer needs --binary
Date: Tue, 16 Oct 2007 18:13:44 -0400
Message-ID: <561D7B44-9EDE-447B-A751-BE6E3A3AD9CC@mit.edu>
References: <1192522094-4988-1-git-send-email-mfwitten@mit.edu> <Pine.LNX.4.64.0710161404220.25221@racer.site> <19B03C18-6BBD-4F67-93DC-37B422445C82@mit.edu> <200710162320.14917.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 00:14:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihufr-0007nD-MX
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 00:14:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965809AbXJPWNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 18:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765449AbXJPWNw
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 18:13:52 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:35526 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761808AbXJPWNv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2007 18:13:51 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id l9GMDkdn027171;
	Tue, 16 Oct 2007 18:13:46 -0400 (EDT)
Received: from [18.239.2.43] (WITTEN.MIT.EDU [18.239.2.43])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id l9GMDjho000837
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 16 Oct 2007 18:13:45 -0400 (EDT)
In-Reply-To: <200710162320.14917.robin.rosenberg.lists@dewire.com>
X-Mailer: Apple Mail (2.752.2)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61264>


On 16 Oct 2007, at 5:20:14 PM, Robin Rosenberg wrote:

> So all this series does is... making it harder to follow the history?

If you follow the history solely on patches.


> Ack for removing the --binary, the rest is just noise

I think fixing the tabs is more important than removing --binary.

It's clear the the entropy of tabulation increases over time;
the tab patch acts as a buffer to reconstruct a clean signal.

Michael Witten
