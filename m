From: Jakub Narebski <jnareb@gmail.com>
Subject: gitk lower pane (commit and files view) scrollbar extends past gitk window
Date: Wed, 21 Jun 2006 14:42:24 +0200
Organization: At home
Message-ID: <e7ber7$qh9$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Jun 21 14:43:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ft22z-0003Sh-FS
	for gcvg-git@gmane.org; Wed, 21 Jun 2006 14:43:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbWFUMnA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 08:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbWFUMnA
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 08:43:00 -0400
Received: from main.gmane.org ([80.91.229.2]:6882 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751547AbWFUMnA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jun 2006 08:43:00 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ft22d-0003NG-2B
	for git@vger.kernel.org; Wed, 21 Jun 2006 14:42:43 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Jun 2006 14:42:43 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Jun 2006 14:42:43 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22265>

In gitk from the current 'next' branch, post git version 1.4.0 
(blob ba4644f) scrollbar for lower pane, i.e. for commitdiff and files
(Comments) views extends past the bottom of the gitk window. Therefore 
I cannnot see lower part of commit diff if it is larger than window height.

gitk window has height lower than 700.

The upper pane, i.e. history graph scrollbar is correct, and works as it
should.

This is regression from git 1.3.0, where gitk works correctly.


Below ascii art trying to describe situation.

  _                                _                                  _
  ^  .. upper scrollbar arrow .... ^                                  ^
  #                                #                                  |
  #  .... position indicator ..... #                                  |
  |                                |                                  |
  |                                |    scrolling past window edge -> #
  |      bottom of gitk window --> =                                  =
  v                                  <-- no lower scrollbar arrow
  =  <-- bottom of gitk window

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
