From: "Christian von Kietzell" <cuboci@gmail.com>
Subject: Syncing with CVS
Date: Mon, 19 Jan 2009 10:39:53 +0100
Message-ID: <f31e50960901190139w65b69fd1k752973a23c40f384@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 19 10:41:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOqdC-0007uS-IH
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 10:41:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756968AbZASJjy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 04:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756908AbZASJjy
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 04:39:54 -0500
Received: from rv-out-0506.google.com ([209.85.198.230]:59279 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756897AbZASJjx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 04:39:53 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2539175rvb.1
        for <git@vger.kernel.org>; Mon, 19 Jan 2009 01:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=Uk4UgeNjqbogE+kKbCTZhEyymlgDFyBlbCl/D/Rb9JI=;
        b=fzhr13XeHBmBKOpFxMkNeGMzawDTp25nWyIMJc7FoU54IXtoNJPHJ0LpwDqYBnnyR7
         jw5orbjw/7lYT60qXJXSKEQqn4juCONFUxQaJcmQ7WOo7YHEybknKO4eBW4i849TMP6d
         63USZDvjLX+wRox9HeeM22gzptlggRIzDibiA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=IBJhIdWe14KkBzGJOFUptjkKYYTQPzbwNU5x4s54B0WpVt5khpFVMIAjoV5SEPjEwt
         R1FLcg/n0E/pFDg9UXumJ52xwfDP2iqdwo0APVwzA2zKgfVz3Rnh3pjAhDivzfAmTRDv
         2l2hx5msxlgcPq0qgmXHyvfaz8WSXebs/EZds=
Received: by 10.142.142.14 with SMTP id p14mr795409wfd.307.1232357993115;
        Mon, 19 Jan 2009 01:39:53 -0800 (PST)
Received: by 10.143.34.2 with HTTP; Mon, 19 Jan 2009 01:39:53 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106341>

Hi,

I have a project I started in git. After a while I exported that to
CVS via git cvsexportcommit which worked quite nicely. Now, a
colleague made changes to the project - in CVS. What's the best way to
get those back into my git repository so that I'll be able to sync
back and forth between git and CVS? I had a quick look at the wiki but
couldn't find anything appropriate.

I know of git cvsimport, of course, but that doesn't work on my
original repository. Or does it? I didn't find anything on how to
limit what to import. After all, some of the commits are already in my
repository (the ones I exported).

Hope any of you can help. Thanks in advance.

  Chris
