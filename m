From: Norbert Nemec <norbert.nemec@native-instruments.de>
Subject: shallow&single-branch clone?
Date: Wed, 19 Oct 2011 15:30:48 +0200
Message-ID: <4E9ED108.5020505@native-instruments.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 19 15:40:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGWNO-0004Wj-Vc
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 15:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756242Ab1JSNkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 09:40:04 -0400
Received: from mx.native-instruments.com ([93.92.134.52]:38577 "EHLO
	mx.native-instruments.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756230Ab1JSNkD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 09:40:03 -0400
X-Greylist: delayed 553 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Oct 2011 09:40:03 EDT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183928>

Hi there,

it seems like there is no way to clone a single branch with truncated 
history.

Truncating history is done by 'git clone --depth 1', there is not way to 
restrict 'clone' to a single branch (the --branch option still downloads 
all branches and only then chooses something other than HEAD as active 
branch).

The manual sequence
	git init
	git remote add -t master -f origin URL
	git checkout
allows a clone of a single branch but offers no means to truncate history.

The least intrusive solution would be an additional option to clone, 
perhaps '--branch-only'.

More user friendly, this options should be on by default when --depth is 
set. After all: who would expect branches to be cloned when the history 
is explicitely truncated?

Ideas?

Greetings,
Norbert Nemec
