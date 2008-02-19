From: "Anatoly Yakovenko" <aeyakovenko@gmail.com>
Subject: cant get git to work over http
Date: Mon, 18 Feb 2008 16:49:33 -0800
Message-ID: <e26d18e40802181649l3c03df82l4eb91c88bec47bf4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 19 01:50:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRGgT-0003NI-Py
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 01:50:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbYBSAtf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 19:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbYBSAte
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 19:49:34 -0500
Received: from wa-out-1112.google.com ([209.85.146.182]:33776 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020AbYBSAte (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 19:49:34 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3101857wah.23
        for <git@vger.kernel.org>; Mon, 18 Feb 2008 16:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=j1VnSi5k1ZsfnPATalLkwU67V7fiP5fU6Vy7M9OawUc=;
        b=HrmT8vwhR5s2fF4e2O/4YEmVErATRbuqluIbeAroKv5dmBCUzZPvWWLShaioHyVbUSQXJg8nRS2ZQu9f6NQNm3Mf+nDTV7hJmuTAuJpm0tY4E3D8vArImM5/PrfMFqJkmvgfbj0cNoFDermkiTudug+5o0XdczO+3zwNu6PILcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qhdU/n3hCg7G5dBN0/ZkNanF7bWewCfypP9nEV3Ox8cLHbtw4qfVeAKdgBDbHyB98tVFUmmVuG3pFwGpNGdFJ5DkOqebm+lhGSTyhXSzr79jn6tAu7nBCAe8VtgYBkZVRLOzKR+gKIH0iraLW5UkXzeFrs9f3iwagXEaGvsLERk=
Received: by 10.114.193.1 with SMTP id q1mr1425089waf.75.1203382173121;
        Mon, 18 Feb 2008 16:49:33 -0800 (PST)
Received: by 10.114.167.5 with HTTP; Mon, 18 Feb 2008 16:49:33 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74362>

so this is as fun as pulling teeth

i have been following this guide,
http://www.kernel.org/pub/software/scm/git/docs/howto/setup-git-server-over-http.txt

but no matter what i do, when i try to do the initial push, git just
hangs without any messages.  I have nothing in my apache server error
log, but i have this in the accesslog:

*.*.*.*- foobar [18/Feb/2008:16:40:12 -0800] "PROPFIND /git/repo
HTTP/1.1" 301 320

is there any way to get more verbose output out of git?
