From: chombee <chombee@lavabit.com>
Subject: Git merge using patience diff?
Date: Mon, 26 Apr 2010 19:09:23 +0100
Message-ID: <20100426180923.GC18122@debxo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 26 20:09:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6SkU-00024S-OW
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 20:09:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752603Ab0DZSJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Apr 2010 14:09:33 -0400
Received: from karen.lavabit.com ([72.249.41.33]:44610 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751521Ab0DZSJc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 14:09:32 -0400
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id 059A611BB0C
	for <git@vger.kernel.org>; Mon, 26 Apr 2010 13:09:30 -0500 (CDT)
Received: from debxo (77-44-113-77.xdsl.murphx.net [77.44.113.77])
	by lavabit.com with ESMTP id FJCJEPS2URJ8
	for <git@vger.kernel.org>; Mon, 26 Apr 2010 13:09:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=A2t4kIqo+mNyLzVGtpT5vUxIvGYx6tciP++OJRifb2lmsYGf6LV9YtyZXUSlZaH5YkJhP1ltYYU1JlpuOc9MiXiXqc9bJX2SIkPLfhEy15NlYo1qRIAKUyBACO/nnOZDTFje8kr9JANzh04svAe1TVcdRrRiDbVqvivVkEEh++s=;
  h=Date:From:To:Subject:Message-ID:Mail-Followup-To:MIME-Version:Content-Type:Content-Disposition:User-Agent;
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145841>

Hey,

Is it possible to get git to use patience diff when merging?

My version of git is 1.5.*, from before git diff had the --patience
option. I got git diff to use bzr's implementation of patience diff via
GIT_EXTERNAL_DIFF. But when merging git still seems to use its normal
diff. Will I need to write my own merge driver that uses patience diff?

Thanks
