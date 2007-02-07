From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git log filtering
Date: Wed, 07 Feb 2007 17:55:07 +0100
Organization: At home
Message-ID: <eqd09b$4hg$1@sea.gmane.org>
References: <68948ca0702070841m76817d9el7ce2ec69835c50e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Cc: git@vger.kernel.org
To: Don Zickus <dzickus@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 07 18:30:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEqKj-0006s0-6l
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 18:11:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161441AbXBGRLQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 12:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161436AbXBGRLP
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 12:11:15 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:39354 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161441AbXBGRLN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 12:11:13 -0500
Received: by ug-out-1314.google.com with SMTP id 44so237701uga
        for <git@vger.kernel.org>; Wed, 07 Feb 2007 09:11:10 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:from:subject:to:cc:newsgroups:mail-copies-to:date:references:in-reply-to:lines:organization:user-agent:mime-version:content-type:content-transfer-encoding;
        b=OFCumbMuLy+YojF2apg1GuGap7U2Chx971g9/r2pTAoVlVoxhit9K71rKGs0M+zPZi6r6bdrpHJOSvVlnNANaxOLwmr/rU0ASpUOg1JGnalm/F4gmFzy3j31esL7iCVBXqmj4PwbrX0kbgDjm1B7OdDTNsX7bPyc7nkV1kT89dE=
Received: by 10.82.158.12 with SMTP id g12mr978902bue.1170868263382;
        Wed, 07 Feb 2007 09:11:03 -0800 (PST)
Received: from roke.D-201 ( [81.190.29.4])
        by mx.google.com with ESMTP id o1sm1341770uge.2007.02.07.09.11.00;
        Wed, 07 Feb 2007 09:11:01 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l17HAwpW007053;
	Wed, 7 Feb 2007 18:10:58 +0100
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l17HAu0x007052;
	Wed, 7 Feb 2007 18:10:56 +0100
Newsgroups: gmane.comp.version-control.git
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <68948ca0702070841m76817d9el7ce2ec69835c50e@mail.gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38943>

[Cc: git@vger.kernel.org]

Don Zickus wrote:

> I was curious to know what is the easiest way to filter info inside a
> commit message.
> 
> For example say I wanted to find out what patches Joe User has
> submitted to the git project.
>
> I know I can do something like ' git log |grep -B2 "^Author: Joe User"
> ' and it will output the matches and the commit id.  However, if I
> wanted to filter on something like "Signed-off-by: Joe User", then it
> is a little harder to dig for the commit id.
> 
> Is there a better way of doing this?  Or should I accept the fact that
> git wasn't designed to filter info like this very quickly?

You can use "git log --grep=<pattern>" for that, instead. This greps
raw commit message. You can use --author and --comitter to grep those
headers.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
