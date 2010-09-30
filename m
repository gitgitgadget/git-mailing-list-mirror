From: Geoff Russell <geoffrey.russell@gmail.com>
Subject: wierd git show syntax
Date: Thu, 30 Sep 2010 14:32:48 +0930
Message-ID: <AANLkTi=Zz-1dSC0imJ3NZXWcdvhXWXt-Kk94zwKe8+6Y@mail.gmail.com>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 30 07:03:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1BIG-0001on-VI
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 07:02:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741Ab0I3FCv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 01:02:51 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60242 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577Ab0I3FCu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 01:02:50 -0400
Received: by wwb39 with SMTP id 39so628310wwb.1
        for <git@vger.kernel.org>; Wed, 29 Sep 2010 22:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to:date
         :message-id:subject:from:to:content-type;
        bh=xVZYFdPW2PjsdKbMymnGVOlGPANuBRjv7X1D6eRKlcU=;
        b=epoO/ZDWTOHijoXT2InjsHvs+h3J+voc9SWwBqkJ7s+1voq1xWFq/VrWYCLq0o6z+q
         9pRoDCVSTo6LgQmNs3dI20xm5MJxDyUEywl3y/Rv/vFU8+OmuBeGluJhELTDmI4zEubU
         QfvAz2oBJvtSzJXr+JpKX8wOBoNcmpusIwqnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:date:message-id:subject:from:to:content-type;
        b=aKbcSEHXsuE8xznwBndnFZl/20mhhDC0f0/j2QVNI3irloXsDJ6cqBP5Gz+EhlF+5Q
         PfeWjhsQE7Mna9uTO/1xNNwIDSLCJUzG8duPIqAsqvVGi0Mp8eFXRXnhV5RX8F6ITkDD
         N4Isfopx1ul6uBTMB8VXUTpbC0E7ImKi2kfkQ=
Received: by 10.216.54.9 with SMTP id h9mr121177wec.34.1285822968479; Wed, 29
 Sep 2010 22:02:48 -0700 (PDT)
Received: by 10.216.16.130 with HTTP; Wed, 29 Sep 2010 22:02:48 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157630>

Hi,

$ git show XXXX:data/path/object.c

Gives me what I want, a cat of the objects contents. However
for some files I get a message about ambiguous argument telling me to
separate paths from revisions with '--'. Okay so I try that:

$ git show -- XXXX:data/path/object.c

But it gives me nothing

$ git show XXXX -- data/path/object.c

Gives me a git diff output for the object.


This is all with git 1.6.2.3

What's happening here? Why aren't all these equivalent?


Cheers,
Geoff Russell
