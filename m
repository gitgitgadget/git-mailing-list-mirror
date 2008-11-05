From: "Marc Fargas" <telenieko@telenieko.com>
Subject: Re: git-svn: Having a "rare" structure
Date: Wed, 5 Nov 2008 16:36:34 +0100
Message-ID: <2686a05b0811050736q520f1771t6ffa2840bfb3c308@mail.gmail.com>
References: <2686a05b0811050204v59edc4a3h7f9ce6c6ecd13058@mail.gmail.com>
	 <49119AAD.2010803@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Michael J Gruber" <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Nov 05 16:45:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxkZ3-0007dV-H9
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 16:45:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752582AbYKEPns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 10:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752271AbYKEPnr
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 10:43:47 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:32405 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864AbYKEPnr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 10:43:47 -0500
Received: by yx-out-2324.google.com with SMTP id 8so27161yxm.1
        for <git@vger.kernel.org>; Wed, 05 Nov 2008 07:43:46 -0800 (PST)
Received: by 10.90.98.13 with SMTP id v13mr753365agb.105.1225899394109;
        Wed, 05 Nov 2008 07:36:34 -0800 (PST)
Received: by 10.100.7.20 with HTTP; Wed, 5 Nov 2008 07:36:34 -0800 (PST)
In-Reply-To: <49119AAD.2010803@drmicha.warpmail.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100161>

Hi,

On Wed, Nov 5, 2008 at 2:07 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> git config svn-remote.svn.branches
> 'django/branches/features/*:refs/remotes/svn/features/*'
>
> git config --add svn-remote.svn.branches
> 'django/branches/releases/*:refs/remotes/svn/releases/*'
>
> In fact, you should be able to use your previous branches config when
> fetching up to r9093, then switch to the config I suggested, and the
> fetch from r9094.

I'll try it right now, I have one q... I've been fetching from svn so
I now have "like a mess" in the branches dir (and their history) is
there a way to make git-svn forget about everything after r9093 so I
can do the config change and re-fetch since then? That'd be awesome.

Thanks a lot for the tip! ;)

Sincerelly,
Marc
-- 
http://www.marcfargas.com - will be finished someday.
