From: Martin Atukunda <matlads@dsmagic.com>
Subject: Can GIT_EXEC_PATH behave more like PATH?
Date: Wed, 7 Dec 2005 17:12:18 +0300
Message-ID: <20051207141218.GA721@igloo.ds.co.ug>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Dec 07 15:17:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ek02O-0000qp-1G
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 15:12:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbVLGOMt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Dec 2005 09:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbVLGOMt
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Dec 2005 09:12:49 -0500
Received: from mail1.starcom.co.ug ([217.113.72.31]:45354 "EHLO
	mail1.infocom.co.ug") by vger.kernel.org with ESMTP
	id S1751077AbVLGOMs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2005 09:12:48 -0500
Received: from entandikwa.ds.co.ug ([::ffff:217.113.73.39])
  by mail1.infocom.co.ug with esmtp; Wed, 07 Dec 2005 17:12:28 +0300
  id 000F9A3A.4396EDCC.000038CC
Received: from igloo.ds.co.ug (igloo.ds.co.ug [192.168.129.66])
	by entandikwa.ds.co.ug (Postfix) with ESMTP id F27CB4C7D
	for <git@vger.kernel.org>; Wed,  7 Dec 2005 17:14:12 +0300 (EAT)
Received: from matlads by igloo.ds.co.ug with local (Exim 4.60)
	(envelope-from <matlads@dsmagic.com>)
	id 1Ek01q-0000Bv-KU
	for git@vger.kernel.org; Wed, 07 Dec 2005 17:12:18 +0300
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13323>

Hi,

I've been wondering if GIT_EXEC_PATH shouldn't be able to behave more
like the PATH env. variable?

it would allow for instance something like:

GIT_EXEC_PATH=/git/core:/usr/local/git/potty:/usr/lib/git

and naturally git <command> would do the correct thing given.

if so, definetly post 1.0 stuff.

any ideas?

- Martin -

-- 
Due to a shortage of devoted followers, the production of great leaders has been discontinued.
