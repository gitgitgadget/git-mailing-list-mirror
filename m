From: Vasyl Vavrychuk <vvavrychuk@gmail.com>
Subject: jgit, MutableInteger vs AtomicInteger
Date: Tue, 25 Nov 2008 13:54:35 +0000 (UTC)
Message-ID: <loom.20081125T134459-650@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 25 14:57:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4yPs-0002kL-A9
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 14:57:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbYKYNyp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2008 08:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbYKYNyp
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 08:54:45 -0500
Received: from main.gmane.org ([80.91.229.2]:58586 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750745AbYKYNyo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2008 08:54:44 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1L4yNG-0008I7-Ql
	for git@vger.kernel.org; Tue, 25 Nov 2008 13:54:42 +0000
Received: from fly.lviv.inobject.com ([217.65.240.234])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 25 Nov 2008 13:54:42 +0000
Received: from vvavrychuk by fly.lviv.inobject.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 25 Nov 2008 13:54:42 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 217.65.240.234 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.19 (KHTML, like Gecko) Chrome/0.3.154.9 Safari/525.19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101663>

Hi,

I've just started browsing jgit sources and an obvious question arise.
I didn't found such question in mail list and decided to ask the community.

I don't see reason behind creating own mutable integer container because we 
have java.util.concurrent.atomic.AtomicInteger with methods
    public final int get()
    public final void set(int i)

And that is what we want.

Regards,
  V. V.
