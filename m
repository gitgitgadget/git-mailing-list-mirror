From: Shawn Pearce <spearce@spearce.org>
Subject: Re: GIT as binary repository
Date: Thu, 21 Oct 2010 14:23:53 -0700
Message-ID: <AANLkTikk5FA-3LQNfjj6rq0ouO7CywZ9_FaaZCGRM_YB@mail.gmail.com>
References: <2EBB46ACFCD6CF48B45E2B1865BD02338037D36B4E@GVW1098EXB.americas.hpqcorp.net>
 <AANLkTim6qsUDf5LS7C9o+C92Aqh7CohLLJ=+13BE3Tze@mail.gmail.com> <20101021195416.GF28700@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: weigelt@metux.de, "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 21 23:24:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P92cX-0002gH-Im
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 23:24:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754999Ab0JUVYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 17:24:17 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36827 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754636Ab0JUVYQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 17:24:16 -0400
Received: by iwn34 with SMTP id 34so52006iwn.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 14:24:15 -0700 (PDT)
Received: by 10.231.36.4 with SMTP id r4mr1254435ibd.55.1287696255370; Thu, 21
 Oct 2010 14:24:15 -0700 (PDT)
Received: by 10.231.140.97 with HTTP; Thu, 21 Oct 2010 14:23:53 -0700 (PDT)
In-Reply-To: <20101021195416.GF28700@nibiru.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159574>

On Thu, Oct 21, 2010 at 12:54 PM, Enrico Weigelt <weigelt@metux.de> wrote:
> BTW: how are the current tree objects structured ? Is there always
> one big tree object representing the whole tree or can it be
> splitted hierachically ?

Trees in the repository are split hierarchically, but its a flat list
in the dircache/index file (aka $GIT_DIR/index).

-- 
Shawn.
