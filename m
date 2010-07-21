From: Bryan Larsen <bryan.larsen@gmail.com>
Subject: Avery Pennarun's git-subtree?
Date: Wed, 21 Jul 2010 13:15:52 -0400
Message-ID: <4C472B48.8050101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 21 19:16:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Obcu1-0004Gs-8P
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 19:16:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753450Ab0GURQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jul 2010 13:16:11 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:60354 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675Ab0GURQI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jul 2010 13:16:08 -0400
Received: by gwj18 with SMTP id 18so3564536gwj.19
        for <git@vger.kernel.org>; Wed, 21 Jul 2010 10:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=O028mjieXFGQG/KQOlyFlUUXOYUgm/IopPbcupxTnPo=;
        b=kmkZ4oS0QW2CURGx9fD4VWkQbwsx5shXcy6kkejyQGmDiN563Y0nUS2Sg9oXcSbPEU
         din89yamGUrgHmHM6sW8JX2lOiFpynFUCXuNogWFT0Nyj/Lq8t3ima91kXgOKlSylWIE
         HqCp5Gpn/MITi4dxD60Wd9rKdpdlo0+qIby34=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=E8KMRGptixx6yYkPx2r8atrtgLYwA+0j5uhBzY/qyvUAGt8if2Nlx7qu8WlfyFnPSz
         icp00758QAfInVNj2A+OHoAI36ckEgx+/kFcu23Zwa251WKjkxSkqupHxBoGrnplShqP
         OR/Lyrjed+ViarDW50WTq5+jTmabRps+I1P9w=
Received: by 10.90.78.8 with SMTP id a8mr1418208agb.8.1279732560942;
        Wed, 21 Jul 2010 10:16:00 -0700 (PDT)
Received: from [172.50.10.17] ([72.1.195.8])
        by mx.google.com with ESMTPS id e8sm28945554ibb.8.2010.07.21.10.15.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 21 Jul 2010 10:15:59 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10) Gecko/20100528 Thunderbird/3.0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151408>

I've been using Avery Pennarun's git-subtree 
(http://github.com/apenwarr/git-subtree) for a while now and have been 
finding it very useful and problem-free.

Git submodules have been particularly problematic for me on a project 
which contains submodules which contain submodules.  git-subtree "just 
works", without any futzing.

We've also had problems with less git savvy users dropping patches 
because they've occurred inside of a module.

It would be really nice if git-subtree became an part of git.    Avery 
has submitted git-subtree in the past and has indicated a willingness to 
do so again if there was a good chance of acceptance.

Avery's announcment of v0.3 is also informative: 
http://kerneltrap.org/mailarchive/git/2010/2/4/22366

thank you,
Bryan
