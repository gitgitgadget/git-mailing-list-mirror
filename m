From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH (GITK)] gitk: Fix commit encoding support.
Date: Thu, 13 Nov 2008 22:42:58 +1100
Message-ID: <18716.4802.663635.847263@cargo.ozlabs.ibm.com>
References: <200811091806.07550.angavrilov@gmail.com>
	<18712.7942.767651.569321@cargo.ozlabs.ibm.com>
	<bb6f213e0811100406l2fcde5b8k8772360947b948fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Alexander Gavrilov" <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 12:44:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0act-0005Jw-7z
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 12:44:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbYKMLnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 06:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751959AbYKMLnU
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 06:43:20 -0500
Received: from ozlabs.org ([203.10.76.45]:44175 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751635AbYKMLnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 06:43:16 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 11B3DDDE00; Thu, 13 Nov 2008 22:43:15 +1100 (EST)
In-Reply-To: <bb6f213e0811100406l2fcde5b8k8772360947b948fd@mail.gmail.com>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100865>

Alexander Gavrilov writes:

> If all commits were loaded through cat-file, that would be the way to
> go. Otherwise, when one code path uses one method of conversion, and
> another one, which is used rarely and semi-randomly, a different
> method, it may lead to confusing results if something goes slightly
> wrong.

OK, that makes sense.  I applied the patch with a paragraph added to
the description that explains that.

Thanks,
Paul.
