From: Jeff Enderwick <jeff.enderwick@gmail.com>
Subject: situation codes (e.g. #16) in unpack-trees.c
Date: Wed, 12 Aug 2009 14:05:06 -0700
Message-ID: <bb6059c00908121405t4f34c50eo532b928fa6d6f89c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 12 23:05:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbL0Z-0001Zu-Lu
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 23:05:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbZHLVFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 17:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbZHLVFH
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 17:05:07 -0400
Received: from mail-vw0-f172.google.com ([209.85.212.172]:60893 "EHLO
	mail-vw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855AbZHLVFG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 17:05:06 -0400
Received: by vws2 with SMTP id 2so289615vws.4
        for <git@vger.kernel.org>; Wed, 12 Aug 2009 14:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=h8iTDbn4SHAShcCdee4+tMuQshjzPjq/UFARGAAP9vc=;
        b=Zi9u0Q3ejrMRajbRZXud4wTGDXX7SfcLexi8YhbefHfJjMitq4SUG0FKZC/zGi4b+y
         ExoLgeZhOAnRC7p0NDYoTlcdmammqWo9m19LxlKIj3z/XHlAbEifywVR6tj3OqSfr7lf
         kMX9ItEB/MODe/scK8qW8/XRBS7stpyHj8zaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=ThaqjSCLMqS4Ie5rsMI5REiyW1xS804FWeDzbaJ5w6+ddPBkBJO3l4Faoxa3CAZ9MK
         QR1RSHsgOoT9RCj3LqAtOA3xFdKHE+DGj0oaatKv25UBXgFf7l28sHWnnXbVq//OUFb1
         iTrkfnofw7rlqHCG0wGcrT+uhv+j5NXhESoZM=
Received: by 10.220.71.197 with SMTP id i5mr563344vcj.30.1250111106385; Wed, 
	12 Aug 2009 14:05:06 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125747>

Newbie here. I'm trying to grok git's merge algorithms. Where are
those '#' codes written up (e.g. #16, #5ALT, etc)?
Is there a write-up anywhere on the merge logic?

TIA,
Jeff
