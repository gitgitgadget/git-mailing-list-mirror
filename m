From: Junio C Hamano <junkio@cox.net>
Subject: Re: Figured out how to get Mozilla into git
Date: Fri, 09 Jun 2006 23:15:04 -0700
Message-ID: <7vr71xk047.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com>
	<46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com>
	<46a038f90606091814n1922bf25l94d913238b260296@mail.gmail.com>
	<Pine.LNX.4.64.0606091825080.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606091837040.5498@g5.osdl.org>
	<9e4733910606091848r5fb4d565taabfc5198140daf2@mail.gmail.com>
	<Pine.LNX.4.64.0606091853180.5498@g5.osdl.org>
	<46a038f90606092041neadcc54n2acb6272d1f71de7@mail.gmail.com>
	<Pine.LNX.4.64.0606092043460.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606092109380.5498@g5.osdl.org>
	<9e4733910606092302h646ff554p107564417183e350@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 10 08:15:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fowka-00071A-OL
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 08:15:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030328AbWFJGPG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Jun 2006 02:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030322AbWFJGPG
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jun 2006 02:15:06 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:46078 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1030328AbWFJGPF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jun 2006 02:15:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060610061504.MYFP8684.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 10 Jun 2006 02:15:04 -0400
To: "Jon Smirl" <jonsmirl@gmail.com>
In-Reply-To: <9e4733910606092302h646ff554p107564417183e350@mail.gmail.com>
	(Jon Smirl's message of "Sat, 10 Jun 2006 02:02:58 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21599>

"Jon Smirl" <jonsmirl@gmail.com> writes:

> Here's a new transport problem. When using git-clone to fetch Martin's
> tree it kept failing for me at dreamhost. I had a parallel fetch
> running on my local machine which has a much slower net connection. It
> finally finished and I am watching the end phase where it prints all
> of the 'walk' messages. The git-http-fetch process has jumped up to
> 800MB in size after being 2MB during the download. dreamhost has a
> 500MB process size limit so that is why my fetches kept failing there.

The http-fetch process uses by mmaping the downloaded pack, and
if I recall correctly we are talking about 600MB pack, so 500MB
limit sounds impossible, perhaps?
