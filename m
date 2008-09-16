From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] Use compatibility regex library for OSX/Darwin
Date: Tue, 16 Sep 2008 19:32:20 -0400
Message-ID: <20080916233220.GA14173@coredump.intra.peff.net>
References: <20080907184537.GA4148@regex.yaph.org> <W_emvcr7ijntBMNCDV17_XHXotGkm1Bn-9Bw-ZixcXmFyBWlDj5vYg@cipher.nrlssc.navy.mil> <alpine.LNX.1.10.0809161722580.18110@suse104.zenez.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Arjen Laarhoven <arjen@yaph.org>, git@vger.kernel.org,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 01:33:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfk30-00026W-V4
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 01:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325AbYIPXcX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 19:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752329AbYIPXcX
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 19:32:23 -0400
Received: from peff.net ([208.65.91.99]:3823 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752319AbYIPXcW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 19:32:22 -0400
Received: (qmail 25312 invoked by uid 111); 16 Sep 2008 23:32:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 16 Sep 2008 19:32:21 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Sep 2008 19:32:20 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.10.0809161722580.18110@suse104.zenez.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96047>

On Tue, Sep 16, 2008 at 05:25:46PM -0600, Boyd Lynn Gerber wrote:

>> I wonder if this is the right fix? Right now the GNU regex library is
>> necessary for Darwin, FreeBSD and AIX. I can add IRIX6.5 and Solaris 7
>> to that list. Have newer Solaris's been tested yet? (Jeff?) I wonder if
>> the new test which triggers this flaw has been tested on the other
>> non-GNU platforms in the Makefile which have not been updated. Boyd
>> Lynn Gerber and his 12 platforms comes to mind.
>
> Someone forwarded me this email and asked if I had tested it.  I have not. 
> Where is the easiest place to get it to test with the various platforms?  
> I will check it out on 3-5 of them.  I now have 1.6.0.2 on 5 platforms  
> running and working.  I have not had the time to get it on the other's  
> yet.

The problematic test is in 1.6.0.2; if you can run t4018-diff-funcname
successfully, then I believe you are not affected.

-Peff
