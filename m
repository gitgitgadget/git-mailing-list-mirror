From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: Simple rollback or discard of un-commited changes
Date: Fri, 15 May 2009 21:21:21 -0500
Message-ID: <e9_YdDV8acmQN1LWtgANyk7np-p4Fge6aCPHlAGEpeaAUqaNBK9i8Q@cipher.nrlssc.navy.mil>
References: <025F1C6D-1CAE-42BD-986B-1B53238882DE@itelliseek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Peter CHARRON <pcharron@itelliseek.com>
X-From: git-owner@vger.kernel.org Sat May 16 04:23:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M59Yd-0003gl-KF
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 04:23:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754543AbZEPCV3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 22:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754531AbZEPCV2
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 22:21:28 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:58181 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754416AbZEPCV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 22:21:28 -0400
Received: by mail.nrlssc.navy.mil id n4G2LMAP025791; Fri, 15 May 2009 21:21:23 -0500
In-Reply-To: <025F1C6D-1CAE-42BD-986B-1B53238882DE@itelliseek.com>
X-OriginalArrivalTime: 16 May 2009 02:21:22.0546 (UTC) FILETIME=[01694D20:01C9D5CD]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119316>

Peter CHARRON wrote:
> I've used a lot of Source Code Control systems, but I can't figure out
> how to do a simple discard (aka rollback) of one file using GIT.

git checkout -- $file
