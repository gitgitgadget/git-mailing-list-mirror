From: david@lang.hm
Subject: Re: is gitosis secure?
Date: Mon, 15 Dec 2008 00:25:53 -0800 (PST)
Message-ID: <alpine.DEB.1.10.0812150024080.17688@asgard.lang.hm>
References: <200812090956.48613.thomas@koch.ro> <bd6139dc0812090138l5dbaf20bsd1cde00f52bb94e5@mail.gmail.com> <87hc58hwmi.fsf@hades.wkstn.nix> <gi1qsl$22p$1@ger.gmane.org> <alpine.DEB.1.10.0812132126470.17688@asgard.lang.hm> <4944D4F7.7050501@siamect.com>
 <alpine.DEB.1.10.0812140304320.17688@asgard.lang.hm> <4944E7E1.2030907@siamect.com> <alpine.DEB.1.10.0812141655150.17688@asgard.lang.hm> <20081215071737.GA32387@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: martin <martin@siamect.com>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Mon Dec 15 08:26:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LC7qf-0000jd-Vt
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 08:26:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976AbYLOHZQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 02:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751904AbYLOHZQ
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 02:25:16 -0500
Received: from mail.lang.hm ([64.81.33.126]:42221 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751788AbYLOHZP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 02:25:15 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id mBF7Od3M004327;
	Sun, 14 Dec 2008 23:24:39 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20081215071737.GA32387@glandium.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103134>

On Mon, 15 Dec 2008, Mike Hommey wrote:

> On Sun, Dec 14, 2008 at 05:00:14PM -0800, david@lang.hm wrote:
>> 1. if you are running multiple different applications that all want to be
>> exposed via port 22 (like git for 'git push') then you may need to expose
>> numerous machines. tools that use SSH don't tend to have the ability to
>> use a gateway box before they start executing commands, they assume that
>> you will SSH directly into the destination box.
>
> But ssh itself allows you to do proxying. See ProxyCommand in
> ssh_config's manpage.

I was not aware of that option, but it looks like it's designed to be one 
setting for all your ssh communications, so unless you always use the same 
gateway box to get to your destination you would need to tweak your ssh 
config for each different thing that you are doing.

David Lang
