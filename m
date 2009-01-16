From: Ping Yin <pkufranky@gmail.com>
Subject: Is there a way to exclude some file from a diff?
Date: Fri, 16 Jan 2009 15:04:57 +0800
Message-ID: <46dff0320901152304l2d5d6fcavb5207375cabe9d53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 16 08:06:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNime-0005i1-Mp
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 08:06:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754735AbZAPHE6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 02:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754329AbZAPHE6
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 02:04:58 -0500
Received: from rv-out-0506.google.com ([209.85.198.235]:62561 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753550AbZAPHE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 02:04:57 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1446872rvb.1
        for <git@vger.kernel.org>; Thu, 15 Jan 2009 23:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=azIKi0mwpwMUJfkrsSbmo9fs35FX/lAkvtggD5vDuQ4=;
        b=jE8y2ohEDhd9zAeuLjKMcPAOeRq3QoPuyDol0NjWUs4e9Ymvt5wUKVZp3v5kW0oDD/
         9FxCrqVws4l6tRcuRBAIyBUt9DQgJUqfPVscORcykb+ZMvCDDiB/Wwt/yclV79Pm+7ln
         57wzoeBu3WcWoRTdFYBa83zdr1W2aSBh6Ukwo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=FVLZocMmK81Wr0LNsrnDuMJ+RivughQ0QF0R3DynCOF56m1FZnhtKt6cXmwZAq2RDa
         ODbCzyBu78FB6oimWXuhVz4mFWvv1mGhch3rzTu+e/JrqOAGrTdrpVOFIQrybcqZc4EI
         X9s4Xe7cfVQHcc8mXU/jyTP8QqzOsJdzrbx44=
Received: by 10.114.234.13 with SMTP id g13mr1527861wah.64.1232089497097; Thu, 
	15 Jan 2009 23:04:57 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105924>

Something similar to

git diff --exclude=".gitignore" A..B

There are so many directories, so using "git diff path1 path2" is inapposite.


Ping Yin
