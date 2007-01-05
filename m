From: Luben Tuikov <ltuikov@yahoo.com>
Subject: New way of tracking remote branches -- question
Date: Fri, 5 Jan 2007 15:02:31 -0800 (PST)
Message-ID: <776323.21089.qm@web31808.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sat Jan 06 00:02:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2y55-0000jB-UH
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 00:02:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbXAEXCd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 18:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbXAEXCd
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 18:02:33 -0500
Received: from web31808.mail.mud.yahoo.com ([68.142.207.71]:41101 "HELO
	web31808.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750838AbXAEXCc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jan 2007 18:02:32 -0500
Received: (qmail 21467 invoked by uid 60001); 5 Jan 2007 23:02:31 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=t8vIaBn7MVFLJrLyJEhqOVJ5Ttizax4QUVulP+M1HbkSlDTuUVBs1sHbsoj53+j+FmRDe3QVLKbWWDvNA+eDweVevFUyYOKjyYGjuwj361NRGOTsl/0ojT/Iw6bVvLvf+1mBtleLaKPQ0/vSfJk+rjwfxL0X+oyj0OWQTyKikFc=;
X-YMail-OSG: iv1EbgEVM1kZIrizYnE716YBbeW.Ws9BedzIk0lH.hNokaMKkSdRD_RsYd8dKCOGPjI5ZvnGeTIJbV6OOMfUzBhp6lB2k_tT9IaGsXq0hYTD2Q.0WYw3AjXMESlllS8AcFdQ7_ExVjJ2DIMBx2Z1X1bacoWrQWjUzYaSN0LoSkoP4tJJ3VObulPhoTg56gtJbU_UDkD4g2spyA--
Received: from [64.215.88.90] by web31808.mail.mud.yahoo.com via HTTP; Fri, 05 Jan 2007 15:02:31 PST
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36040>

I can see that the remote heads are where they are supposed to be
but no local tracking heads are created (by default).  I had
to do this manually.

Old behavior was that git did that for you automatically.
So I suppose this is another newbie protection.

What is the now the new, accepted way of tracking locally
remote branches? (other than creating them manually in
refs/heads?)

Thanks,
   Luben
