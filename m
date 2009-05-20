From: Avery Pennarun <apenwarr@gmail.com>
Subject: Quick way to clone exactly one branch
Date: Wed, 20 May 2009 16:45:44 -0400
Message-ID: <32541b130905201345h6daa84e8hb937e1e46456b3c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 20 22:46:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6sg0-0007LY-62
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 22:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755509AbZETUqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2009 16:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754948AbZETUqD
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 16:46:03 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:44194 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbZETUqD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 16:46:03 -0400
Received: by gxk10 with SMTP id 10so1241540gxk.13
        for <git@vger.kernel.org>; Wed, 20 May 2009 13:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type:content-transfer-encoding;
        bh=5HWAKFqDMtdhU2F0Rg646+enok+OpOb/Y3XgM3fy3BA=;
        b=lhaYw/ciwJlKm3ra0eDBpQewUQtjzFJXuA19px9FFKWCWR4dDvS+aDDPNbCITZT+Fp
         4/X8lfKloBkzWVwNQ8eNnS7R00oRB6hKB7H70Kn7LBN4H7DqPDFIBpTu/j+fP9WlrTBD
         UH2a4WYogfPOt+189lBJO/V7CGfrebczsL09I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=gQtG44C32m8PBq2v0/hdKiTVDitNshv3XEo6Jn4ZgoYmWYnqOV+zqsTvj6oYAmvk1A
         SkqOdKDVqUBZYDx1+YP/3Ma4X9H3WQo9PVhxrbCv3GXpyfHo8RzIj/z73IF3yV6ulaI/
         gOXlieZrqsZ1XRZRaXbwx1oGgyIQRVtVw8gIw=
Received: by 10.151.6.8 with SMTP id j8mr3393718ybi.285.1242852364084; Wed, 20 
	May 2009 13:46:04 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119632>

Hi all,

Is there a quick alternative to the following?

   mkdir myproj
   cd myproj
   git init
   git fetch git://whatever master
   git checkout -b master FETCH_HEAD

Basically, the above is a lot like 'git clone' but only clones the
'master' branch.  For really big projects with lots of junk in other
branches, the above can save a lot of bandwidth.

Also, if I were using git clone, I would often use --reference above.
I'm kind of afraid of explaining to a newbie that they should add an
entry to .git/objects/info/alternates after step 3.

Am I missing something obvious?

Have fun,

Avery
