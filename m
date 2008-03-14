From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: About detached heads
Date: Fri, 14 Mar 2008 16:21:47 +0100
Message-ID: <200803141621.48321.jnareb@gmail.com>
References: <93c3eada0803140246k53408c74m21f9dc277857202d@mail.gmail.com> <20080314134205.GA19674@pe.Belkin> <b77c1dce0803140753w21515021u4541796d6e6934b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Chris Shoemaker" <c.shoemaker@cox.net>,
	geoffrey.russell@gmail.com, git@vger.kernel.org
To: "Rafael Garcia-Suarez" <rgarciasuarez@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 16:22:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaBk3-0000tW-H9
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 16:22:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754215AbYCNPV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 11:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753597AbYCNPV4
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 11:21:56 -0400
Received: from gv-out-0910.google.com ([216.239.58.185]:2375 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131AbYCNPV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 11:21:56 -0400
Received: by gv-out-0910.google.com with SMTP id s4so810426gve.37
        for <git@vger.kernel.org>; Fri, 14 Mar 2008 08:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=2aTS7BYUbrihK1ScFvNrTCqhvbJtasONaSylAz1lBn8=;
        b=dXXyxCYNnsYFUPtumgL8qxsVAu/1zJGW+zJ2yCKGCVETuHzxqnj6HdGwvsCcAL/CnBdDFavbpOe8CeTApFNiIZKsZj34EzqmiUt2AJSiUhZyX0bgKkDE2LoCY1oK3wuFr6rnB3CdCPjaDsEOVJj0+VpjF3icC3eoJVNblWKj5q0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=DES3XT6IPJOneWfACnSglTYKd38IdYr0g4m3uaCQuekqgtXpNP0zg0Y/m3obhtXPzedLoY7FdEx5kuZQAL0V4zxeUS4Ae/P2f2oWRZdXCm3SjvFMkBO/APIYXiFkk6aZaq6XzLBUsnzQY3eNs+kf4vJKO8QyFBsFzFukLbrYVKo=
Received: by 10.150.206.1 with SMTP id d1mr6399602ybg.4.1205508112706;
        Fri, 14 Mar 2008 08:21:52 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.191.199])
        by mx.google.com with ESMTPS id s10sm20143279muh.11.2008.03.14.08.21.49
        (version=SSLv3 cipher=OTHER);
        Fri, 14 Mar 2008 08:21:50 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <b77c1dce0803140753w21515021u4541796d6e6934b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77237>

On Fri, 14 Mar 2008, Rafael Garcia-Suarez wrote:
> On 14/03/2008, Chris Shoemaker wrote:
>>
>>   This way you would get exactly:
>>
>>     1---2---3---4---5---3'   <--- master <--- HEAD
>>
>>
>>  While the 3' commit has the same contents as 3, it is a new, distinct
>>   commit with its own history.  Its commit message should explain why
>>   you want to go from 5 back to the contents of 3.
> 
> Just a small question -- does that mean that 3 and 3' share the same
> tree object ?

Yes it does. 

Commit object has link to a tree object in the form
of its sha1 id, and repository's object store is content addressed,
or to be more exact sha-1 id of contents addressed.

-- 
Jakub Narebski
Poland
