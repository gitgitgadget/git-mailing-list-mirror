From: "Doug Reiland" <dreiland@gmail.com>
Subject: can you push from a bare repository??
Date: Fri, 27 Jun 2008 13:58:16 -0400
Message-ID: <6844644e0806271058r738e300fxf10f50b4ad29a93c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 27 19:59:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCIE7-00073P-Fk
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 19:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754850AbYF0R6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 13:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754416AbYF0R6T
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 13:58:19 -0400
Received: from rv-out-0506.google.com ([209.85.198.235]:43268 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754572AbYF0R6S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 13:58:18 -0400
Received: by rv-out-0506.google.com with SMTP id k40so672546rvb.1
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 10:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=oWXBlvQO87Ye6QPy4fqVQgowx9d+SRqtgg2dzexauxI=;
        b=DPD/4giK6wwUXT5ngt5uA4Mz6GyMOc2WPZyrrl5H4u+UiP/f1HTcd50TEGho8TIGYL
         DFRMM/Kq3YibRdLBfQKHSKCcpspYkn6GBlIefmPaAV7u90WnlWWD4qmb2mwo60f2YH63
         XpRb/LfoFnkC1RV6XrP9IkFmRgUJ3zew4cmGE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=GwqPPkc70iQePu6Vu/xcARryQ8oY0va59Gs5BE4oPPtxpJDCe6VQ4y96TnLRBjSZ5e
         SnQq/irQvDU4dj1IKbpBCck3kchhMppUhIZggOrBGG85sPwUJ3ZL9J4OB91VZQ5VYf6s
         5o48HtnjcTwXvkYl3dYyalth7sWHYDyLIvKwQ=
Received: by 10.141.75.17 with SMTP id c17mr952463rvl.212.1214589496930;
        Fri, 27 Jun 2008 10:58:16 -0700 (PDT)
Received: by 10.140.142.5 with HTTP; Fri, 27 Jun 2008 10:58:16 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86614>

I have a main repository called main
I create a bare clone from main call bare_clone
I create clone from bare_clone called work_repository_1

I do my work in work_repository_1, commit, and push changes to bare_clone

How to a push the changes in bare_clone into main??

thanks in advance,
Doug
