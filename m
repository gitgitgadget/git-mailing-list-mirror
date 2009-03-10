From: "Marcel M. Cary" <marcel@oak.homeunix.org>
Subject: Re: Remove leading/trailing whitespace from commit messages when
 importing from Subversion?
Date: Mon, 09 Mar 2009 22:38:27 -0700
Message-ID: <49B5FCD3.8060707@oak.homeunix.org>
References: <49B5DB01.8080206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Mike Swanson <mikeonthecomputer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 06:40:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lguhq-0003on-GM
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 06:40:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753415AbZCJFil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 01:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752919AbZCJFil
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 01:38:41 -0400
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:39995 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752880AbZCJFik (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Mar 2009 01:38:40 -0400
Received: (qmail 65987 invoked from network); 10 Mar 2009 05:38:38 -0000
Received: from unknown (HELO ordinateur.home.org) (marcel@75.61.101.228 with plain)
  by smtp119.sbc.mail.sp1.yahoo.com with SMTP; 10 Mar 2009 05:38:37 -0000
X-YMail-OSG: J4TLQPcVM1nK.bmNX3QD.a7EnYyNsN.FAoIFavL8pHLbur3q9YXkeUZPNy_JhExIuf2WXLqbDRNW_K2q2qrqLwQf.O4YARUrLMWOvuAjLvCaDxcYJyHoWiHvgiAUXXvsJRbm0Yrd0pjbnUZz84hC_Rlu
X-Yahoo-Newman-Property: ymail-3
Received: from polliwog.home.org ([192.168.0.18])
	by ordinateur.home.org with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <marcel@oak.homeunix.org>)
	id 1Lgufk-0007y6-Cs; Mon, 09 Mar 2009 22:38:36 -0700
User-Agent: Thunderbird 2.0.0.6 (X11/20070801)
In-Reply-To: <49B5DB01.8080206@gmail.com>
X-Enigmail-Version: 0.95.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112779>

Mike Swanson wrote:
> I was wondering if it's possible to removing leading and trailing
> whitespace (tabs, newlines, spaces) from commit messages when importing
> from Subversion via git-svn.
> 
> I've got a repository with tens of thousands of commits, and not all of
> the messages are entered... sanely.  I need to know whether it is
> possible to clean these up when transfering the repository to Git.

Try "git filter-branch --msg-filter your-filter-command".

Marcel
