From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: monotone is slow
Date: Fri, 16 Feb 2007 16:20:18 -0500
Message-ID: <9e4733910702161320s12ba7a2boadaf075993579900@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 16 22:20:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIAVS-0007Cr-3j
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 22:20:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946258AbXBPVUW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 16:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946260AbXBPVUW
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 16:20:22 -0500
Received: from ik-out-1112.google.com ([66.249.90.177]:35713 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946258AbXBPVUV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 16:20:21 -0500
Received: by ik-out-1112.google.com with SMTP id c21so48718ika
        for <git@vger.kernel.org>; Fri, 16 Feb 2007 13:20:19 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=fYYftUMKp95V3GoJ+7dii8hcqRLamMjWQrD/KfK8g9xlxRyWIgBOin8qOsF0IlJyAa88+HK9YaEBi/pc87LROxTBqS/MkAou9L8yc2pJwMbRTGL8nWinhN1zLRQonWEsG8m1U2HLyFXO2ukmAxxFwdhP95WFN9fwcLXAENmDWZE=
Received: by 10.115.95.1 with SMTP id x1mr2191124wal.1171660818664;
        Fri, 16 Feb 2007 13:20:18 -0800 (PST)
Received: by 10.114.195.13 with HTTP; Fri, 16 Feb 2007 13:20:18 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39952>

45 CPU minutes to do a pull. About 2hrs real time.

jonsmirl@jonsmirl:~$ ps aux | grep mtn
jonsmirl  8382 80.5  4.4 131444 115204 pts/0   S+   14:54  45:44 mtn pull

And it worked, nothing was wrong. 1,500 revs pulled.
Let's convert the world to git.

-- 
Jon Smirl
jonsmirl@gmail.com
