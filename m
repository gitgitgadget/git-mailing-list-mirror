From: Tasslehoff Kjappfot <tasskjapp@gmail.com>
Subject: Odd behaviour in msysgit
Date: Fri, 12 Nov 2010 11:04:36 +0100
Message-ID: <4CDD1134.7090503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 12 11:04:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGqUv-0003Dc-Hf
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 11:04:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756509Ab0KLKEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 05:04:40 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:54646 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755954Ab0KLKEj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 05:04:39 -0500
Received: by eye27 with SMTP id 27so1731433eye.19
        for <git@vger.kernel.org>; Fri, 12 Nov 2010 02:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=0MporfelVSVu8FAKRgXJMQz8vZtWNlTRjYxG7HeMBrQ=;
        b=O8SFTYxo1o10VBuUAbsHrTOh930LuCU76W88SOvWdXF1k5KCUcBgJnquzLSYC498yD
         6zjfqhc3T/RCQybtt5rwkbQBAewUS7auwdkfw7tGEndJFxfB3hXKZDIekr5kRL1IalJK
         qsAjvIpUreB0OEkIBTfOcQjjbSCDqF3ozBcLU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=SqPERbN0XPmVLR/T73ny/50M7FD//n9GLCTT+7+HvTEFvf5KHWppvIqzAMqEg2ztc0
         rgFW0ynO4Lmqf5HWSgSSZXyJwLAHuFXn5wP75KW4+C46OaVwx1A5d49O8k7jM8QRAD2m
         0K3BUOxbRM5BQvqwXScBcBTY/nX84EmwBkQkY=
Received: by 10.213.103.74 with SMTP id j10mr1895555ebo.46.1289556278063;
        Fri, 12 Nov 2010 02:04:38 -0800 (PST)
Received: from [192.168.0.40] (147.84-49-231.nextgentel.com [84.49.231.147])
        by mx.google.com with ESMTPS id q58sm2994527eeh.15.2010.11.12.02.04.36
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 12 Nov 2010 02:04:37 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.13pre) Gecko/20101107 Shredder/3.1.7pre
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161332>

On a windows machine at work we have the same issue mentioned in 
http://osdir.com/ml/msysgit/2010-10/msg00165.html.

Running a command like "git status" repeatedly, it will often produce no 
output at all, while other times giving the desired status information.

On #git I was adviced to do "export GIT_PAGER=cat", but that didn't 
change the behaviour. Then I was adviced to tell the mailing list, which 
I now do :-)

- Tasslehoff
