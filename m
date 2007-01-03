From: Michael Krufky <mkrufky@linuxtv.org>
Subject: GITWEB branch shortlog broken after recent update on kernel.org
Date: Wed, 03 Jan 2007 14:21:22 -0500
Message-ID: <459C0232.3090804@linuxtv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
	Michael Krufky <mkrufky@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 03 20:47:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2C4d-00047k-Gr
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 20:46:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbXACTqw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 14:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbXACTqw
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 14:46:52 -0500
Received: from kirby.webscope.com ([204.141.84.54]:35244 "EHLO
	kirby.webscope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099AbXACTqv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 14:46:51 -0500
X-Greylist: delayed 1520 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jan 2007 14:46:51 EST
Received: from [127.0.0.1] ([68.160.103.76])
	(authenticated bits=0)
	by kirby.webscope.com (8.12.8/8.12.8) with ESMTP id l03JR9X4028959;
	Wed, 3 Jan 2007 14:27:10 -0500
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
To: git@vger.kernel.org
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35884>

Ever since gitweb on kernel.org was recently updated, I've been experiencing a
nasty bug -- It seems that it is no longer possible to view a shortlog from any
branch or head other than master.

For example:

http://www2.kernel.org/git/?p=linux/kernel/git/mkrufky/v4l-dvb-2.6.x.y.git

^^ this is a link to my v4l-dvb-2.6.x.y stable repository.  I have branched off
each kernel release to include all of the -stable release history.  You will
notice these in the 'heads' section near the bottom of the page.

If you click on the 2.6.16.y shortlog link:

http://www2.kernel.org/git/?p=linux/kernel/git/mkrufky/v4l-dvb-2.6.x.y.git;a=shortlog;h=2.6.16.y

gitweb displays the shortlog from the master branch, instead of the 2.6.16.y head.

However, if you click the "log" link:

http://www2.kernel.org/git/?p=linux/kernel/git/mkrufky/v4l-dvb-2.6.x.y.git;a=log;h=2.6.16.y

Only then, does gitweb show us the correct history for that branch.

"tree" is also working properly -- it seems that "shortlog" is the only feature
affected by this bug.

In the previous vesion of gitweb installed on kernel.org, this feature did
indeed function properly.

Can this be fixed?  I often use gitweb to view changesets in developer trees
before those changesets get pulled into the master branch of a repository.  I
find this feature very helpful for reviewing changesets, and I'd like for it to
work again.

Thanks in advance,

Michael Krufky
