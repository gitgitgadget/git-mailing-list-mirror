From: "Nikolai Weibull" <now@bitwi.se>
Subject: git-check-ref-format returns 1 for valid branch names
Date: Thu, 22 Mar 2007 21:24:59 +0100
Message-ID: <dbfc82860703221324k48690833g6731ef75562839d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 22 21:25:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUTqb-0008MY-GA
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 21:25:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934227AbXCVUZF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 16:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934231AbXCVUZF
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 16:25:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:59409 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934228AbXCVUZC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 16:25:02 -0400
Received: by ug-out-1314.google.com with SMTP id 44so808773uga
        for <git@vger.kernel.org>; Thu, 22 Mar 2007 13:25:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=IY6GWlnvQ978phcjDp6Kxh/cUWjQjose0Z+jixhqVMaHfsXF7AP3HMyosWn5BF9GQfVN3Lg3z13GLb+xFRAs3Wh8ZtWscbL1EDbmF4j7Wxr2RtVQIV4M8f8/nBx+nt4X2nMEON6QcX1/aLfjQaqhhr+NQglhh2l15moC51Ugmz4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=d3aYcs7jmAGYGBikHcIbaVB3pcJ68z2jznEIPKKBX62arbu38C59FJKxXxzU2gwwEzHP4sSckTJMI3EGtMpo85av7mHFnjtOSAuSyzMBmmiAlR4h34iLBIynZ9mIQuazw+dM6fbDoatTPUf4pCal4IgjBlZ0McGl0StJ+NKr3IE=
Received: by 10.114.192.1 with SMTP id p1mr761176waf.1174595099412;
        Thu, 22 Mar 2007 13:24:59 -0700 (PDT)
Received: by 10.114.193.4 with HTTP; Thu, 22 Mar 2007 13:24:59 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 0c611c0d527ba360
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42876>

I'm obviously doing something wrong, but in git 1.5.0.4

% git check-ref-format abc
% echo $?
1

What am I missing here?

  nikolai
