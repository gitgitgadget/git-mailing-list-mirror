From: "Francis Moreau" <francis.moro@gmail.com>
Subject: How to create a branch without any links to the others branches
Date: Fri, 29 Aug 2008 10:27:37 +0200
Message-ID: <38b2ab8a0808290127o32621d09vac07e7811e6e8139@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 29 10:28:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYzLZ-0005RU-LV
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 10:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753140AbYH2I1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 04:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752999AbYH2I1l
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 04:27:41 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:10749 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752732AbYH2I1k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 04:27:40 -0400
Received: by ug-out-1314.google.com with SMTP id c2so1292780ugf.37
        for <git@vger.kernel.org>; Fri, 29 Aug 2008 01:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=bjs8sQQDalLClxS0njMlTFdoz21F1bUw5Ws6PILIwTs=;
        b=UFhkpxT2qcHknXMCaMedyXApCb+q2mHrnmNVngvGA0IkPmYJcwsEz8InE6B0RbNE/Z
         otj9Oo9+ARXOmpFdOGmAK8JHr487y4hCA6cibhY5wF4wTaRqi29lHeVVkoJAFn7HPwSx
         d9xt6sZOSZLNi+UVBpsi5RnG3Yci+o3ZPX+Lg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=Cisq9HN47j5qUK/w9IRcfhUAxdSdHz2VbOHUHQivvoEhFl2w/l6EwPxRkpBGqJhPWE
         1yjgL0RFGs1rK/MBklWdv0MTCVuy4sO1GrWL+7g3zbbbnWXzdpPdd7Y+fMZPSGNnm+x2
         OOiwk78t26OnhznQJZQrExwd23wXtBUZtR2yQ=
Received: by 10.66.236.16 with SMTP id j16mr4326910ugh.31.1219998457917;
        Fri, 29 Aug 2008 01:27:37 -0700 (PDT)
Received: by 10.67.22.17 with HTTP; Fri, 29 Aug 2008 01:27:37 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I'm wondering how such branches are created in a repository.

For example, how todo, man and html branches from the git repository
have been created ?

Looking at git-branch man, a "start-point:" must be specified if not the
current branch is assumed.

The only solution I'm seeing is to create a new repository with these
'unrelated' branches and pull them from the other repository.

Is this correct ?

Thanks
-- 
Francis
