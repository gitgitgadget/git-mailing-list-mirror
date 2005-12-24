From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: "p4 revert -a" equivalent in git?
Date: Fri, 23 Dec 2005 16:36:15 -0800 (PST)
Message-ID: <20051224003615.47349.qmail@web31807.mail.mud.yahoo.com>
References: <7vd5jn4a36.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 24 01:36:40 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpxOp-0006uE-39
	for gcvg-git@gmane.org; Sat, 24 Dec 2005 01:36:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161140AbVLXAgR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Dec 2005 19:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161147AbVLXAgQ
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Dec 2005 19:36:16 -0500
Received: from web31807.mail.mud.yahoo.com ([68.142.207.70]:28052 "HELO
	web31807.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161140AbVLXAgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Dec 2005 19:36:16 -0500
Received: (qmail 47351 invoked by uid 60001); 24 Dec 2005 00:36:15 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=jR83dfltMbrNzaNEpPbupaheSWiTiyAfJkqbL1j9FRIwaIOgSp1Sv1Vf8K4pEDewUIyZ5uivpK2wauG0zgC5T1pjsdrMiWA+FAPGUtukuglGk9Da7igYnxFoML5vcWfE4v4yErHQoFy8//Mf0Tl1VBwhhDvdc6FJ0o4s3zhbisc=  ;
Received: from [70.144.138.203] by web31807.mail.mud.yahoo.com via HTTP; Fri, 23 Dec 2005 16:36:15 PST
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5jn4a36.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14003>

--- Junio C Hamano <junkio@cox.net> wrote:
> That's what "git-update-index --refresh" does, unless I am
> misreading what you say you want.
> 
> 	$ git checkout master
>         $ touch *.c
> 	$ git diff-index HEAD ;# tons of changes
>         $ git update-index --refresh
> 	$ git diff-index HEAD ;# no changes

Ok, thanks.  I wasn't sure if I had to specify the file
names on the command line of "git-update-index --refresh".
It looks like I don't have to, so this is a perfect
equivalent.

Thanks,
   Luben
