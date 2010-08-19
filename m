From: av78us vaal <av78us@yahoo.com>
Subject: stgit: command to remove file from patch
Date: Thu, 19 Aug 2010 09:29:18 -0700 (PDT)
Message-ID: <829548.96589.qm@web45501.mail.sp1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 19 18:36:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Om86N-0002ME-3p
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 18:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248Ab0HSQgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Aug 2010 12:36:15 -0400
Received: from n61.bullet.mail.sp1.yahoo.com ([98.136.44.37]:46094 "HELO
	n61.bullet.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752678Ab0HSQgO (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Aug 2010 12:36:14 -0400
X-Greylist: delayed 342 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Aug 2010 12:36:14 EDT
Received: from [216.252.122.219] by n61.bullet.mail.sp1.yahoo.com with NNFMP; 19 Aug 2010 16:30:32 -0000
Received: from [98.136.44.164] by t4.bullet.sp1.yahoo.com with NNFMP; 19 Aug 2010 16:30:31 -0000
Received: from [127.0.0.1] by omp605.mail.sp1.yahoo.com with NNFMP; 19 Aug 2010 16:29:19 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 81912.94846.bm@omp605.mail.sp1.yahoo.com
Received: (qmail 16557 invoked by uid 60001); 19 Aug 2010 16:29:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1282235358; bh=2/v/VwyfOJivHogFDMKMdpc0TvCVZNr3bRmus6wWCh4=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type; b=Pb28ojCu5eNJDL6qTEEMz9TCqKKsWwleGIXCDimxQOrYELehENfPjYNwF4rc0h6FE0qM0PihsGuehoQ3+yIydj26qQrJPdDWsoHyeCx9zAUcKHIMexS+P1/xxzctbsRBqu517TPwvOiCmdOc1S7UqE0ZF1JMQtSmtyJskmcXB/A=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type;
  b=FQDYbTbjoalhUa2dPA1aMaJFME+9fvf+fjy5fI9Gizxpqj4sStV5q3y0raB2cil2w9z+Jz/DLZHemO/6HkZdxey0D26qh2YNY0axWCqJSlzFLx+y6kNqNY2R5M1QuO117FbSo4VE9DJWBs84jtd18ost43KqpAeE+OztbTV5Vc0=;
X-YMail-OSG: wLJTfTkVM1kNpSWPze0vygSS8CvZX7BWHIaFbWaKF2CB5CO
 VkgM_ef7IsELJUv2cTA.V3BnTQ0xQ_BrlSNEBmVj6xfHbEiTE7FplKWt5pev
 k9UdSav_JJpFY69ecNesN7NU6c2iFTH2x9WFUzamJd2dQmXj1D_O5kneQy4m
 PPAuj1f4ABRhPV8oysbjw1MWXm9hTZGLdA9wl7o3_Gl7abT25Pgqeu.Sz6Om
 RKl4KolYVPpnV0ZEQXqWVTk5FO7JBIgtyN55.k3E70OTh.aoABgEM
Received: from [192.163.20.231] by web45501.mail.sp1.yahoo.com via HTTP; Thu, 19 Aug 2010 09:29:18 PDT
X-Mailer: YahooMailClassic/11.3.2 YahooMailWebService/0.8.105.279950
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153942>

Hi, 

Is there a command to remove a file from a patch in stgit? I mean, something like "quilt remove". 

I searched a lot but I couldn't find any. 

If such a command is not available, is there an easy way to achieve this by other means. I tried this by changing the git commit and using "stg repair". That didn't work for me.

I would like to propose "stg remove" to be placed very high on stgit wish-list. 

Thanks,
Aneesh



      
