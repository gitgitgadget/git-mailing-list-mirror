From: Tommy Thorn <tt1729@yahoo.com>
Subject: Re: [PATCH] --format=pretty: new modifiers cID, cIS, CIY
Date: Fri, 1 Feb 2008 15:16:12 -0800 (PST)
Message-ID: <96032.15671.qm@web39506.mail.mud.yahoo.com>
References: <7vir188ej4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 02 00:17:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JL57x-0005gY-L7
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 00:16:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761553AbYBAXQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 18:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761513AbYBAXQT
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 18:16:19 -0500
Received: from web39506.mail.mud.yahoo.com ([209.191.106.90]:22340 "HELO
	web39506.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1761435AbYBAXQS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Feb 2008 18:16:18 -0500
Received: (qmail 16686 invoked by uid 60001); 1 Feb 2008 23:16:13 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=RdLkMtx4KqFlY0JitoUR9yxIztwLtIKTYurPFH5QN4IsCYvnIatLbavIPBvLpmIs8tA5MIpHhWqC1ZZ8OZzc9f4jSR7bAVDZ/ggJo5rvOSywwbAMXWMXXsNjY6XKGZj5gS0KvsVaHcwBCa7guoFb7XP46qzlCAgruv60uwRmCFM=;
X-YMail-OSG: ADVwQBoVM1mmDyApAqiNe7VGFnhGnoL9fttXJ7Gd.tiYD91mMmLVY4AcMbI4Lcb.coPOrrcedUVPyZxKaoerzdrV7yi5Q_velqiTCOpTxH8x7371wFU-
Received: from [216.228.112.21] by web39506.mail.mud.yahoo.com via HTTP; Fri, 01 Feb 2008 15:16:12 PST
In-Reply-To: <7vir188ej4.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72190>

[resent, sorry]

--- Junio C Hamano <gitster@pobox.com> wrote:
> I think we would very much prefer, instead of
> piling hacks on top of the originally supported 
> "minimum set", to introduce a truly extensible 
> syntax, like:

I concur, but pretty-please make it a super set of 
date(1) to the extent possible. It will lessen the 
confusion. 

Maybe something like "%c(%Y-%m-%d %H:%M) ...", eg.
such
that if `date +<format>' is legal, so is
"%c(<format>)".

Tommy


      ____________________________________________________________________________________
Looking for last minute shopping deals?  
Find them fast with Yahoo! Search.  http://tools.search.yahoo.com/newsearch/category.php?category=shopping
