From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Any way to "flatten" a series of changes in git
Date: Thu, 22 Oct 2009 21:03:44 +0100
Message-ID: <26ae428a0910221303n493fb7s701269d694110685@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 22 22:04:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N13tG-0001ci-Mp
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 22:04:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756593AbZJVUDu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 16:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756522AbZJVUDt
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 16:03:49 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:36943 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755448AbZJVUDl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 16:03:41 -0400
Received: by ewy3 with SMTP id 3so994586ewy.17
        for <git@vger.kernel.org>; Thu, 22 Oct 2009 13:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=mU6pgWcgWT36NFAE4kmFVV8Bue8GPyjEm6r6z5y6NOY=;
        b=jle8SMR54h3XGjJfVKnTjhl3VIlc2HaOQNQVlJGm7Ok38WcszVl23/L/j4/k+4kU0w
         A4wg2aatoTmjtvJl91ww0ZWs6yKkxN0ZS9H7Qp2N9awfhlHQ0sWO5qGLsdBrs8gihnmu
         6jSshbNZzv1MeGX7gaSUx+M//p1BHELsCGmDo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=Nsr5KNlcxQrJTNOIewdqxhseCS8FbbzSey0ooVRULnmo4n+MmtniTSfSLUo0jZE4/z
         D2A6pXYj6ZxNePoNCVASJim5YyJSge/WClervQDQx9WuN3gDvugIP7NoMeyFpJIgIy61
         UZTOiciZ4HV0EDHmygkFPietgfbLgAwqnkyE4=
Received: by 10.216.91.69 with SMTP id g47mr3643105wef.167.1256241824799; Thu, 
	22 Oct 2009 13:03:44 -0700 (PDT)
X-Google-Sender-Auth: 6200dbf7848aeed0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131051>

Hello,

I have a branch with a whole series of commits. I want to export this
work to be customer (to their svn repo if that has any bearing on it).
All the stuff in the history is irrelevant to my customer ("committing
now, going to bed" etc.) so I'd like to create a new branch that only
has one commit.. the end point with a new message. Is this possible?

Thanks again!
