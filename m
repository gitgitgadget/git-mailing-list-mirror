From: Benjamin LaHaise <bcrl@kvack.org>
Subject: git clone does not work with GIT_OBJECT_DIRECTORY set
Date: Sun, 5 Mar 2006 20:21:15 -0500
Message-ID: <20060306012115.GG20768@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Mar 06 02:26:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FG4Um-00036N-4L
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 02:26:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbWCFB0l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 20:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbWCFB0l
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 20:26:41 -0500
Received: from kanga.kvack.org ([66.96.29.28]:60837 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751104AbWCFB0k (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Mar 2006 20:26:40 -0500
Received: (from localhost user: 'bcrl' uid#63042 fake: STDIN
	(bcrl@kanga.kvack.org)) by kvack.org id <S26570AbWCFBVP>;
	Sun, 5 Mar 2006 20:21:15 -0500
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17258>

And another bug (linux-2.6.git was created with a clone of git://.../ 
while GIT_OBJECT_DIRECTORY was set):

$ git clone linux-2.6.git bootcache.git
fatal: '/home/bcrl/linux-2.6.git/.git': unable to chdir or not a git archive
fatal: unexpected EOF
clone-pack from '/home/bcrl/linux-2.6.git/.git' failed.
$ 

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
