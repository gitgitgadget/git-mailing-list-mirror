From: david@lang.hm
Subject: Re: metastore (was: Track /etc directory using Git)
Date: Sun, 16 Sep 2007 12:43:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0709161242170.24221@asgard.lang.hm>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151507310.28586@racer.site> <20070915145437.GA12875@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151430040.5298@iabervon.org> <Pine.LNX.4.64.0709152310380.28586@racer.site>
 <20070916061411.GC24124@piper.oerlikon.madduck.net> <20070916155147.GA30476@efreet.light.src>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>,
	David =?utf-8?B?SMOkcmRlbWFu?= <david@hardeman.nu>
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Sun Sep 16 21:44:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IX02e-0002Gw-20
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 21:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbXIPToY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 15:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752034AbXIPToY
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 15:44:24 -0400
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:57389
	"EHLO bifrost.lang.hm" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006AbXIPToX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 15:44:23 -0400
Received: from asgard (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id l8GJhltg025367;
	Sun, 16 Sep 2007 12:43:47 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20070916155147.GA30476@efreet.light.src>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58338>

On Sun, 16 Sep 2007, Jan Hudec wrote:

> On Sun, Sep 16, 2007 at 08:14:11 +0200, martin f krafft wrote:
>> also sprach Johannes Schindelin <Johannes.Schindelin@gmx.de> [2007.09.16.0014 +0200]:
>>> While at it, you should invent a fallback what to do when the
>>> owner is not present on the system you check out on.  And
>>> a fallback when checking out on a filesystem that does not support
>>> owners.
>>
>> Like rsync, git would use numerical UIDs (which are always present)
>> by default, but could be told to try to map account names.
>>
>> If the filesystem does not support owners, chown() would not exist.
>> I actually tend to think of things the other way around: instead of
>> a fallback when chown() does not work (what would such a fallback be
>> other than not chown()ing?), it would only try chown() if such
>> functionality existed.
>
> There's a problem. You need to know that the functionality is missing and not
> try to read attributes back, but instead consider them unchanged. Nothing
> that can't be taken care of, but it needs to be handled carefuly.

but this can be handled by a local config option. yes, you have to be 
careful, but it'snot that hard.

David Lang
