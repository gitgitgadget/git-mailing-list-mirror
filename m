From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: git repack with a --reference
Date: Thu, 07 May 2009 12:14:07 -0500
Message-ID: <y6_KSeeksmCZ_XvwgBeZd4SDdo0CcdL0TgPJ6Py336qsFto6evR0vA@cipher.nrlssc.navy.mil>
References: <4A0261D8.8040105@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonathan Harker <jonathan@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Thu May 07 19:14:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M27Ax-0003WR-25
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 19:14:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758627AbZEGROW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 13:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757807AbZEGROV
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 13:14:21 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:34887 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754919AbZEGROU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 13:14:20 -0400
Received: by mail.nrlssc.navy.mil id n47HE9jC031360; Thu, 7 May 2009 12:14:10 -0500
In-Reply-To: <4A0261D8.8040105@catalyst.net.nz>
X-OriginalArrivalTime: 07 May 2009 17:14:09.0032 (UTC) FILETIME=[3BCEA880:01C9CF37]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118495>

Jonathan Harker wrote:
> Hi - hope this isn't too noobish but I'm trying to get an existing git
> checkout to repack/prune/gc itself such that it would be like I had
> cloned it with --reference /path/to/local/repo (i.e. I've added
> /path/to/local/repo to .git/objects/info/alternatives, and I'd like it
> to reduce its objects from 200 MB to 5 MB). Is this
> 
> a. possible,
> 
> b. desirable, and
> 
> c. not insane?

yes,yes,yes.

The path written to .git/objects/info/alternates (also notice spelling of
"alternates") should be the path to the objects directory, not to the
toplevel repository.

i.e.

   /path/to/local/repo.git/objects

It should work properly since git v1.6.2.3.

-brandon
