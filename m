From: david@lang.hm
Subject: Re: metastore
Date: Tue, 2 Oct 2007 13:29:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0710021327371.24697@asgard.lang.hm>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151507310.28586@racer.site> <20070915145437.GA12875@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151430040.5298@iabervon.org> <20070916060859.GB24124@piper.oerlikon.madduck.net>
 <20070919191607.GE13683@hardeman.nu> <20071002195301.GB14171@lapse.madduck.net>
 <20071002195816.GA6759@hardeman.nu> <85lkalz3iv.fsf@lola.goethe.zz>
 <Pine.LNX.4.64.0710021314370.24697@asgard.lang.hm> <20071002202333.GB16010@lapse.madduck.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: David Kastrup <dak@gnu.org>,
	David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>,
	git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Tue Oct 02 22:29:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcoMW-0000G6-IP
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 22:29:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753449AbXJBU2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 16:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753409AbXJBU2w
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 16:28:52 -0400
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:60758
	"EHLO bifrost.lang.hm" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752632AbXJBU2v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 16:28:51 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id l92KSK9E023489;
	Tue, 2 Oct 2007 13:28:20 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20071002202333.GB16010@lapse.madduck.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59728>

On Tue, 2 Oct 2007, martin f krafft wrote:

> also sprach david@lang.hm <david@lang.hm> [2007.10.02.2118 +0100]:
>> the problem with this is dealing with the attributes outside of git
>> (especially when the filesystem can't store the attributes nativly,
>> specificly including things like owners when not running as root)
>
> In which case you should not be able to manipulate them (as you
> could not test the result) and any commits could not affect them,
> meaning they'd just stay unchanged.

two problems with this

1. you do want to be able to manipulate them

1a. how do you reconcile a conflict during a merge?

2. git is a series of snapshots, what does it mean to 'stay unchanged'?

David Lang
