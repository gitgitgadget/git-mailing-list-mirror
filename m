From: Mahesh Vaidya <forvaidya@gmail.com>
Subject: Reuse .git directory.
Date: Thu, 25 Mar 2010 23:20:14 +0530 (IST)
Message-ID: <10467746.91269539410487.JavaMail.mvaidya@mvaidya-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 25 18:50:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NurCU-0002pV-3a
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 18:50:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753277Ab0CYRu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Mar 2010 13:50:29 -0400
Received: from mail-fx0-f223.google.com ([209.85.220.223]:32914 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752945Ab0CYRu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Mar 2010 13:50:28 -0400
Received: by fxm23 with SMTP id 23so1365961fxm.21
        for <git@vger.kernel.org>; Thu, 25 Mar 2010 10:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:message-id
         :subject:mime-version:content-type:content-transfer-encoding;
        bh=vjSOILCf0tapAaaE1kB1ikKObdL5b8oe9hRO9Wxm9J8=;
        b=epa44gHJPVZb5X2YQuAUVgcPKD9iCFsWWSSQoMrvaXXqdseE+VsMmfNy4yAmubdKkf
         trtrM5AvyPENhey91YF/XLQnEBgMVaIVv5jXKo+WI8kwet6ZsqU/9T/l1EiAkgrIKdhq
         7aTcU1+cU1q1MFybWoNeQvfKw8BYMInJ/URCs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:message-id:subject:mime-version:content-type
         :content-transfer-encoding;
        b=GwBPcFx26BoCuuELakPK4g1FZpW8QJD6Yrq2+M1nzLvTKsJPdzINUCYNjr7MA3xOgw
         sUhPwBH7betYhYz/0Aj5ZSU2PBJC0GgIpjFQ7ssPiTpS7ZE4t0YYFzZboJIVOVCbqpKP
         IEEix7KoynZZI0hN/3TH3pgannvh2hKPfbDCk=
Received: by 10.223.68.143 with SMTP id v15mr1066479fai.62.1269539426865;
        Thu, 25 Mar 2010 10:50:26 -0700 (PDT)
Received: from localhost ([209.78.40.112])
        by mx.google.com with ESMTPS id h2sm11980fkh.55.2010.03.25.10.50.23
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 25 Mar 2010 10:50:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143186>

Reuse .git directory.

I would like work 4 different branch simultaneously viz.

master, feature, bugfix, expt but would like to use same same GIT_DIR. Is this possible ? so that I can save some space ?

I have tried following 
* git clone /path/to/repos
* export GIT_DIR=/path/to/repos/.git
* mkdir ~/feature
* git checkout -b feature master

This step misses the files. Please advise me if such an approach is correct ?


Thx

Mahesh
