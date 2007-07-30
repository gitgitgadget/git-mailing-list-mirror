From: Matthew L Foster <mfoster167@yahoo.com>
Subject: Re: merge time
Date: Mon, 30 Jul 2007 09:20:00 -0700 (PDT)
Message-ID: <153733.59721.qm@web51006.mail.re2.yahoo.com>
References: <Pine.LNX.4.64.0707292114120.6510@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Mon Jul 30 18:21:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFY0K-0002CV-9c
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 18:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbXG3QUG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 12:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S939661AbXG3QUF
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 12:20:05 -0400
Received: from web51006.mail.re2.yahoo.com ([206.190.38.137]:40810 "HELO
	web51006.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S939729AbXG3QUC (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jul 2007 12:20:02 -0400
Received: (qmail 60477 invoked by uid 60001); 30 Jul 2007 16:20:00 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=vQAoTnCi8ySp++SRcBuYO4EsX3j8nTpd/pHAv/9QZ6K2BYrvZLmswbfFp5GrdrWlc326wksRKFpKTOr7GgkV8rr6w6dBfxczJhH1xzAQ723ekT33mg+ZwsJfVtTcbYldi3ACE+9gcW5ezy3P0TGMZHIyoj9Ke4IuROnRnJ4wMYg=;
X-YMail-OSG: WLb6z0AVM1m8USypb9iGfj.8BtDKh3uxHyURKx5J69DRVT_aMxCsVmu3V_yc8PbNHWWoGlOad6S3pjMfspVCuN_xzD8asnAYHhQZ_7oMUOhbJWif8TdfYTAJSCVq_5su_s4glAocR53rMLtFPudg._Eu
Received: from [208.58.8.179] by web51006.mail.re2.yahoo.com via HTTP; Mon, 30 Jul 2007 09:20:00 PDT
In-Reply-To: <Pine.LNX.4.64.0707292114120.6510@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54236>

--- david@lang.hm wrote:

> if you clone your tree and merge from mine, and I clone my tree and merge 
> from yours, the result of both merges _must_ be the same there will be 
> trouble when we both try and merge with tree C later on.
> 
> another thing is that a given commit cannot be changed once it's created 
> (if it was changed it wouldn't have the same sha1 value) so you can't just 
> go around changeing dates on commits that took place elsewhere.

Local commit order is stored locally right? From looking at gitweb on kernel.org it seems all the
info is already there, a merge has a list of commits in that merge and they should be displayed in
local commit order rather than external creation time order.

-Matt



       
____________________________________________________________________________________Ready for the edge of your seat? 
Check out tonight's top picks on Yahoo! TV. 
http://tv.yahoo.com/
