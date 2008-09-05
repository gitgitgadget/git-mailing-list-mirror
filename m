From: "Kevin Williams" <kevwil@gmail.com>
Subject: git-p4 and changing p4 depot path
Date: Fri, 5 Sep 2008 10:47:25 -0600
Message-ID: <683a886f0809050947k3b461495u459607dccf891698@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 05 18:48:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbeUC-0006TY-F9
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 18:48:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754335AbYIEQrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2008 12:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752714AbYIEQrb
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 12:47:31 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:18095 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909AbYIEQr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2008 12:47:27 -0400
Received: by ey-out-2122.google.com with SMTP id 6so222742eyi.37
        for <git@vger.kernel.org>; Fri, 05 Sep 2008 09:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=gwHSvtpbW4vZxg0MYQSki2YeIl8ZHY/u5a4aYIvQBHg=;
        b=ilO8kgpZ760g1srRx4fCf2j9HYC0lPd+gwy0J3SQYtqZQd0tb79PD15tR0eC+JCRFJ
         akn8Lk+ZW3Cuc0a4PK6gFz+n24n0A8jxVYdHQoMcxfE9YZuEAnnTLusjlxvmz84/dYLR
         eyOiu/77aR5rDLdF8asnOcrg3IZCpG5MNLmis=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=TN1p/vIR8JrgN9TWjDaOwaZwhhbcSSFiqK9LnyJbzCWa18UrT1eF0J1SvDzM/c0MA/
         QJqyP2FjPga8+MSzEeMesufOILvy7EQRjFwwfY/jtnz9c+n5DOyXf7cRusLXhHVbjuDD
         oiseh6/UGXUGCNf2u292MVVyZA+8MzMAQDoHQ=
Received: by 10.210.61.19 with SMTP id j19mr13989839eba.88.1220633245814;
        Fri, 05 Sep 2008 09:47:25 -0700 (PDT)
Received: by 10.210.73.11 with HTTP; Fri, 5 Sep 2008 09:47:25 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95023>

I've got some code I've been working on in a local git repository that
I cloned from Perforce using git-p4. Now, I need to commit my changes
to a *different depot path* within Perforce. Since the p4 depot path
is stored in the logs rather than config, and logs are immutable
because commits are immutable, it seems I cannot do this. Is there any
way to do this? Why isn't the depot path stored in config? Please
help!

-- 
Cheers,

Kevin Williams
http://kevwil.com/
