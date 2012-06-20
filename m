From: Laurent Alebarde <l.alebarde@free.fr>
Subject: Is the textconv filter called for each line ? or once for the file ?
Date: Wed, 20 Jun 2012 10:57:33 +0000 (UTC)
Message-ID: <loom.20120620T125636-763@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 20 13:00:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShIe0-0005av-Bi
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 13:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753970Ab2FTLAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 07:00:09 -0400
Received: from plane.gmane.org ([80.91.229.3]:54505 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753804Ab2FTLAH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 07:00:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ShIdo-0005Gi-Ii
	for git@vger.kernel.org; Wed, 20 Jun 2012 13:00:04 +0200
Received: from lfg31-1-88-181-156-206.fbx.proxad.net ([88.181.156.206])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Jun 2012 13:00:04 +0200
Received: from l.alebarde by lfg31-1-88-181-156-206.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Jun 2012 13:00:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 88.181.156.206 (Opera/9.80 (X11; Linux x86_64; U; fr) Presto/2.10.289 Version/12.00)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200292>

Hi all,

Something I need clarification please :

In the documentation on gitattributes, it is said :

"A textconv, by comparison, is much more limiting. You provide a transformation
of the data into a line-oriented text format, and git uses its regular diff 
tools to generate the output."

Does it mean that the textconv filter is called for each line ? The opposite
being called once for the whole file.

Regards,


Laurent.
