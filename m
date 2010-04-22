From: Mahesh Vaidya <forvaidya@gmail.com>
Subject: SSH keys location
Date: Fri, 23 Apr 2010 00:10:49 +0530
Message-ID: <v2rb42431c81004221140n31c76030m74656d01950b8ae0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 22 20:40:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O51KZ-0004pA-6x
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 20:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754825Ab0DVSku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Apr 2010 14:40:50 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49793 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754561Ab0DVSkt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 14:40:49 -0400
Received: by pwj9 with SMTP id 9so6270502pwj.19
        for <git@vger.kernel.org>; Thu, 22 Apr 2010 11:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:received:message-id
         :subject:from:to:content-type;
        bh=2LN7AkV6SCXl1XGOO1JRUoz8PVf9cKkmZ6nWgp4tHjc=;
        b=LrFG3XNbmIknca9Un5ri+JxC/0iY5C2+KjtRg3FPgnVOCcWMTPowMVWjuqIquqk9r9
         P9AN7v2R4aj8TTrdmFvTynp5/DXRiklVU8Hc1HUhKZK2RTC6k3cw7QIp58Ra/ydrjO8e
         FNhTTpya5Pwfbr2IvWZCzPC2Xv5HMH1X8HnpY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=uz5TdjOKXeq2Pza4fLjqKS4n9y4qT02G1r4qcfYxL/M9OG+VYKAkOBbINweiRhyFb0
         3dwbP+xoN4Zc6bgupzTU5Gp52F/K7MRTdj5bRq3UW5jC76EPuVmJ1fDdJr5TadrZq6Y6
         Ofq7d982pc9hAccSbYBmSC+pP+vN1Zj8yWRQg=
Received: by 10.142.194.19 with HTTP; Thu, 22 Apr 2010 11:40:49 -0700 (PDT)
Received: by 10.142.152.5 with SMTP id z5mr4827182wfd.266.1271961649086; Thu, 
	22 Apr 2010 11:40:49 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145546>

Hi

I have a situation where I must save my private keys location other
than ~/.ssh ; How do I tell git URL that please take public key from
so and so location equivalent of ssh -i <identity-file> flag

example my clone command is

git clone gitosis@server:repos.git

Thank You

-Mahesh
