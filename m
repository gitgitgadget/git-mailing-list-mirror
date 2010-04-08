From: Yann Dirson <dirson@bertin.fr>
Subject: Re: [PATCH 2/2] Change the description of '-M' and '-C' option.
Date: Thu, 08 Apr 2010 10:07:19 +0200
Organization: Bertin Technologies
Message-ID: <20100408100719.7fc89300@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: ydirson@free.fr
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 08 10:09:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nzmnv-0006iL-Qt
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 10:09:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752571Ab0DHIJb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 04:09:31 -0400
Received: from blois.bertin.fr ([212.234.8.70]:62036 "EHLO blois.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751503Ab0DHIJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 04:09:28 -0400
Received: from blois.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id 37B525417F
	for <git@vger.kernel.org>; Thu,  8 Apr 2010 10:09:24 +0200 (CEST)
Received: from YPORT1 (unknown [192.168.1.13])
	by blois.bertin.fr (Postfix) with ESMTP id 14B7C54196
	for <git@vger.kernel.org>; Thu,  8 Apr 2010 10:09:24 +0200 (CEST)
Received: from chalon.bertin.fr ([172.16.3.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0L0J00E7ETBNV130@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Thu, 08 Apr 2010 10:09:23 +0200 (CEST)
X-Mailer: Claws Mail 3.7.5 (GTK+ 2.12.12; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8146-6.0.0.1038-17306.003
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144344>

Very interesting addition, indeed - thanks much.

Some information may still be missing, though:

- the default value of the numeric argument to -M/-C
- the meaning of numeric arguments to the various flags when several
  are given (eg. what does "blame -M10 -C5 -C15" mean ?)
- the numeric arguments are not visible in the summary

On another aspect, given the nature of repetitive -C we may want to warn
the user of bomb out if more than 3 occurences of the flag happen ?

-- 
Yann
