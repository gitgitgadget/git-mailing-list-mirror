From: Todd Rinaldo <toddr@cpanel.net>
Subject: Re: git clean --exclude broken?
Date: Wed, 24 Aug 2011 18:08:28 -0500
Message-ID: <F6809F96-2D71-482C-934F-2CF4EA74FEA1@cpanel.net>
References: <A04A4D84-16CC-438C-8828-0D11BE9DE2DA@cpanel.net> <7vliuio65w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 25 01:08:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwMYl-00053Z-Ay
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 01:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893Ab1HXXIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 19:08:30 -0400
Received: from mx1.cpanel.net ([208.74.121.68]:59667 "EHLO mx1.cpanel.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750751Ab1HXXI3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Aug 2011 19:08:29 -0400
Received: from ng1.cptxoffice.net ([208.74.121.102] helo=[10.1.4.99])
	by mx1.cpanel.net with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.69)
	(envelope-from <toddr@cpanel.net>)
	id 1QwMYe-0007bA-FU; Wed, 24 Aug 2011 18:08:28 -0500
In-Reply-To: <7vliuio65w.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1244.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - mx1.cpanel.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - cpanel.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180049>


On Aug 24, 2011, at 4:23 PM, Junio C Hamano wrote:

> Todd Rinaldo <toddr@cpanel.net> writes:
> 
>> I think I have found a new bug in 1.7.5:
> 
> My quick check indicates 1.7.3 behaves the same way, and 1.7.2.5 didn't
> have --exclude option, so this does not seem to be anything particularly
> new in the 1.7.5 release.
No. I was just clarifying what my binary was for research purposes.

> 
>> # The problem (Why is foo/ removed?)
>> $>git clean -dXf --exclude=/foo
>> Removing bar/
>> Removing foo/
> 
> Why is this command line giving -X that tells us not to use the ignore
> rules, and --exclude option at the same time?
My more complicated use of the command wanted to use the .gitignore rules to cleanup ignored files with the exception of 1 directory. I believe -dxf --exclude is also broken in the same way.
