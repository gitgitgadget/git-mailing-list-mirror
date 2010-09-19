From: Knittl <knittl89@googlemail.com>
Subject: [PATCH] Improvements to `git checkout -h`
Date: Sun, 19 Sep 2010 21:41:25 +0200
Message-ID: <AANLkTikra1iE5JpXvvPnNcwE=XEDF6B=ubCteEi77dqX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 19 21:41:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxPlp-0003zZ-7z
	for gcvg-git-2@lo.gmane.org; Sun, 19 Sep 2010 21:41:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753583Ab0ISTlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Sep 2010 15:41:47 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:44087 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753132Ab0ISTlq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Sep 2010 15:41:46 -0400
Received: by vws3 with SMTP id 3so2782666vws.19
        for <git@vger.kernel.org>; Sun, 19 Sep 2010 12:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=F+cNmk9ULlplr8Bjsa3mrht8i9PtT+4XGvmCxK/PIB4=;
        b=esKW0QxQ1UhTDJqkem2BJg4NwBb1D8IaPbptcEJ/eMWlHPVivuIZ7qXE4xe9f2ozeR
         Lh0v/kZ+JZYh2LnyMMO1gA29s1NHlRSy8B6mf2vLjm1kywAPvlNb/TWwahC6xGpctrFZ
         Q4NsT5fAGOqKJSfEnQT5OO6/K92F2+oL2s2po=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=LWQxmIP00hcU0Vw7or2hCHvGu9+WiUUbLm67WCkk2Kf0kZGKqE2xlKHqqa+1B2143g
         u9D27mDrMGx7sSuQLrNtbOwtr/zqYyf9epPHPvW6WLc0+u5Qccyw57jTEMQm42aJ4cWc
         mOsSGp3CjZBzoTBjLLdOLSO/qaxGOeLr1k66M=
Received: by 10.220.63.141 with SMTP id b13mr64977vci.114.1284925305107; Sun,
 19 Sep 2010 12:41:45 -0700 (PDT)
Received: by 10.220.200.129 with HTTP; Sun, 19 Sep 2010 12:41:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156513>

print more information in `git checkout -h` to stop people from
complaining about git's help ;)

http://repo.or.cz/w/git/dkf.git/commitdiff/95209979cb1a0de071a3cceac593fbb40235b926

cheers, daniel

-- 
typed with http://neo-layout.org
myFtPhp -- visit http://myftphp.sf.net -- v. 0.4.7 released!
