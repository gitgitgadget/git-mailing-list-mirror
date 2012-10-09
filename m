From: Bogdan Cristea <cristeab@gmail.com>
Subject: git clone algorithm
Date: Tue, 9 Oct 2012 17:23:35 +0000 (UTC)
Message-ID: <loom.20121009T192043-666@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 09 19:30:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLddI-0008PK-8G
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 19:30:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754341Ab2JIRaG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2012 13:30:06 -0400
Received: from plane.gmane.org ([80.91.229.3]:59581 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751292Ab2JIRaE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 13:30:04 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TLdd5-0008Iw-DB
	for git@vger.kernel.org; Tue, 09 Oct 2012 19:30:03 +0200
Received: from 37-8-179-112.coucou-networks.fr ([37.8.179.112])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 09 Oct 2012 19:30:03 +0200
Received: from cristeab by 37-8-179-112.coucou-networks.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 09 Oct 2012 19:30:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 37.8.179.112 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/21.0.1180.89 Safari/537.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207331>

I have already posted this message on git-users@googlegroups.com but I have been 
advised to rather use this list. I know that there is a related thread 
(http://thread.gmane.org/gmane.comp.version-control.git/207257), but I don't 
think that this provides an answer to my question (me too I am on a slow 3G 
connection :))

I am wondering what algorithm is used by git clone command ? 
When cloning from remote repositories, if there is a link failure and
the same command is issued again, the process should be smart enough
to figure out what objects have been already transferred locally and
restart the cloning process from the point it has been interrupted.
As far as I can tell this is not the case, each time I have restarted
the cloning process everything started from the beginning. This is
extremely annoying with slow, unreliable connections. Are there any
ways to cope with this situation or any future plans ?
