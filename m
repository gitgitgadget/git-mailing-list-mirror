From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: New script to convert p4 repositories to git - git-p4c version 1.
Date: Sun, 14 Dec 2008 05:11:31 -0800 (PST)
Message-ID: <m38wqiewaq.fsf@localhost.localdomain>
References: <1228818317.5504.23.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: John Chapman <thestar@fussycoder.id.au>
X-From: git-owner@vger.kernel.org Sun Dec 14 14:12:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBqmC-0006DP-Pv
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 14:12:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752982AbYLNNLf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 08:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752974AbYLNNLf
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 08:11:35 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:48378 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752969AbYLNNLe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 08:11:34 -0500
Received: by ey-out-2122.google.com with SMTP id 6so314137eyi.37
        for <git@vger.kernel.org>; Sun, 14 Dec 2008 05:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=Kj1OSRNKGJi+GLFuokuPpFcGjNyOLayyi8hMa7edNkU=;
        b=fO4r1yMSCfcy47F6mi9+H03pLn7NeMNFQVqM9XiuLHjZ1erstCLW3Q658f+gm/CXsm
         C4+lgI/UIA3XZ4KqPLxRINxpLReio/XzcxADyGSHJCsxcVleAxr38v10a5lUXiWywiJG
         FrCzz44Rq8u6YmUHTt2S3xomEU13KfNAFXmuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=PRO1sILuRr6OOJGzrmqCFVsL7CJdBTPbMq7Bt+X5hSBxjqz0UEuk5Uq8qjjrWAbq+o
         kvcCuVyvn2EDOVosqjKvyqq8XiC/9zQIM30WbnbsHi1sHzcviyvnOPuv6w92ZKma0Cuf
         BIb8IwTYnnCIu/UA6DYZO8B2EW3eZg9MNj2Pc=
Received: by 10.210.125.13 with SMTP id x13mr3247898ebc.48.1229260292334;
        Sun, 14 Dec 2008 05:11:32 -0800 (PST)
Received: from localhost.localdomain (abxb72.neoplus.adsl.tpnet.pl [83.8.251.72])
        by mx.google.com with ESMTPS id 7sm434288eyb.51.2008.12.14.05.11.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 14 Dec 2008 05:11:31 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mBEDBSvx016976;
	Sun, 14 Dec 2008 14:11:28 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mBEDBPjd016972;
	Sun, 14 Dec 2008 14:11:25 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1228818317.5504.23.camel@localhost>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103079>

John Chapman <thestar@fussycoder.id.au> writes:

> It is called git-p4c, because 'git-p4' was taken, and I intended to
> write it in C++.  I may still rewrite it in C++ if it is found
> neccessary to use it on windows. (The Perforce C++ ABI will remove the
> need to fork so many processes), but I won't be doing that before I
> implement the write to perforce support.
> 
> Consider this to be experimental, not yet worthy of a version number.

Do you feel it would be worth adding it below git-p4 (and other
Perforce importers) on git wiki page:
  http://git.or.cz/gitwiki/InterfacesFrontendsAndTools

Or would you rather wait a bit to at least version 0.1?
-- 
Jakub Narebski
Poland
ShadeHawk on #git
