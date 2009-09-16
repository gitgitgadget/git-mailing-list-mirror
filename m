From: Martin Larsson <martin.liste.larsson@gmail.com>
Subject: git-svn-problem: Unnecessary  downloading entire branch?
Date: Wed, 16 Sep 2009 13:53:59 +0200
Message-ID: <1253102039.6509.143.camel@martin>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 16 13:54:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mnt5L-0005Fe-TK
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 13:54:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755884AbZIPLx7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 07:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753895AbZIPLx7
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 07:53:59 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:48974 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752328AbZIPLx6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 07:53:58 -0400
Received: by ey-out-2122.google.com with SMTP id 25so968010eya.19
        for <git@vger.kernel.org>; Wed, 16 Sep 2009 04:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=3Zkwcaf/O6E9uB9dPX3p0BGfxMmy40DKsWYHfpnhtis=;
        b=q1UrxrrcLLIiWWp7VzbqidPiF6UU0FdzskIXlrOJZcmAzot+Yc+PM8nHz3MqFCdlmg
         vvx+2qTEMxKvaB7/N0rBtkgzezgFnbkv46wx/umm6dMpm79rsnxkLmRc61uy2cVtf8At
         62vdXjN4OkuPnGzIiuc2IE67q4a71/HBAZNSU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=wPxgeRT3FFaQRSNIiSMS07hL7daQA2XlimwX5mVt6ZxgZBwT4GD2EGL7/5f7q1uZOC
         vxw+2UTO1lP1WKQfN2t5zmsjFHqnnkTWbqpO306Em2nXKUr3jyHbstqonbeFFt11iVuh
         /4pHe/LuEV+NPyI/HTAp4XvgABUTnv8xByiBs=
Received: by 10.216.12.148 with SMTP id 20mr2032608wez.17.1253102041053;
        Wed, 16 Sep 2009 04:54:01 -0700 (PDT)
Received: from ?172.16.10.145? ([82.134.20.254])
        by mx.google.com with ESMTPS id 7sm1939571eyg.2.2009.09.16.04.54.00
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 16 Sep 2009 04:54:00 -0700 (PDT)
X-Mailer: Evolution 2.26.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128646>

I have a local git-copy of the company svn-repository. The git-copy is
up-to-date (git svn fetch). I then add a new branch in the
svn-repository (svn cp http://.../trunk http://...branches/JIRA-4444).
When I then do 'git svn fetch' again, it pulls all the files from the
svn-repository. 

I was expecting it to only pull the fact that a new branch was made
(taking milliseconds), not all the files in the branch (taking more than
half an hour to complete). Why does it need to transfer all the files?

I did have problems getting the original svn-repository. It took several
days and stopped several times in the process. Each time it stopped, I
just issued 'git svn fetch' again and it seemed to continue. Could this
be related? How could I make a better copy?

M.
