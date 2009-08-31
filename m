From: martin liste larsson <martin.liste.larsson@gmail.com>
Subject: Question about git-svn
Date: Mon, 31 Aug 2009 15:01:20 +0200
Message-ID: <b4abed330908310601h197f8909h8f626e918f8e5090@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 31 15:02:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mi6Wh-0004Gj-7Z
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 15:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753063AbZHaNBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 09:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753030AbZHaNBW
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 09:01:22 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:35450 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752915AbZHaNBU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2009 09:01:20 -0400
Received: by bwz19 with SMTP id 19so2749477bwz.37
        for <git@vger.kernel.org>; Mon, 31 Aug 2009 06:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=07mW2BAt3MvfTsKnWsAImOUjVv/fXBO+LxgDpZ/ozgg=;
        b=UvV7ETPuGvtXxERpjK47SqCmfva6F+Fs1K7/o9tEoxqYSKFMinHuaQ/kucbwCg8GXi
         E/Q4WPkF5EwM6wnz9FqvYnzl/bJkAynVmAOys74mvdquKBlK/Pd1QfiHdQl3uE9tekxS
         JMyr2GW4vEdH/BEXujSPiR2/NquC3dLjWtxys=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=eagFJW5xuVmtGEXZi7kyUzwz/cPiOaZSGoI0EHUjPXsHiVnnn+nNCrPRTM6q1Sc7dM
         fbn/jTSOC0zYaBTMYFVoG5YQSN/uyqcEZ39mGm+NbFYDYuebBpfBOt5S61I8/hc4sntv
         OAMD6fXkQ2VtaHvG5uXu6r9c3bTRsmTrIeJGg=
Received: by 10.204.24.19 with SMTP id t19mr4328970bkb.16.1251723680819; Mon, 
	31 Aug 2009 06:01:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127481>

I have a problem using git-svn. Is this the right place to ask then?

I have followed Andy Delcambre's
http://herebeforeatreplies.com/2008/03/04/git-svn-workflow.html, but
it seems that not all my tags and branches are being imported from svn
to (local) git. That is, 'git branch -a' gives much less output (about
half) of the combination 'svn list http://repos/branches' and 'svn
list http://repos/tags'. What's missing seems to be the newest
branches and tags.

M.
