From: Nicolas Dufour <nicolas.dufour@nemoworld.info>
Subject: git log implementation details
Date: Fri, 16 Nov 2012 20:14:29 -0500
Message-ID: <50A6E4F5.1050402@nemoworld.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 17 02:14:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZWzf-0000nj-09
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 02:14:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753805Ab2KQBOb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2012 20:14:31 -0500
Received: from 173-203-239-151.static.cloud-ips.com ([173.203.239.151]:47727
	"EHLO mail.nemoworld.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753792Ab2KQBOb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2012 20:14:31 -0500
Received: from new-host-2.home (pool-98-109-62-183.nwrknj.fios.verizon.net [98.109.62.183])
	by mail.nemoworld.info (Postfix) with ESMTPSA id F04C5D853B
	for <git@vger.kernel.org>; Sat, 17 Nov 2012 01:17:03 +0000 (GMT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:16.0) Gecko/20121026 Thunderbird/16.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209923>

Hello,

I was wondering how the command "git log" is actually retrieving the
commit log for a given file behind the scene.
Is it by walking down the object tree and scanning each commit/tree
object? Or any cache/index used here?

Thank you,

Nicolas
