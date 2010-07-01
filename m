From: Geirsman <dsamay@gmail.com>
Subject: Beg. Level: Send Radiant CMS w/extensions to Heroku
Date: Wed, 30 Jun 2010 23:15:18 -0700 (PDT)
Message-ID: <29042313.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 01 08:15:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUD3W-0000V9-8t
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 08:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753752Ab0GAGPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 02:15:20 -0400
Received: from kuber.nabble.com ([216.139.236.158]:45601 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545Ab0GAGPT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 02:15:19 -0400
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists@nabble.com>)
	id 1OUD3O-0004rT-T2
	for git@vger.kernel.org; Wed, 30 Jun 2010 23:15:18 -0700
X-Nabble-From: dsamay@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150010>


Hey,

I made the page I wanted locally with Radiant CMS and several extensions.
Then when I went to send it to Heroku I ran into a variety of errors, first
SSH, then I think I sent over the gems but not the extensions. And in
attempting to fix things I think I only made them worse.

Right now at http://freezing-night-21.heroku.com I believe I need to send
over my extensions because the repo size is 17.6megs and the slug size is
7.6megs. Also the way I read the error message I get. 

I'm lost so I start at the end, 

$ git push heroku
> Everything up-to-date

$ git commit -a
U	vendor/extensions/forms
U	vendor/extensions/forms_mail
U	vendor/extensions/mailer
U	vendor/extensions/multi_site
U	vendor/extensions/paperclipped
U	vendor/extensions/paperclipped_uploader
U	vendor/extensions/ray
U	vendor/extensions/rbac_base
U	vendor/extensions/rbac_page_edit
U	vendor/extensions/settings
U	vendor/plugins/attachment_fu
fatal: 'commit' is not possible because you have unmerged files.

I'm lost, I tried a variety of commands but nothing seems to work on these
extensions. I had several RB files on this list before so I hit git add
<file> and now they don't show up. Can't really do that extension dirs
though.

Anyways, I don't care if I start from scratch and do it properly or if I'm
just one step away from having the page that I want up and running. I'd just
like it up. It's a very simple page and it's taken many more hours to deploy
than to create because the documentation tends to be mmm...technical. Any
help would be greatly appreciated, I am trying to make a site for community
good!
-- 
View this message in context: http://old.nabble.com/Beg.-Level%3A-Send-Radiant-CMS-w-extensions-to-Heroku-tp29042313p29042313.html
Sent from the git mailing list archive at Nabble.com.
