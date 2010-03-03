From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Latest master failing t7401 submodule tests
Date: Wed, 03 Mar 2010 07:21:36 -0500
Message-ID: <4B8E5450.3040702@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 03 13:21:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmnaH-0003Ld-3Q
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 13:21:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531Ab0CCMVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 07:21:44 -0500
Received: from mail-gx0-f227.google.com ([209.85.217.227]:33830 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821Ab0CCMVn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 07:21:43 -0500
Received: by gxk27 with SMTP id 27so559157gxk.1
        for <git@vger.kernel.org>; Wed, 03 Mar 2010 04:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:subject:content-type:content-transfer-encoding;
        bh=F6v5V72vLLMkf5ZF0DOA1EgtP/ZPgFWjKU/iVMvXAKk=;
        b=mLtSpv/GpcBEE9aJYG/qcJq0pzrbU5hZFgJRk3Tlmx5wt+hZ87RsAzOeoiXKWiC+2F
         tdG93XQI9RiajL80iNnC38Jbw2gGeBrRlnjlIpavvdQkZgQQJXW25DuxKxTLn86MSTCl
         oNwsh4T6Oq2ZeUmK4D8eGmjrBcCAb3gp72Tko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        b=l/9BBe+1uuR3BOMPHvsRrwjjJ6yXxt/a3O5VHKuKt4NI1oxFN3Z1eyp4DzT6f8Lwfm
         KsZ15Uo1zbbPmaqqeNnkSzoliRKl3UCASs+0oTBvgyjgby3sNzktMVUV4yAuAGagvf6l
         gGVrj/vQl1uvwYKCK5kX3YreIxxRdKP0Mwk08=
Received: by 10.101.206.22 with SMTP id i22mr1979400anq.36.1267618902725;
        Wed, 03 Mar 2010 04:21:42 -0800 (PST)
Received: from ?10.0.0.6? (c-71-199-240-201.hsd1.fl.comcast.net [71.199.240.201])
        by mx.google.com with ESMTPS id 14sm3974090gxk.3.2010.03.03.04.21.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Mar 2010 04:21:42 -0800 (PST)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141449>

13 to the 18 tests in t7401 submodule test jig are failing with the 
latest master this morning.
