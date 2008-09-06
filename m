From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Alternates and push
Date: Sat, 6 Sep 2008 08:42:50 -0400
Message-ID: <9e4733910809060542s5ede6d6m5bdb894c958ea8b7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 06 14:44:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kbx92-0002dT-7Y
	for gcvg-git-2@gmane.org; Sat, 06 Sep 2008 14:44:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbYIFMmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2008 08:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbYIFMmw
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Sep 2008 08:42:52 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:59136 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbYIFMmw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2008 08:42:52 -0400
Received: by py-out-1112.google.com with SMTP id p76so467173pyb.10
        for <git@vger.kernel.org>; Sat, 06 Sep 2008 05:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=Jzr6dPgZ8FEQk+k9UYdEvxJHReLdvCRwf6UjSv/OMM8=;
        b=WAd0NhCmVF/OLRjh6adZSDvNUOJzJ4X3fr9nIc0VQ/WsUkba4pFyTgRhqaCqnu5YrI
         GbKuVCQMjGEkc85y9LFP/Bo2/+fol5hMNBoegOjxZk8dzmFZT1iCdTedtm+nQ57880o/
         qApxK09m5flTBPzYYZX9jq1MKJZPWZMBm79YU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=CF9Moaid323KPuklw/P+CtplGIZ68OTjOVRfB6EJtOuQLaK0wEOmFJAqxv/aU55tDv
         XHzMkIDPHmAzWweJSnZTl8+7NEhFtHHhWMWv2EOA3/zsPzCEsVoqrVlTaKLV1v1R+QvR
         I0RSCfwAd/k84g+xloOFECss8uegKqB8VQ1zw=
Received: by 10.64.47.16 with SMTP id u16mr26073484qbu.73.1220704970952;
        Sat, 06 Sep 2008 05:42:50 -0700 (PDT)
Received: by 10.64.178.13 with HTTP; Sat, 6 Sep 2008 05:42:50 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95072>

At github my repo, digispeaker, has an alternate pointing to github's
local copy of Linus' tree. I ignored my tree for a month and then
pushed to it including 200MB of objects from Linus' tree. These 200MB
of objects were pushed up to the server, but these objects were
already in the alternates repository.

What's supposed to happen? Is something broken in github's setup, or
does pushing not take into account alternates?

-- 
Jon Smirl
jonsmirl@gmail.com
