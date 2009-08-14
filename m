From: David Reitter <david.reitter@gmail.com>
Subject: git config -> "fatal: bad config file"
Date: Fri, 14 Aug 2009 09:38:02 -0400
Message-ID: <A5CDBB91-E889-4849-953A-2C1DB4A04513@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1074)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 14 15:38:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbwz0-0007Jf-UZ
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 15:38:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756366AbZHNNiF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 09:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755594AbZHNNiF
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 09:38:05 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:35184 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755178AbZHNNiE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 09:38:04 -0400
Received: by qyk34 with SMTP id 34so1144917qyk.33
        for <git@vger.kernel.org>; Fri, 14 Aug 2009 06:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:content-type
         :content-transfer-encoding:subject:date:message-id:to:mime-version
         :x-mailer;
        bh=bOv37sCoabJ2eV9W2hVhjLUaosuZMV151yyG5eIZV0M=;
        b=ZuxVRf3WYrVvNF1xTLrtu8HX4YpFO1r6oBuVHQrqdx3v4SbjDGA3zIOZUQqyjRfliU
         rteeBJYKlvXWKw4sSVc4ZBjz0TPty8KLgRwNbTV7xJdy0dgrnGS94Ep0E25Czz1oirEG
         OfxxWejV9qr8XbTV4KBPCPRO57LqfEc4bhFV8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :to:mime-version:x-mailer;
        b=MWU2LfjAGstD0WWmy9sZjcMtq3rhg3epkEJbajvHZkGfgERfDMLYVolFulkQyut47G
         Yk9b3hRlTWacwn9yAvz9wok6Zbnn7RWjOnsoxTbjgF/ViukLtywQPKjXLJClyeOeRhd3
         viUC308og0qc/JpTNljxMBYSTg9lXfAoxtwJg=
Received: by 10.224.58.196 with SMTP id i4mr2253530qah.322.1250257084774;
        Fri, 14 Aug 2009 06:38:04 -0700 (PDT)
Received: from scarlett.psy.cmu.edu (SCARLETT.PSY.CMU.EDU [128.2.249.106])
        by mx.google.com with ESMTPS id 8sm3640455qwj.36.2009.08.14.06.38.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 Aug 2009 06:38:03 -0700 (PDT)
X-Mailer: Apple Mail (2.1074)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125925>

I made a mistake editing my config file using "git config -e".  This  
caused git commands to fail.

Trying to fix the problem, I did

git config -e
fatal: bad config file line 7 in .git/config

I think the refusal to edit a broken config file is not a good idea.   
It's easy to fix for me of course by editing .git/config directly, but  
git-config should probably not read the config file at all.

Thanks for your consideration.
