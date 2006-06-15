From: Alexander Litvinov <lan@academsoft.ru>
Subject: Re: Collecting cvsps patches
Date: Thu, 15 Jun 2006 10:14:25 +0700
Organization: AcademSoft Ltd.
Message-ID: <200606151014.31716.lan@academsoft.ru>
References: <20060611122746.GB7766@nowhere.earth> <200606150921.34690.lan@academsoft.ru> <1150340912.24184.7.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Yann Dirson <ydirson@altern.org>, GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 15 05:15:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqiJv-0005sU-Ik
	for gcvg-git@gmane.org; Thu, 15 Jun 2006 05:15:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbWFODOy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Jun 2006 23:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbWFODOy
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jun 2006 23:14:54 -0400
Received: from gw.ac-sw.com ([81.1.223.2]:46041 "EHLO gw.ac-sw.com")
	by vger.kernel.org with ESMTP id S1751269AbWFODOx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jun 2006 23:14:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by gw.ac-sw.com (Postfix) with ESMTP
	id 921FABDDC; Thu, 15 Jun 2006 10:14:52 +0700 (NOVST)
Received: from gw.ac-sw.com ([127.0.0.1])
 by localhost (gw.ac-sw.com [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 28206-07; Thu, 15 Jun 2006 10:14:42 +0700 (NOVST)
Received: from lan.ac-sw.lcl (lan.ac-sw.lcl [192.168.0.69])
	by gw.ac-sw.com (Postfix) with ESMTP
	id 353DABDDE; Thu, 15 Jun 2006 10:14:42 +0700 (NOVST)
Received: by lan.ac-sw.lcl (Postfix, from userid 65534)
	id F30038D943C1; Thu, 15 Jun 2006 10:14:41 +0700 (NOVST)
Received: from localhost (localhost [127.0.0.1])
	by lan.ac-sw.lcl (Postfix) with ESMTP id 768978D960B2;
	Thu, 15 Jun 2006 10:14:37 +0700 (NOVST)
To: Pavel Roskin <proski@gnu.org>
User-Agent: KMail/1.8
In-Reply-To: <1150340912.24184.7.camel@dv>
Content-Disposition: inline
X-Virus-Scanned: amavisd-new at gw.ac-sw.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21879>

> Actually, revision 5ecebc5064df0fd578dbf4b5ba5255e9af8cda7a renamed
> "tagnames" to "link" in cvsps_types.h, so I think the same should be
> done in cache.c.
>
> Also, you can check the definition of list_entry, you'll see that the
> member (argument 3) is cast to the pointer to the requested type
> (argument 2).  I don't think it's safe to cast name to a pointer to
> TagName.

You are right. My patch is wrong. I have tried to import real cvs repo and 
cvsps broke with sigsegv.
