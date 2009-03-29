From: Bryan Donlan <bdonlan@gmail.com>
Subject: Re: On git 1.6 (novice's opinion)
Date: Sun, 29 Mar 2009 01:41:06 -0400
Message-ID: <3e8340490903282241u355ce5b3u1a6ff23b27f4ec12@mail.gmail.com>
References: <49CC8C90.12268.242CEFCE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
X-From: git-owner@vger.kernel.org Sun Mar 29 07:48:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnnsV-0004FU-AF
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 07:48:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbZC2FlL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2009 01:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbZC2FlJ
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 01:41:09 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:49667 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbZC2FlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2009 01:41:09 -0400
Received: by qyk16 with SMTP id 16so2864326qyk.33
        for <git@vger.kernel.org>; Sat, 28 Mar 2009 22:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zxvLjee2rwQkPWfGx1dO6CwOUr4Lxt3EiaN425SmLME=;
        b=YGIcll0NLYUiDP1sAz6qiG1om3ZenDx/i8q7ZwZ5PipSQKDFb4v2clBtGdrW7PpIWm
         Iai0Gx9Os2GlBMA/OoRisTLOkZUkEvmhY8fC3+BdgEUkiT7TBLgQHkn2mwBTJteYlRUE
         LQ6BjctOTAWa07ugMu1AGP+yPV3l+iK9YRRFE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pvvR5f1uFZ9gGhI0GQMaIdg43Yr810DQDRL4OF3R8lfwSLEK7OFVpJhxOiUjpWO2CN
         dkf7/6822QmUMgLqkTglwdfe373abH++loyWYZZ/vLClNXe8ZT2iwA3U0yqT6N8oa0SQ
         CcnBpNAOFnE8a88RTALmZ9WsFkFsRg7xssUpM=
Received: by 10.220.94.137 with SMTP id z9mr1079262vcm.52.1238305266484; Sat, 
	28 Mar 2009 22:41:06 -0700 (PDT)
In-Reply-To: <49CC8C90.12268.242CEFCE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114998>

On Fri, Mar 27, 2009 at 3:21 AM, Ulrich Windl
<ulrich.windl@rz.uni-regensburg.de> wrote:


> 3) "git undo": If possible undo the effects of the last command.

You can roll back the state of most local references by using the git
reflog (see git reflog --help for more information). This covers most
situations - but note that it only works to roll back to a committed
state, and won't save any uncommitted data at all.
