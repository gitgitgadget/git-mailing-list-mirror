From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Possible BUG in 'git log -z' last commit is not '\0' terminated
Date: Fri, 22 Jun 2007 21:27:16 +0200
Message-ID: <e5bfff550706221227x4b785698taabfa7572bf8204b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 22 21:27:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1oms-0003Q5-UD
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 21:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbXFVT1R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jun 2007 15:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbXFVT1R
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jun 2007 15:27:17 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:55913 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769AbXFVT1R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2007 15:27:17 -0400
Received: by wa-out-1112.google.com with SMTP id v27so856552wah
        for <git@vger.kernel.org>; Fri, 22 Jun 2007 12:27:16 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hHRN0hk3o6ZUsGXwUfcd4zrQewrZlUbmoGz8Beo2TXnMjZNzto2wxwSjf4mkta2kZQFOfRMdCSxUxBtF/NzdMzFz8NBGLOBIWrEW4A9bkMy5hxw5kCqK4S70rWRbJS86r/H08lezvBZStYYdj7bu5Byp+cft3nL3AlSJ2FMPlkU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=sbHDxL+hGCSfblIIpT0bXW3vMxtUCoAf+EOuIPr3b05/dPtFXu2S0DNbPjbOfJ+dMCINnFy+VXaAjKnmNqHUGLgiNUCruiynyIjQyUXrHAhxnkqItnEwGlRPEjlAhltYGVHBI2dkRFj+uhbVpETPeft7tco5ESo+xVLNuZkG0c8=
Received: by 10.114.148.1 with SMTP id v1mr3260779wad.1182540436236;
        Fri, 22 Jun 2007 12:27:16 -0700 (PDT)
Received: by 10.114.56.6 with HTTP; Fri, 22 Jun 2007 12:27:16 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50707>

It seems '-z' option is not honoured by the last revision printed that
is just '\n' terminated.

Thanks
Marco
