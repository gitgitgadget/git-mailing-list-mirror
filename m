From: Klas Lindberg <klas.lindberg@gmail.com>
Subject: Fetching SHA id's instead of named references?
Date: Mon, 6 Apr 2009 14:13:04 +0200
Message-ID: <33f4f4d70904060513k320fb6a0ya928c714dcd11e89@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Users List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 06 14:14:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqniv-0006iT-FW
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 14:14:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756336AbZDFMNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 08:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756165AbZDFMNJ
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 08:13:09 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:52604 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755505AbZDFMNI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 08:13:08 -0400
Received: by fxm2 with SMTP id 2so1851184fxm.37
        for <git@vger.kernel.org>; Mon, 06 Apr 2009 05:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=RDhfNCHPW2vN2i/PbvfBqBe0biiWcOprT1ZJpmuoLAc=;
        b=kqQphysTLoHHehRsKmEnJBPFdj5DRV9tblQWn0pe+y9ADPPJmtxwwrIHFaetoqh5Zh
         osJCbjzqOxX7pS6cfhPoFPngKVaQouwb86NYJbvD53/Sf+G+CWrgwWFFpWamHtO3jivk
         St5p8eON56f6pVrKbS+zvq6P9gQilFNrBGf30=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=IsofshiDqKfQxkBLOpyJbO2++KPhExr03jpjGywf2Y0QuaTil66tOh4NtIQdo9w+5P
         XL4vSQTKSIwPAtVBy/lqx90gD9z2QYE9E4+tT3xEoHgbTHGrAdYzopUd3m3egQdAey6z
         QYITg9kxcMhw40/CvVu3x13QF7jXjdx0HzalY=
Received: by 10.223.104.19 with SMTP id m19mr3683251fao.58.1239019984838; Mon, 
	06 Apr 2009 05:13:04 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115811>

Hello

Is there a way to fetch based on SHA id's instead of named references?

My usage scenario is this: A change management tool based on version
controlled manifest files (somewhat similar to Google's Repo) must be
able to check out exact versions of all 200 trees in the project view.
To support this, tags are used since they specify an exact revision.
But there are two problems with tagging:

 * Tags are not immutable.
 * External components that already have a tagging style get polluted
by our excessive use of tags.

I would really prefer to just list SHA keys in the manifests, but
fetch apparently doesn't support that? Could I use a combination of
lower level commands instead?

BR / Klas
