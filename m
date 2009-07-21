From: Mathew Davies <thepixeldeveloper@googlemail.com>
Subject: Git Layout Opinion
Date: Tue, 21 Jul 2009 16:35:21 +0100
Message-ID: <16b7ceee0907210835v6e175235l637346d23afd5996@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 21 17:36:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTHO7-0006GV-5S
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 17:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755154AbZGUPf1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 11:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754328AbZGUPf0
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 11:35:26 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:41515 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753257AbZGUPfY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 11:35:24 -0400
Received: by fxm18 with SMTP id 18so2682828fxm.37
        for <git@vger.kernel.org>; Tue, 21 Jul 2009 08:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=e4hRj2S6w7y23FD5fjucGWt7c4NDD2QAwbv3E7lrGHY=;
        b=eeAbipFdUt+FnzgOG0fj8l2LyioAl1EersBjI044oXeAYvIILwlxebahRDxrlSrNFg
         tDUMblNmQAmVmDZVub1lJHE0aeJmXS03sK+9JYt8dBgkMxS7rAeQuwWr/BUAuOxGR3Ti
         /alTCGSCqODeUnQddeF8CTLHeG9BTeFGmqmHA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=rPgXBdobMV0/vRwQWOk3eum7+WwyqZ4vtw/O5Z17FxqHZbYooK07QppjJSRW7rblhm
         IxfEbWSxphh+bL2HcYkEW0zAMGXJ0hdX2gl5Y9SbHkbburLL+1uACq0ts0sWvY3QR/mv
         l5wxrnxOoxCBz8Y0/dIPXCbzbiL0DP3qYDtm8=
Received: by 10.204.66.135 with SMTP id n7mr5574006bki.155.1248190521678; Tue, 
	21 Jul 2009 08:35:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123669>

Hi,

I'm working out a new layout for a project and need some help with an issue.

http://www.imgdash.com/uploads/3aff0_Untitled-1.jpg

The bare repository is going to be public so the config files need to
be ignored. The problem is, I need the config files in the staging
environment without manually putting them there. Is there a good
method for sorting this out?

Kind Regards,
-Mathew Davies.
