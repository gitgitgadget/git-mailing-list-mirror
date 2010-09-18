From: Wes James <comptekki@gmail.com>
Subject: error running git-completion.bash on snow leo
Date: Fri, 17 Sep 2010 20:29:09 -0600
Message-ID: <AANLkTi=VtE9OPKx0+HobC7hcOjeNNMXBG2aQ8vj1FwR1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 18 04:29:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwnBB-0005SC-8Y
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 04:29:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753732Ab0IRC3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Sep 2010 22:29:11 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:36614 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837Ab0IRC3K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Sep 2010 22:29:10 -0400
Received: by vws3 with SMTP id 3so1960376vws.19
        for <git@vger.kernel.org>; Fri, 17 Sep 2010 19:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=6JOZmjuTJqt+Swt2JGMaYh+J+0dTp57KJ4h3WRMA0So=;
        b=pIdovy6dNTmxsiT39BV+WGOvrFpZ68EbT3qxLLXZ4yT6lusK4p7y/YbNCB8pcrEWyT
         DkMNWka2uvX+ys0K5ba1tB/ik8BDi2J8GYU/LCgudSVBUrBI21NeVvLiklYnf+T/fidr
         Q5ATiyXmuHfbLg+lpuylfFboRmkACz2kkD4wY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=u1M9dkuc88e/77PrgYK+XSDZp3kYfafdSYbUM4A9NYxMUPgJzBnrluMtf3MMNxoEgV
         iZkJjwTL+AZJrGTO8Z5wHOZ1srJU5VqjPmZuaPB9XiH+9aMLDFndFmkOTwErFzNS1Frf
         95WwEyS+7gvE5JTUGncGma1zviAfBdoDaRSOw=
Received: by 10.220.121.165 with SMTP id h37mr21800vcr.148.1284776949447; Fri,
 17 Sep 2010 19:29:09 -0700 (PDT)
Received: by 10.220.64.131 with HTTP; Fri, 17 Sep 2010 19:29:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156422>

When I

source git-completion.bash

I get:

-bash: git-completion.bash: line 127: syntax error near unexpected token `done'
-bash: git-completion.bash: line 127: `	done < <(git config -z
--get-regexp '^(svn-remote\..*\.url|bash\.showupstream)$' 2>/dev/null
| tr '\0\n' '\n ')'

anyone know why?

latest os x snow leopard.

-wes
