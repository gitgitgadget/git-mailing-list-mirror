From: Rustom Mody <rustompmody@gmail.com>
Subject: pulling git -- version confusion
Date: Mon, 9 Nov 2009 11:44:24 +0530
Message-ID: <f46c52560911082214x81ae8beya139a8bcb3cbcf2a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 09 07:14:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7NWK-000497-Ar
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 07:14:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbZKIGOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 01:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbZKIGOT
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 01:14:19 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:58751 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbZKIGOT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 01:14:19 -0500
Received: by pwi3 with SMTP id 3so438365pwi.21
        for <git@vger.kernel.org>; Sun, 08 Nov 2009 22:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=cX4GmRsUq+EU3BPs7Rb0g1ubYiEotLJfilB5WbHya54=;
        b=cMAgXpBhMfkYF3rBCopbLpzJiX8ck8geAxEIYNyb5iKcw0q41IZESUG7OYLnh3DtJH
         KqRY8QMuEThotID4CX3JSTDcOzS2YIJxeTI1TfOItZc8PZ9CGSE/F/fNbrZoRO5m/fLl
         rsVMA1agfKdp3b+ke7hkJO709WRhLT72+bRls=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=l8wNKgbV7mD6luLLMhEjpGrY/D9pfGiEzICfybKGlzz4HgNqRM8bjjlFZYC3nScw9t
         kXQhqbeOdb6NWfOBcEV/cTF6n4D9NsMa6nprGmsc0csRidarPF9W7HlDvjQ5KR6qNJzA
         Cuz22sNCzQeUzXqXWVsa8CcIpHn13oBQCP4e4=
Received: by 10.114.68.14 with SMTP id q14mr12946883waa.103.1257747264228; 
	Sun, 08 Nov 2009 22:14:24 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132439>

I did a git pull today

When I compile it
git  --version gives
git version 1.6.3.3.334.g916e1

Whereas latest stable shown on http://git-scm.com/
is 1.6.5.2.


Note:

git branch shows a star before master

git tag contains v1.6.5.2 as well as v1.6.3.3

When I checkout branch next
git version becomes  1.6.0.rc1.194.g9e4e

Can someone explain whats happening or am I missing something basic?
