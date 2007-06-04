From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Improved git-gui blame viewer
Date: Mon, 4 Jun 2007 18:10:54 +0200
Message-ID: <81b0412b0706040910w1894770bm593e0e54fbb3c44@mail.gmail.com>
References: <20070602041723.GD7044@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Linus Torvalds" <torvalds@linux-foundation.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jun 04 18:11:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvF98-0002vO-05
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 18:11:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752378AbXFDQK5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 12:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755075AbXFDQK5
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 12:10:57 -0400
Received: from ik-out-1112.google.com ([66.249.90.183]:16603 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752378AbXFDQK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 12:10:57 -0400
Received: by ik-out-1112.google.com with SMTP id b32so792926ika
        for <git@vger.kernel.org>; Mon, 04 Jun 2007 09:10:55 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iEslugzqqte9PuM+yK4IKVJ0z+a1XLAJu4ha4GzBtvtNaXXFGBq9GVCsVPzzhzz9NA/1crnzm0bhbVqeiVoWiQdHb6pWZlUiB8ZSpcNbMA2+itOA5AIfIeJDiSxKPHedlveD9W6YWAa7au6yGVQeDI2zNv/geeYQBwocRwRvInQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HJdeqCnYyYLdeGKyLaSckGpnBpMfvd+vMN7ErK/OLZrtEiUMCrU7vjHX4YzS/YNPkCux52vGgVaIxOnr4awnpEabwmSN35a/QIyp2SLVn5j62eJgfNqR+dnoFCRVgC29mxoWncyaVmgo4AXbdhk/59tvYuXzHS8PTPklp0CYhl8=
Received: by 10.78.21.7 with SMTP id 7mr2107545huu.1180973454609;
        Mon, 04 Jun 2007 09:10:54 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Mon, 4 Jun 2007 09:10:54 -0700 (PDT)
In-Reply-To: <20070602041723.GD7044@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49111>

On 6/2/07, Shawn O. Pearce <spearce@spearce.org> wrote:
>
> I finally got the git-gui code to the point where cleaning up the
> user interface was possible without sending myself to the nut house.
>

Very-very nice :) Does not seem to save sizes and positions of
blame and file browser windows, though. It did before, I believe
in .git/config.

BTW, saving windows positions in .git/config was scary: I
considered it user domain (yes, I _am_ afraid of using
git-config too).
Maybe it could be something like either ~/.git-gui or .git/guiconfig?
