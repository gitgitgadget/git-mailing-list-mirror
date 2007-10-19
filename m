From: Michael Witten <mfwitten@MIT.EDU>
Subject: Re: Proposed git mv behavioral change
Date: Thu, 18 Oct 2007 22:54:19 -0400
Message-ID: <A2C1BF08-4CC8-4F98-9CA8-B81B2FBFE9E4@mit.edu>
References: <c594999b2337.2337c594999b@nyroc.rr.com> <20071019015419.GV14735@spearce.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 05:07:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiiCS-00064v-7I
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 05:07:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754533AbXJSDGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 23:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751732AbXJSDGt
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 23:06:49 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:34391 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750885AbXJSDGs (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Oct 2007 23:06:48 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id l9J36hOb023078;
	Thu, 18 Oct 2007 23:06:44 -0400 (EDT)
Received: from [18.239.2.43] (WITTEN.MIT.EDU [18.239.2.43])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id l9J2sKXb000288
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 18 Oct 2007 22:54:21 -0400 (EDT)
In-Reply-To: <20071019015419.GV14735@spearce.org>
X-Mailer: Apple Mail (2.752.2)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61622>


On 18 Oct 2007, at 9:54:19 PM, Shawn O. Pearce wrote:

> Elsewhere in git we use the --cached command line option to mean
> "only make the change in the index".


It seems like --cached should be phased out in favor of --index/ed
