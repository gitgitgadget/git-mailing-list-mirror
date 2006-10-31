X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: emacs mode nitpicks
Date: Tue, 31 Oct 2006 13:58:43 +0100
Message-ID: <45474883.3040809@xs4all.nl>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 31 Oct 2006 12:58:49 +0000 (UTC)
Cc: julliard@winehq.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 32
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: muurbloem.xs4all.nl
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30582>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GetCV-0004uP-O9 for gcvg-git@gmane.org; Tue, 31 Oct
 2006 13:58:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423163AbWJaM6k (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 31 Oct 2006
 07:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423171AbWJaM6k
 (ORCPT <rfc822;git-outgoing>); Tue, 31 Oct 2006 07:58:40 -0500
Received: from main.gmane.org ([80.91.229.2]:47073 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1423163AbWJaM6j (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 31 Oct 2006 07:58:39 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GetCL-0004sz-Oi for git@vger.kernel.org; Tue, 31 Oct 2006 13:58:33 +0100
Received: from muurbloem.xs4all.nl ([213.84.26.127]) by main.gmane.org with
 esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Tue, 31 Oct 2006 13:58:33 +0100
Received: from hanwen by muurbloem.xs4all.nl with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 31 Oct 2006 13:58:33
 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hello,

I'm getting used to a GIT working environment, and part of that is the 
emacs mode.

I have a couple of nitpicks:

  - the "o" (open in other window, also available in 
cvs-mode/darcsum/bufferlist) doesn't work in git-status

  - it would be cool to have the return key function like in darcsum.

In darcsum, "enter" toggles showing of a diff of said file. When the 
diff is shown, the file is automatically marked for inclusion in the 
commit. Inside the diff, I can jump to the exact line with C-c.

In darcsum, I can select files for commit using only enter and arrow 
keys. In git-mode, I need the 'm', 'u', '=' keys.

(darcsum is at http://chneukirchen.org/repos/darcsum/ ; while Darcs does 
it have its issues, the Emacs mode is really very neat.)

  - When pressing 'c' for commit, the my cursor is at the "Author:" 
line. Moving to end of buffer  is just a single extra keystroke,  but 
it's completely superfluous and therefore: highly irritating keystroke.

I tried adding a (end-of-buffer) to the function definition, but it 
didn't work, and I'm not enough of an elisp guru to understand why it 
doesn't work.

-- 
  Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
