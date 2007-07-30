From: Matthew L Foster <mfoster167@yahoo.com>
Subject: Re: merge time
Date: Sun, 29 Jul 2007 18:11:07 -0700 (PDT)
Message-ID: <241612.78983.qm@web51007.mail.re2.yahoo.com>
References: <alpine.LFD.0.999.0707291623160.3442@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, mfoster167@yahoo.com
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jul 30 03:11:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFJn1-0004Ka-K0
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 03:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965508AbXG3BLM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 21:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965504AbXG3BLM
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 21:11:12 -0400
Received: from web51007.mail.re2.yahoo.com ([206.190.38.138]:20689 "HELO
	web51007.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S965452AbXG3BLL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jul 2007 21:11:11 -0400
Received: (qmail 79613 invoked by uid 60001); 30 Jul 2007 01:11:08 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=ne6kg10bpg5MmrJ3EubUAW46HH5TyrR2FSlwRk29j5GTf28tOi+r8y6ydqD3GuYi1NgM6BRRua2+yYK3Qq2Jv2iTXrtASnNffNcwspEpqNKgwCQDW41vv4R/o1bRmMkfYHsgahVEpe/LPRvbRZXeg9hZQkco3YSCC9qQlfKoZf0=;
X-YMail-OSG: gkCdz_0VM1m8D_1RhWaY5R0KOMYFKGjY6K3hSKqrFdajFWCU5RKgt1mHJpmvB0.2vyO650IuF1Xe0rhn9w7tNKFp0Hl5zQ6Tjbv3Oax82HYteO_Pyv3G3o8w1A--
Received: from [208.58.8.179] by web51007.mail.re2.yahoo.com via HTTP; Sun, 29 Jul 2007 18:11:07 PDT
In-Reply-To: <alpine.LFD.0.999.0707291623160.3442@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54166>

--- Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Well, there i sno "wrong" time. There are just "different" times. The only 
> thing git really tracks is not actually the time (that's purely for human 
> consumption), but the *relationship* between commits. So git really very 
> fundmanetally just tracks things like "commit X was the parent of commit 
> Y", and the time is really immaterial.

Is it possible for git and/or gitweb to know that commits X and Y are descendents of merge C and
use the time merge C happened locally for both instead of using the time commits X and Y were
created? It seems to me changes showing up as being made long before they really were merged is a
very serious problem verification wise but if everyone is using git then perhaps it's not as bad
as I think. What happens when security bug fix Z errantly seems to be in v2.6.22 but in reality
its not?

Thanks for the responses,
-Matt



      ____________________________________________________________________________________
Park yourself in front of a world of choices in alternative vehicles. Visit the Yahoo! Auto Green Center.
http://autos.yahoo.com/green_center/ 
