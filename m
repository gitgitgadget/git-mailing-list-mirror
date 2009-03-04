From: Emily Ren <lingyan.ren@gmail.com>
Subject: Why isn't hook file cloned to bared repository ?
Date: Wed, 4 Mar 2009 13:40:56 +0800
Message-ID: <856bfe0e0903032140w4d8a9415l9f7b9a0678b492cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 04 06:42:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LejsC-0004QS-Su
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 06:42:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbZCDFlA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 00:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbZCDFlA
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 00:41:00 -0500
Received: from mail-gx0-f174.google.com ([209.85.217.174]:47670 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021AbZCDFk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 00:40:59 -0500
Received: by gxk22 with SMTP id 22so6231358gxk.13
        for <git@vger.kernel.org>; Tue, 03 Mar 2009 21:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=RjzewPn0HpjiEe6iLLZ+0r6YSV/xinL9/iUu06PxaEk=;
        b=oh6HCRwZ9Qka4NJu+Mc3xrnfNRaRFTkPj+sGXqgYlTWX9yu/L5woFuczwSEKEywUpg
         6RuTdNjw7LT17Ben6zPJ9oJTNDkEEPrwLVwbZwNRgZ5Sinj6ddBuPbma5TWO6B4Hq6JI
         6rSKy2i4jkREMTTpbLR8jlbj+0ZMncYlaN8lw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=Qd9TJnmef0eHD76HmfJ/3SCpBg2DyjHNX3pVt1jHxuYNC/XeK124+tJ4YpckL3GH8i
         +LWm7nKiJ7s1+TEyF+a3JzZxo5/Pm+TA6qW2/3EB5LDRIUTd6JfOC3XIfp7nNIJDOTZF
         RHxjcpKSuDnI4tuv3SjMvxkkXacvW1RrwF20Q=
Received: by 10.151.40.6 with SMTP id s6mr4254773ybj.60.1236145257008; Tue, 03 
	Mar 2009 21:40:57 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112180>

Hi,

I added file "update" in my git repository my_repo/.git/hooks/,  then
I run command "git clone --bare my_repo" to generate a bared
repository my_repo.git. But there's no update in my_repo.git/hooks.

Do you know why ?

Thanks,
Emily
