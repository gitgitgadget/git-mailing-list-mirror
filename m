From: Alexander Litvinov <lan@ac-sw.com>
Subject: Re: [PATCH] git-cvsimport: Add -A <author-conv-file> option
Date: Fri, 13 Jan 2006 09:19:00 +0600
Organization: AcademSoft Ltd.
Message-ID: <200601130919.00928.lan@ac-sw.com>
References: <20060112233859.3438F5BED0@nox.op5.se> <7vvewohoy0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <exon@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 04:19:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExFTA-0001nf-S6
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 04:19:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161646AbWAMDTM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 22:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161647AbWAMDTL
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 22:19:11 -0500
Received: from gw.ac-sw.com ([81.1.223.2]:9120 "EHLO gw.ac-sw.com")
	by vger.kernel.org with ESMTP id S1161646AbWAMDTJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jan 2006 22:19:09 -0500
Received: from localhost (localhost [127.0.0.1])
	by gw.ac-sw.com (Postfix) with ESMTP id 079E4BD78;
	Fri, 13 Jan 2006 09:19:08 +0600 (NOVT)
Received: from gw.ac-sw.com ([127.0.0.1])
 by localhost (gw.ac-sw.com [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 22160-05; Fri, 13 Jan 2006 09:19:05 +0600 (NOVT)
Received: from lan.ac-sw.lcl (lan.ac-sw.lcl [192.168.0.69])
	by gw.ac-sw.com (Postfix) with ESMTP id D4117BD1B;
	Fri, 13 Jan 2006 09:19:05 +0600 (NOVT)
Received: by lan.ac-sw.lcl (Postfix, from userid 65534)
	id D04CC94F7AC9; Fri, 13 Jan 2006 09:19:05 +0600 (NOVT)
Received: from localhost (localhost [127.0.0.1])
	by lan.ac-sw.lcl (Postfix) with ESMTP id 767718CFDB0D;
	Fri, 13 Jan 2006 09:19:01 +0600 (NOVT)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.8
In-Reply-To: <7vvewohoy0.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: amavisd-new at gw.ac-sw.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14605>

On Friday 13 January 2006 07:55, Junio C Hamano wrote:
> ISTR there was a thread that suggested using CVSROOT/users file
> for this purpose.
>
> 	http://thread.gmane.org/gmane.comp.version-control.git/8167

This should went into docs for cvsimport. Before now I knew there is a way to 
import authors but I did not find anything in cvsimport script. This patch 
shows not only me lost this feature.
