From: "Lars R. Damerow" <lars@pixar.com>
Subject: [PATCH v3 0/3] Add support for GIT_ONE_FILESYSTEM
Date: Wed, 17 Mar 2010 12:55:50 -0700
Message-ID: <1268855753-25840-1-git-send-email-lars@pixar.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 17 21:06:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrzVU-0006Kx-I5
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 21:06:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756050Ab0CQUGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Mar 2010 16:06:14 -0400
Received: from nmx.pixar.com ([199.108.77.23]:54753 "EHLO nmx.pixar.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756016Ab0CQUGM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 16:06:12 -0400
X-PixarMID: 1939847
X-PixarRecvListener: OutboundMail
X-PixarRemoteIP: 138.72.131.152
X-IronPort-AV: E=Sophos;i="4.51,261,1267430400"; 
   d="scan'208";a="1939847"
Received: from helper.dynamic.pixar.com ([138.72.131.152])
  by nimbus.pixar.com with ESMTP; 17 Mar 2010 12:56:03 -0700
Received: from helper.dynamic.pixar.com (localhost [127.0.0.1])
	by helper.dynamic.pixar.com (8.14.3/8.14.3) with ESMTP id o2HJu3fD025887
	for <git@vger.kernel.org>; Wed, 17 Mar 2010 12:56:03 -0700
Received: (from lars@localhost)
	by helper.dynamic.pixar.com (8.14.3/8.14.3/Submit) id o2HJu36R025885
	for git@vger.kernel.org; Wed, 17 Mar 2010 12:56:03 -0700
X-Mailer: git-send-email 1.6.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142436>


Here's another try for GIT_ONE_FILESYSTEM.

I took Duy's recommendation not to die() in gentle mode as well as to just use
cwd in my error messages (after truncating them). I also fixed the problem
with the existing error message's use of an untruncated cwd.

Thanks for all of the suggestions!

Lars R. Damerow (3):
      config.c: remove static keyword from git_env_bool()
      truncate cwd string before printing error message
      Add support for GIT_ONE_FILESYSTEM

 Documentation/git.txt |    3 +++
 cache.h               |    1 +
 config.c              |    2 +-
 setup.c               |   28 +++++++++++++++++++++++++++-
 4 files changed, 32 insertions(+), 2 deletions(-)
