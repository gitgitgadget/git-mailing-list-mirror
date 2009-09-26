From: Mark Struberg <struberg@yahoo.de>
Subject: Re: [JGIT PATCH 1/9] mavenizing step 1: moved over the initial poms from Jasons branch Signed-off-by: Mark Struberg <struberg@yahoo.de>
Date: Sat, 26 Sep 2009 19:50:27 +0000 (GMT)
Message-ID: <901099.90084.qm@web27801.mail.ukl.yahoo.com>
References: <200909252333.56756.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org,
	Jason van Zyl <jvanzyl@sonatype.com>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sat Sep 26 21:50:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrdIC-0003Ub-9L
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 21:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793AbZIZTu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2009 15:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752819AbZIZTu1
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 15:50:27 -0400
Received: from web27801.mail.ukl.yahoo.com ([217.146.182.6]:25250 "HELO
	web27801.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752793AbZIZTuZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Sep 2009 15:50:25 -0400
Received: (qmail 94071 invoked by uid 60001); 26 Sep 2009 19:50:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s1024; t=1253994627; bh=V9WOD2EJcrAvLpHmG+UthkqzNo82YmtBf5CfQ6QtbMk=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type; b=1GgAdQHb4Zj/jx315XJ5kocLTgEQepvdK2/tzRb0wZ/0nEKmqiPMA5Y/4eXwU1TZZMOd11goMohWurb8zOTJ8eK8emOZK8PH7Pw6NJz1OfD0bU64p4zj1Fl3UjfWoZhbF/vyYvjdPVH5fKqCvTaF48jgLT2pHr7srMeBqE3BXgQ=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=pNMRKMS2VUMVc1f6jkWmhn1SYiGov2U0EH19auwg2hIKRJlSYRahmlf41Jtz8aPbTZY47hX74v+sad9emHiiAj4pcg11mGq242vBhkWKtSyWPSGuXkoRXrbf7mEEQaEdpaL53wgy1epNriBG4KOuwvwOtjl4UNFPbmddl0HyVyI=;
X-YMail-OSG: C3TSmoQVM1kDCW3IOSeCBd2_6CCj4jncjsAjbmVTYn6iwwqwOWQwIMu0mDpmsrWGZKznPUyx8iJ_Gi142BJPnDdgMff8Eqnczy.J2b_d4iz5CXrE3j9GEbee5g.IhjEBn2sm.OeysbdMdf.pjkU2T1PLcx8r0d_V2Ct2SJYTjsKZ4aysgtOq1ywBy955fp6_eOi1b33uPwluLRPLe8O_oOC3R7DBG.jL1G57rJo8eYeXtB.DNzfToHMkxIScm09LWtvPar93yoxUG0c9zapu4Qoc6x7jRPSK_TNc1IFG3r9rubXzQcHQmj1c
Received: from [62.47.130.12] by web27801.mail.ukl.yahoo.com via HTTP; Sat, 26 Sep 2009 19:50:27 GMT
X-Mailer: YahooMailClassic/7.0.14 YahooMailWebService/0.7.347.3
In-Reply-To: <200909252333.56756.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129171>

Hi Robin!

a) Actually git-format-patch only created 0001-0009 so there is no 0/9.

b) 2/9 is the actual directory structure moving. I received it, but since it is pretty large (330k already with -M -l0) it might got filtered out?
If so then may I ask you to please fetch it from http://github.com/sonatype/JGit branch 'mavenize'? It has the same content I sent to the list.

txs and LieGrue,
strub

--- On Fri, 9/25/09, Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:

> From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
> Subject: Re: [JGIT PATCH 1/9] mavenizing step 1: moved over the initial poms from Jasons branch Signed-off-by: Mark Struberg <struberg@yahoo.de>
> To: "Mark Struberg" <struberg@yahoo.de>
> Cc: git@vger.kernel.org, spearce@spearce.org, "Jason van Zyl" <jvanzyl@sonatype.com>
> Date: Friday, September 25, 2009, 11:33 PM
> 
> Where are the 0/9 and 2/9 mails?
> 
> -- robin
> 
> 
> 


      
