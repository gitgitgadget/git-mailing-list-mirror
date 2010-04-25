From: Jack Desert <jackdesert556@gmail.com>
Subject: Bugreport: Git responds with stderr instead of stdout
Date: Sun, 25 Apr 2010 13:06:07 -0500
Message-ID: <20100425130607.2c92740f@pennie-farthing>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 25 20:06:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O66Dm-00013s-D4
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 20:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753672Ab0DYSGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Apr 2010 14:06:17 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:41378 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753617Ab0DYSGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 14:06:16 -0400
Received: by vws17 with SMTP id 17so961386vws.19
        for <git@vger.kernel.org>; Sun, 25 Apr 2010 11:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=ABXTrEuj1QoLIKgUsOdbBS8qCmcS6fVurOo2DpG81mU=;
        b=A9IfWcf17x96Kg5KNx3/fWYzCj/KRJ2gy3DXL61uzdKl/MTGFUHoapiq3qjc8q71Im
         5zP9Bc/0aIC3BTdI2eEtE+GggBy2xgEfk86OLIlhV9752xyLcTIufMIc128qDK/8IUlj
         CONNb+Ra876xZOtq1LXri9gW7bqgMpsG2M+Tc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        b=Uh74Fgjxw/qNF8NXSx1Hrjs0o1T8NFY5wWrfYyTNJNdw+pfUPPvkuMPMZxc4W25qkh
         /xonAP59qEEmwdkTd/TD4ja0nMcur26FAUE4t4j9RuwzbwPdknpyCJhNqSgMA6CSfEa9
         1BA42JtzBzIfHAwRHR1a1XoEvCFAkwqy729WI=
Received: by 10.220.61.201 with SMTP id u9mr1870233vch.160.1272218775554;
        Sun, 25 Apr 2010 11:06:15 -0700 (PDT)
Received: from pennie-farthing (oh-76-1-213-69.dhcp.embarqhsd.net [76.1.213.69])
        by mx.google.com with ESMTPS id b22sm15838088vcp.8.2010.04.25.11.06.14
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 25 Apr 2010 11:06:15 -0700 (PDT)
X-Mailer: Claws Mail 3.7.5 (GTK+ 2.18.3; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145753>

I think I found a bug in Git. When I run the command 

  git checkout -b new_branch

Git does exactly what I've asked, except that Git's response:
  
  Switched to a new branch 'new_branch'

comes through the stderr pipe instead of through the stdout pipe. Where do I file a bug report for this? 

I am using Git 1.6.3.3, Ubuntu 9.10

-Jack


-- 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Jack Desert     --    Writer, Entrepeneur
Author and Spokesman: www.LetsEATalready.com
Software Developer:   http://GrooveTask.org
Email: JackDesert556@gmail.com
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
