From: "Alex Bennee" <kernel-hacker@bennee.com>
Subject: parsecvs losing files
Date: Wed, 28 May 2008 15:50:07 +0100
Message-ID: <b2cdc9f30805280750v3b92d115yf76f382e5c2fa418@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 28 16:53:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1Mzq-0000ZK-Ut
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 16:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbYE1OuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 10:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbYE1OuL
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 10:50:11 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:35721 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084AbYE1OuK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 10:50:10 -0400
Received: by rv-out-0506.google.com with SMTP id l9so3559788rvb.1
        for <git@vger.kernel.org>; Wed, 28 May 2008 07:50:07 -0700 (PDT)
Received: by 10.141.33.21 with SMTP id l21mr1269147rvj.105.1211986207519;
        Wed, 28 May 2008 07:50:07 -0700 (PDT)
Received: by 10.140.134.12 with HTTP; Wed, 28 May 2008 07:50:07 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 50e3ddd8130c7cb8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83095>

Hi,

I've been using a daily cron job running parsecvs to convert an uber
CVS tree into git. It works quite well and is substantially faster
than all the other methods I have tried. It also re-creates the same
history every time which is something I haven't managed to do with the
other tools.

Anyway today I noticed it had failed to import a sub-directory of the
project (not a bit I usually build). However looking at the import log
from parsecvs I see that the file was read by parsecvs. It looks as
though it should have made it into the git repo. The only thing that
seems different from the other modules is that the files where
imported once and don't seem to have been touched since. This may of
caused parsecvs to get confused?

Questions:

1. Has anyone seen this behaviour with parsecvs?
2. Is there any way to list all the tree objects in a repo so I can
search to see if the files exist in a tree but just not this branch?

-- 
Alex, homepage: http://www.bennee.com/~alex/
