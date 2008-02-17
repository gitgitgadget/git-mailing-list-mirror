From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [RFH] Add some very basic tests for git mergetool
Date: Sun, 17 Feb 2008 13:57:14 +0100
Message-ID: <20080217125714.GA3925@steel.home>
References: <20080217103545.GA24158@hashpling.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Sun Feb 17 13:58:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQj5t-0000Fe-9G
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 13:58:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755260AbYBQM5T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 07:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755271AbYBQM5S
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 07:57:18 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:58356 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755121AbYBQM5S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 07:57:18 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CculzwpJEvGbQ=
Received: from tigra.home (Fabd1.f.strato-dslnet.de [195.4.171.209])
	by post.webmailer.de (mrclete mo42) (RZmta 16.5)
	with ESMTP id J002d6k1HBg8lf ; Sun, 17 Feb 2008 13:57:15 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id CE9C6277BD;
	Sun, 17 Feb 2008 13:57:14 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 5BBD956D24; Sun, 17 Feb 2008 13:57:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080217103545.GA24158@hashpling.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74127>

Charles Bailey, Sun, Feb 17, 2008 11:35:45 +0100:
> I tried to add some basic tests for git mergetool but unfortunately I
> hit a major stumbling block. I seem to have to include a delay in my
> fake mergetool otherwise the cat command didn't seem to work. It was
> as though the source file hadn't been writted out yet.

I removed your delay and the test works every time.
Could you strace the test (with "-ff -e open")?

> I'm not sure if there's a shell usleep instead of having to "sleep 1",

Just FYI: coreutils' sleep allows for subsecond sleeps.
