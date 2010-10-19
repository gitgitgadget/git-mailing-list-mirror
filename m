From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: [PATCH] repack: place temporary packs under .git/objects/pack/
Date: Tue, 19 Oct 2010 03:17:36 -0700 (PDT)
Message-ID: <1287483456222-5650273.post@n2.nabble.com>
References: <1287469706023-5649732.post@n2.nabble.com> <201010190859.43098.trast@student.ethz.ch> <1287473363910-5649843.post@n2.nabble.com> <1287474040065-5649864.post@n2.nabble.com> <cbdf4787ddaccd7105ab1661529a98257d61179b.1287481801.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 19 12:18:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P89GS-00077c-9c
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 12:17:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933929Ab0JSKRj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 06:17:39 -0400
Received: from kuber.nabble.com ([216.139.236.158]:38509 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933922Ab0JSKRi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 06:17:38 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <marat@slonopotamus.org>)
	id 1P89GC-0004nb-7O
	for git@vger.kernel.org; Tue, 19 Oct 2010 03:17:36 -0700
In-Reply-To: <cbdf4787ddaccd7105ab1661529a98257d61179b.1287481801.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159320>


Either i'm doing something wrong or given patch doesn't fix testcase [1] i
gave before. Tested by applying patch to git master and running
<git_master>/git --exec-path=<git_master> gc

[1]
http://git.661346.n2.nabble.com/BUG-git-repack-fails-if-git-objects-pack-is-on-a-separate-partition-tp5649732p5649864.html
-- 
View this message in context: http://git.661346.n2.nabble.com/BUG-git-repack-fails-if-git-objects-pack-is-on-a-separate-partition-tp5649732p5650273.html
Sent from the git mailing list archive at Nabble.com.
