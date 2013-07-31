From: Dirk Wallenstein <halsmit@t-online.de>
Subject: [PATCH 0/2] Remove tabs from howto documents
Date: Wed, 31 Jul 2013 18:54:07 +0200
Message-ID: <20130731165406.GA11219@bottich>
References: <20130716180158.GA7524@bottich>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Ackermann <th.acker@arcor.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 31 18:54:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4ZfN-0007R8-Ls
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 18:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760478Ab3GaQyV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Jul 2013 12:54:21 -0400
Received: from mailout02.t-online.de ([194.25.134.17]:49823 "EHLO
	mailout02.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760081Ab3GaQyU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 12:54:20 -0400
Received: from fwd19.aul.t-online.de (fwd19.aul.t-online.de )
	by mailout02.t-online.de with smtp 
	id 1V4ZfG-0002db-CT; Wed, 31 Jul 2013 18:54:18 +0200
Received: from localhost (EIJ1KiZprhd2v8ZSvhWC13GGnDCeNiSag0WyXKNA+2+0JlluiNNd-Nw3Ner5WUjQQ0@[78.94.248.235]) by fwd19.t-online.de
	with esmtp id 1V4ZfB-0LNxpY0; Wed, 31 Jul 2013 18:54:13 +0200
Content-Disposition: inline
In-Reply-To: <20130716180158.GA7524@bottich>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ID: EIJ1KiZprhd2v8ZSvhWC13GGnDCeNiSag0WyXKNA+2+0JlluiNNd-Nw3Ner5WUjQQ0
X-TOI-MSGID: 44491897-8c08-4360-9747-4bd55c5ccb46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231430>

I really think that tabs are generally bad here.  So, this will
remove all tabs from the howto folder and prevent indenting with tabs
through gitattributes.

Dirk Wallenstein (2):
  howto: Suppress indentation with tabs
  howto: Eliminate all tabs

 Documentation/howto/.gitattributes                 |  1 +
 .../howto/rebase-from-internal-branch.txt          |  8 ++--
 Documentation/howto/rebuild-from-update-hook.txt   |  4 +-
 .../howto/recover-corrupted-blob-object.txt        | 50 +++++++++++-----------
 Documentation/howto/revert-a-faulty-merge.txt      | 16 +++----
 Documentation/howto/revert-branch-rebase.txt       |  2 +-
 Documentation/howto/update-hook-example.txt        |  8 ++--
 Documentation/howto/use-git-daemon.txt             | 10 ++---
 8 files changed, 50 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/howto/.gitattributes

-- 
1.8.3.3.2.g85103ba
