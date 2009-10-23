From: Ivan Dimitrov <ivand58@gmail.com>
Subject: [git question] how to handle few projects with common parts?
Date: Fri, 23 Oct 2009 12:01:22 +0300
Message-ID: <368bc75e0910230201y8e4310dme6276d436c6a6ab6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 23 11:01:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1G1Z-0006xQ-RE
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 11:01:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbZJWJBU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2009 05:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbZJWJBU
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 05:01:20 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:49489 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbZJWJBT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2009 05:01:19 -0400
Received: by fxm18 with SMTP id 18so10078789fxm.37
        for <git@vger.kernel.org>; Fri, 23 Oct 2009 02:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=QmBm22teYZvDQuYFYPwTCCEawSQLfvTH3ObdrWYvRgs=;
        b=ElUbxrHMp1/35/euJTiPx8Zs2OlVshO0viHQg84iS/LvZCw4ufPyZMtXWlWum94KsT
         ndzlAvQachJoP/1OHB+qjL0w5+CbF7CYA/6QlD9a0OdG9kzEbSJQzy51ID/y7iKyRyu/
         LL00pnHq+BERfPoJhH0u8T9QXAYPRpQi9Y/Zs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=r7Iyk5Bw4l7mYw7p8/yJylVSiJuJMOMvYn85DSBOs3R4eGQjYXtAoj6cfd2O80NK9t
         C6c9IsOF4fdoEDY4XjsPdiLZ0T9IaOHsDQz/JMce+RVmYXHp0isD69u0ZEj5IFze/w/x
         5zK2X5DcS21M+sHRbyc+btB+Dm+UF2TVdhXIY=
Received: by 10.204.3.220 with SMTP id 28mr897676bko.4.1256288482863; Fri, 23 
	Oct 2009 02:01:22 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131102>

Hi list,
Maybe my question relates rather to configuration management, but it
is over GIT.
In short - I have to manage two projects with 95% same files
(components) and all the rest are platform depended. I am trying to
keep different platforms in different branches, but I can't figure out
how keep the common part of the project synchronized?

-- 
Best Regards,
Ivan Dimitrov
