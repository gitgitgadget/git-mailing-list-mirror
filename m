From: Lea Wiemann <lewiemann@gmail.com>
Subject: [Bug] for-each-ref: %(object) and %(type) unimplemented
Date: Wed, 25 Jun 2008 17:01:01 +0200
Message-ID: <48625DAD.5040404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 25 17:02:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBWVc-0007iv-5a
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 17:02:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751995AbYFYPBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 11:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751953AbYFYPBK
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 11:01:10 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:56930 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628AbYFYPBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 11:01:09 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1141337ywe.1
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 08:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:subject:content-type:content-transfer-encoding:from;
        bh=EQcS7T9k30zfvZ6vpCKTBo0Nobwr+zna8MccqoVqkq0=;
        b=c6MEx34dBqxfWhWb1JIuY2+OM9WhBwvZ+9GB4AcAM9ojybpOjx1+Oa+Mcgthw3COYG
         winXNqGKRlIwwS4iUmH3tpjimc8qFio4GfVco0RXFOPTpMksJdgx4y3D0ae119Ph0O6R
         DfRypwUn+PA8rQNAPOJEafTQWuZmJQwcb3z8g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding:from;
        b=TpolG2N0PNDL3ZJJ86SBpJiYxe0/chwUpM4OWZABSt08sEHy8juZBli4dnJHM7PAKO
         CLcNt+P0oicDg8rwJ3Z9DgFijlRPu3s43mOkJRwH21X33rsoBWO5F+0Xa7M5K48jGHc8
         9YoKING0PChqoHcNpCU5LaLRFKCBCCxeDPToo=
Received: by 10.125.107.3 with SMTP id j3mr1810570mkm.90.1214406062883;
        Wed, 25 Jun 2008 08:01:02 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.201.65])
        by mx.google.com with ESMTPS id d13sm5235123fka.3.2008.06.25.08.01.01
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 25 Jun 2008 08:01:02 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86286>

Try the following on a repository with tag objects in it:

git for-each-ref --format='%(object)'
git for-each-ref --format='%(type)'

Each command prints only newlines.  The %(type) and %(object) options 
are not rejected with an error message (like "%(doesnotexist)"), but 
they don't seem to be implemented.  "%(tag)" works though.

Anyone care to implement the missing options?  Or should they rather be 
removed from the documentation?

-- Lea
