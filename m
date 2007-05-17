From: Jakub Narebski <jnareb@gmail.com>
Subject: Glossary: trivial, clean, evil merge
Date: Thu, 17 May 2007 12:39:23 +0200
Message-ID: <200705171239.24300.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 18 00:51:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hooop-0005PY-BR
	for gcvg-git@gmane.org; Fri, 18 May 2007 00:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755366AbXEQWv0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 18:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756027AbXEQWv0
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 18:51:26 -0400
Received: from mu-out-0910.google.com ([209.85.134.189]:52433 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755366AbXEQWvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 18:51:25 -0400
Received: by mu-out-0910.google.com with SMTP id w1so470272mue
        for <git@vger.kernel.org>; Thu, 17 May 2007 15:51:24 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=CKMkdcgK5nBuyKORXBAfbuX+Bz8SWBXVkQFE1JhpBTabhxNF7bRfsUC7quNq3fYzXNLy2TTe7UWOLgqNMMD/wNhmvcLUgzy4J4nwDi3IEOCcgGjZQM/spooirlhY5aejN1l0qpKJyd4BUy/sha7ksVBLOUE5bYC1Gcv52ouv77s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QkR+wCNUjjCNrHdJKh+Qy/0SfKcFyDm8bQZoRHE6W27F9YUMqbFvyYI+wF6zdOjxriyTPKwMwOOgE0fZjxr4RQ+sKTPAfHCIqd5AWdxI8mOK5SBpnccb5owJB/Qd0V5rBU/kNIgb3gX0KRhxdg++qG5DDORA/xsmzxePUMHPjd8=
Received: by 10.82.118.2 with SMTP id q2mr1628221buc.1179442284171;
        Thu, 17 May 2007 15:51:24 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id j9sm3102669mue.2007.05.17.15.51.17;
        Thu, 17 May 2007 15:51:23 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47563>

  Glossary: trivial, clean, evil merge
              or
Merge flavours, and how to recognize them


What is the definition of a trivial merge? Is it tree-level merge, for 
which git-diff -c output would be empty?

What is the definition of clean merge? Is it merge without conflicts? 
How to name merge for which git-diff --cc output is empty: simple merge 
perhaps? I think it does not need to be clean merge in the "no 
conflicts" meaning.

What is the definition of evil merge? Is it merge for which merge commit 
is different from all the parents? How to name merge for which 
git-diff --cc output is non empty, then?

-- 
Jakub Narebski
Poland
