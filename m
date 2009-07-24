From: Bill Priest <priestwilliaml@yahoo.com>
Subject: Portability changes to mozilla-sha1
Date: Thu, 23 Jul 2009 22:32:11 -0700 (PDT)
Message-ID: <396555.40826.qm@web55001.mail.re4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 24 07:39:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUDUi-0002iJ-8w
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 07:39:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbZGXFix (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 01:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751002AbZGXFix
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 01:38:53 -0400
Received: from web55001.mail.re4.yahoo.com ([206.190.58.135]:30127 "HELO
	web55001.mail.re4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750779AbZGXFix (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jul 2009 01:38:53 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Jul 2009 01:38:52 EDT
Received: (qmail 41098 invoked by uid 60001); 24 Jul 2009 05:32:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1248413531; bh=0HckuRm7e+SVWcM47PpKANz8geUswZb5YnvaoYbOphc=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type; b=VVwAmxucywTJJyQZJcRa3g+PcmgAa3q6qWmmnr4/1XUj+de0MhV12YvlsvZDmm97A+nJ0G9wZ0SFzRchCTZSm+mcH/45RFLUfJugZDzicVrBBGmnfwY9ert2qsAEMv+5MMhVgE1biaIEgIh6bfTo4Q3rClQEiVntDuxKTWgtluc=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type;
  b=HCGB+J6gzF2Ln3wQ1zU1NMJ0RngSg/IV4ftpKz4icOsNuQ+Xr8DyYSdJezh1sXUJZKMmkg2DHZ5RU2bGSOOjIa7impKASGWBwSgAGokuqo+HaB8pmgGZdfJPd7gCyTFUKh2CqmWlOItpQ+AcjBUekq2aaki4IlqjdT2xqJBoCRk=;
X-YMail-OSG: AmKP7gYVM1kqoA9mEj_CVYnmhzn13nDTeSwQqqfJlPkGhgmaoJJ.diWEUo48VELrIoLPo2CuUMYp7h8OPk7Js9xqNaoiD0O_YZwwZL0Nv2uXaQ3HewPjsj63ZymZJIjPGohPDpJKvoFEkGEorxxnv2qTIfZ4v2ibxf.xEk2S1q7ocavdRNn1jjSG8j4J9jiU_bupxczvJizl6BSlsVoW13teIwjiAlgeWTPDuz7TEufJPCG065C3zv0dGLdCgVTF0WHixlljWs1i2U9dBZI1VxoTiJihRmuU92ErKp16mM6aD6lAJyK3ilR.xzMM8nPfugoA
Received: from [71.164.240.90] by web55001.mail.re4.yahoo.com via HTTP; Thu, 23 Jul 2009 22:32:11 PDT
X-Mailer: YahooMailClassic/5.4.17 YahooMailWebService/0.7.338.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123903>

All,
    In compiling sha1.c for a micro-controller and testing it I noticed that many of the types of the fields and local variables aren't portable.  Much of git appears to use uint32_t and the like when the size of the variable "matters".
    If a patch was provided to make sha1.[ch] portable in terms of the types used would it be accepted?  Of course the resulting code would be regression tested prior to submission.
    I google'd a little bit but didn't find any prior questions in a similar vein (sorry if I missed it).

Regards,

Bill



      
