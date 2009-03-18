From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Suggested Workflow Question
Date: Wed, 18 Mar 2009 14:52:53 +0100
Message-ID: <200903181452.53497.robin.rosenberg.lists@dewire.com>
References: <loom.20090317T175010-470@post.gmane.org> <46a038f90903172141o7b272c17v2c485bb66b529fe8@mail.gmail.com> <loom.20090318T125717-946@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Roger Garvin <yoyodyn@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 14:55:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjwEQ-0003Vh-3r
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 14:54:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbZCRNxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 09:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754632AbZCRNxF
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 09:53:05 -0400
Received: from mail.dewire.com ([83.140.172.130]:26461 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754617AbZCRNxE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 09:53:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id B5742139137A;
	Wed, 18 Mar 2009 14:52:55 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fLVBrwJ17kFu; Wed, 18 Mar 2009 14:52:54 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id CD328138AD53;
	Wed, 18 Mar 2009 14:52:54 +0100 (CET)
User-Agent: KMail/1.11.1 (Linux/2.6.27-12-generic; KDE/4.2.1; i686; ; )
In-Reply-To: <loom.20090318T125717-946@post.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113615>

onsdag 18 mars 2009 14:00:51 skrev Roger Garvin <yoyodyn@gmail.com>:
> Martin Langhoff <martin.langhoff <at> gmail.com> writes:
> 
> > We've done a ton of that. Even better than emailing is that you can
> > have a repo on a usb stick/disk.
> > 
> 
> That would be great except that most of our customers do not technically allow
> us to plug USB drives into any of their computers.  It's a rather silly rule
> actually but the drives could be confiscated. 
> 
> Thank you for the links to the other thread.  I will read through those today.
> I am hoping that this is simpler in practice than it looks on paper, cause what
> I see on paper is a fully connected graph of all our employees with all our
> customers multiple source locations and with our office server.  It seems like
> it could get out of control for tracking where changes might be (who is holding
> them)

Don't forget the option of mailing bundles (man git-bundle). Those will give the effect of push/fetch via e-mail. I.e. the exact same commit SHA's get replicated, That may be relevant for the branches that contain your released/official test code.

-- robin
