From: Victor Leschuk <vleschuk@accesssoftek.com>
Subject: git-svn: Why not use git-fast-import?
Date: Tue, 22 Sep 2015 02:12:59 -0700
Message-ID: <6AE1604EE3EC5F4296C096518C6B77EE5D0FDAB9D7@mail.accesssoftek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 22 11:13:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeJdQ-0001dJ-43
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 11:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933065AbbIVJNG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 05:13:06 -0400
Received: from mail.accesssoftek.com ([12.202.173.171]:27454 "EHLO
	mail.accesssoftek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932549AbbIVJNB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Sep 2015 05:13:01 -0400
Received: from mail.accesssoftek.com ([172.16.0.71]) by mail.accesssoftek.com
 ([172.16.0.71]) with mapi; Tue, 22 Sep 2015 02:12:59 -0700
Thread-Topic: git-svn: Why not use git-fast-import?
Thread-Index: AQHQ9RbfVaqu2IDY5ESLqI/geiDN4w==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278384>

Hello all, 

I've been playing with git-svn for some time already and as it seems to me there are two most important problems which make it hard to use in production for large repositories. Very low speed and large memory footprint of synchronization with SVN repos (I am talking about clone and fetch operations mostly). I was wondering why the git-fast-import is not used for these purposes? Are there any serious limitations which make it impossible?

I have found several alternative solutions which use git-fast-import but they all do only the initial import of a repo. I have looked through the documentation and didn't see why fast-import can't be used to sync an existing repo after the import. Am I missing something?

Thanks in advance for clarification.
