From: Martin Gregory <martin.gregory@adelaideinterim.com.au>
Subject: Re: Issue with sparse checkout
Date: Mon, 16 Sep 2013 22:46:03 +0000 (UTC)
Message-ID: <loom.20130917T004445-713@post.gmane.org>
References: <SDZPSjFXUiRJMCkwPVQvMjk3OTAwMzE@IBMLT4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 17 00:50:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLhcS-0005lg-73
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 00:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517Ab3IPWuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Sep 2013 18:50:08 -0400
Received: from plane.gmane.org ([80.91.229.3]:56864 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751352Ab3IPWuH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Sep 2013 18:50:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1VLhcJ-0005XA-Ef
	for git@vger.kernel.org; Tue, 17 Sep 2013 00:50:03 +0200
Received: from ppp14-2-54-108.lns21.adl2.internode.on.net ([14.2.54.108])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 Sep 2013 00:50:03 +0200
Received: from martin.gregory by ppp14-2-54-108.lns21.adl2.internode.on.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 Sep 2013 00:50:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 14.2.54.108 (Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/29.0.1547.66 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234849>

An additional note.  I did 

git ls-files -v | grep ^S 

and I can see that the files that remain in the working version have the ^S 
bit set. 

So it does feel like a bug to me: why are files with ^S set remaining in the 
working version after 

git read-tree -mu HEAD 

?

Regards,

Martin
