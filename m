From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH 3/3] Tie it all together: "git log"
Date: Wed, 1 Mar 2006 12:38:53 +1300
Message-ID: <46a038f90602281538m90c4d04pbb6f277e3bec89e8@mail.gmail.com>
References: <Pine.LNX.4.64.0602281115110.22647@g5.osdl.org>
	 <Pine.LNX.4.64.0602281126340.22647@g5.osdl.org>
	 <Pine.LNX.4.64.0602281251390.22647@g5.osdl.org>
	 <7vr75nm8cl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Mar 01 00:39:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEEQk-0006Ld-JK
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 00:38:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932685AbWB1Xiz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Feb 2006 18:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932686AbWB1Xiz
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Feb 2006 18:38:55 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:24256 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932685AbWB1Xiy convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2006 18:38:54 -0500
Received: by wproxy.gmail.com with SMTP id 71so1194wra
        for <git@vger.kernel.org>; Tue, 28 Feb 2006 15:38:54 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FssOX5+l/L4toRVSwKDoLxX1HORux1S+hALxD9O0Wie3C8DUvzdvRVHqYW2zFqcY/s9rsq4GJolkygMEX/gV6Pm45G/E32m9+3TTB1phNF/L7fJX+EYS4pohfCW5OBhgrBEa2YM0Md+vmnrmgrHqJsOWf0g9EJKCqbIIZ4nh8+k=
Received: by 10.54.102.15 with SMTP id z15mr1283343wrb;
        Tue, 28 Feb 2006 15:38:53 -0800 (PST)
Received: by 10.54.71.5 with HTTP; Tue, 28 Feb 2006 15:38:53 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vr75nm8cl.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16959>

On 3/1/06, Junio C Hamano <junkio@cox.net> wrote:
> I would say we should just rip merge-order out.  Who uses it,
> and why does it not work with topo-order, again?

IIRC archimport uses it, but there's no reason why topo-order wouldn't work.

cheers,


martin
