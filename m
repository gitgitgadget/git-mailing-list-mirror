From: Howard Miller <howard@e-learndesign.co.uk>
Subject: How do I push all remote branches to a new/different remote?
Date: Wed, 11 May 2011 10:55:15 +0100
Message-ID: <BANLkTi=EtRPcjaeCRNgLQ39JsqzS=_69hA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 18:40:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKCSA-0007lY-Cc
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 18:40:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755892Ab1EKQjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2011 12:39:00 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:48946 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756710Ab1EKQi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2011 12:38:56 -0400
Received: by gxk21 with SMTP id 21so223610gxk.19
        for <git@vger.kernel.org>; Wed, 11 May 2011 09:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:date:x-google-sender-auth
         :message-id:subject:from:to:content-type;
        bh=648pKXS8eHfv4TRs8PNMJBIMpJN4w07OJj8HK9I2Tt0=;
        b=rObFFrwpI+MvS0KYZ5aC32/haDgJ5M2QdBZdgvfnpGspfUmB6OdOif+arHmKTKLjn3
         j61m+j4PwZZNlcApUPm2bQGDXFtVbCEWEh+2Vfdqp4c574O8MohY9jtmzClVXFkZxUav
         tOp1Z4lXtLJmbYKfLig9k5rduUusEf0EHRigg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=KKnjJhLyCks3/imUV/qM2uDZGA8nD1aYA/B+Rmc/otiTrOyU/rOKzlF8+tcIZpzYXW
         /Ypj0D/wuWRcAOXMDv2oWgQn8Z+AhbZR9f7UsO6/XfhTGubZTUh3wEe78sJRhlNpvOle
         75TvV8d9tzjgDNY4CskytiJWsdro5Z2XBgeQw=
Received: by 10.91.178.2 with SMTP id f2mr4400599agp.74.1305107715558; Wed, 11
 May 2011 02:55:15 -0700 (PDT)
Received: by 10.90.242.2 with HTTP; Wed, 11 May 2011 02:55:15 -0700 (PDT)
X-Google-Sender-Auth: rWvCQGwywqJ-ViBce7ak8HoZ6ys
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173412>

I simply want to move an existing repository 'as is' from one place to
another (the another being github fwiw). I would like to keep all the
branch information intact.

That is,

git clone ...existing remote repo...
cd ..
git remote add ...new remote repo..
git push ...you tell me..

So, there are *no* local branches to bother about, but I have hundreds
of remote ones. I can't spot a way to do this.
