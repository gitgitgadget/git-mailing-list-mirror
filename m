From: Alex Bennee <kernel-hacker@bennee.com>
Subject: Importing all modules in a CVS repo with git-cvsimport
Date: Wed, 19 Mar 2008 18:35:36 +0000
Message-ID: <1205951736.24610.3.camel@pitcairn.cambridgebroadband.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 19 20:43:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc4BE-0002JK-82
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 20:42:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756627AbYCSTfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 15:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754424AbYCSTfy
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 15:35:54 -0400
Received: from el-out-1112.google.com ([209.85.162.176]:49496 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756616AbYCSTfw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 15:35:52 -0400
Received: by el-out-1112.google.com with SMTP id v27so452666ele.17
        for <git@vger.kernel.org>; Wed, 19 Mar 2008 12:35:49 -0700 (PDT)
Received: by 10.140.142.6 with SMTP id p6mr374211rvd.224.1205951741935;
        Wed, 19 Mar 2008 11:35:41 -0700 (PDT)
Received: from ?10.0.0.166? ( [212.44.17.78])
        by mx.google.com with ESMTPS id y7sm19381681ugc.16.2008.03.19.11.35.39
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 19 Mar 2008 11:35:40 -0700 (PDT)
X-Mailer: Evolution 2.12.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77515>

Hi,

I'm wanting to import the entirety of a CVS repository into git rather
than an individual module. However every approach I've tried to do this
fails as the underlying cvsps tool seems to only be able to deal with
modules rather than the whole project.

Is there any invocation I could do that would do the whole import?

--
Alex, homepage: http://www.bennee.com/~alex/ When angry, count four;
when very angry, swear. -- Mark Twain, "Pudd'nhead Wilson's Calendar"
