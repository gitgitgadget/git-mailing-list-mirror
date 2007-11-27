From: Steven Grimm <koreth@midwinter.com>
Subject: Re: git bug/feature request
Date: Tue, 27 Nov 2007 11:49:57 -0800
Message-ID: <FA6B0BE9-FC43-4298-932F-627826ADE18F@midwinter.com>
References: <200711271127.41161.gapon007@gmail.com> <Pine.LNX.4.64.0711271531110.1011@ds9.cixit.se> <fihc5u$mbs$1@ger.gmane.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 20:50:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix6Rn-0002K4-Sm
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 20:50:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754929AbXK0TuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 14:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754417AbXK0Tt7
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 14:49:59 -0500
Received: from tater.midwinter.com ([216.32.86.90]:59970 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752659AbXK0Tt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 14:49:58 -0500
Received: (qmail 6984 invoked from network); 27 Nov 2007 19:49:58 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=v47txr7oEz2seP5qkjrLhyXNMeVsjdW4C7nfVqzUcZy9qCCKgXFJBoSXZpSwDqmY  ;
Received: from localhost (127.0.0.1)
  by localhost with SMTP; 27 Nov 2007 19:49:58 -0000
In-Reply-To: <fihc5u$mbs$1@ger.gmane.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66255>

On Nov 27, 2007, at 7:13 AM, Jakub Narebski wrote:
> I thought that modern git refuses to push into checked out branch
> (in HEAD) in non-bare repositories.

It doesn't -- otherwise the "update the working copy when a push to  
the current branch comes in" update hook scripts that some of us use  
wouldn't work, and they do work at the moment. (Before anyone warns me  
of the dangers of that: the hook only runs in a shared repo that no  
human is allowed to modify, so the working copy is always a clean  
version of HEAD and thus is safe to update.)

-Steve
