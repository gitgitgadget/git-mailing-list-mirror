From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git-repack && git-prune-packed isn't doing it's job anymore?
Date: Sat, 4 Mar 2006 14:01:09 +1300
Message-ID: <46a038f90603031701o3f5c948cl1eb05c0f731251b3@mail.gmail.com>
References: <46a038f90603031629qbbb287ckd8da1ef56a831dba@mail.gmail.com>
	 <7v64mv2for.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 04 02:01:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFL92-0004oo-FB
	for gcvg-git@gmane.org; Sat, 04 Mar 2006 02:01:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766AbWCDBBN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Mar 2006 20:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751775AbWCDBBN
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Mar 2006 20:01:13 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:3913 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751766AbWCDBBN convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Mar 2006 20:01:13 -0500
Received: by wproxy.gmail.com with SMTP id i30so780181wra
        for <git@vger.kernel.org>; Fri, 03 Mar 2006 17:01:12 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bvMrmhoMzU16cbAnSpskIU86EOSeQiZSkYpcqeoYq0mJB2YHoszxFUCWaaWwNSQo8CaENln1oefRyYrpEDSESu3DFE37MhKwtQDH37sMYythWQCGm3hSum5+KiJ2j+bqeBxT9grlWGT4ZDnMInjVHkX5RhQI6ljIam3rr+/w3vM=
Received: by 10.54.140.20 with SMTP id n20mr1782022wrd;
        Fri, 03 Mar 2006 17:01:09 -0800 (PST)
Received: by 10.54.71.5 with HTTP; Fri, 3 Mar 2006 17:01:09 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7v64mv2for.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17163>

On 3/4/06, Junio C Hamano <junkio@cox.net> wrote:
> If that is the case, "git prune" would be the right tool to use.

Spot on. Thanks!

> And this is not something that changed recently.

Of course, my bad. I had not seen this before. I guess it was because
I hadn't actually paid much attention at leftover objects in
oft-rebased repositories. I used to look at the .git/objects directory
a lot in my early git days, when I didn't do any rebasing.

thanks again!


martin
