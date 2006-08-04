From: Junio C Hamano <junkio@cox.net>
Subject: Re: Creating objects manually and repack
Date: Fri, 04 Aug 2006 13:30:18 -0700
Message-ID: <7vd5bgi6qt.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910608032043u689f431rc5408c6d89398142@mail.gmail.com>
	<Pine.LNX.4.64.0608032052210.4168@g5.osdl.org>
	<9e4733910608032124o5b5b69b5hda2eb8cb1e0ac959@mail.gmail.com>
	<Pine.LNX.4.64.0608032138330.4168@g5.osdl.org>
	<Pine.LNX.4.64.0608032150510.4168@g5.osdl.org>
	<9e4733910608040740x23a8b0cs3bc276ef9e6fb8f7@mail.gmail.com>
	<9e4733910608040750g3f72c07ct43f54347e47f25b4@mail.gmail.com>
	<Pine.LNX.4.64.0608040818270.5167@g5.osdl.org>
	<9e4733910608040841v7f4f27efra63e5ead2656e07@mail.gmail.com>
	<Pine.LNX.4.64.0608040945070.5167@g5.osdl.org>
	<9e4733910608041017v235da03ocd3eeeb0ba0e259b@mail.gmail.com>
	<Pine.LNX.4.64.0608041027530.5167@g5.osdl.org>
	<Pine.LNX.4.64.0608041052030.5167@g5.osdl.org>
	<7v64h8l5om.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0608041218390.5167@g5.osdl.org>
	<87d5bgmh5r.wl%cworth@cworth.org>
	<7vodv0i89m.fsf@assigned-by-dhcp.cox.net> <eb09ln$h7k$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 04 22:30:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G96JM-0001Px-5V
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 22:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161400AbWHDUaV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 16:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932626AbWHDUaV
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 16:30:21 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:23972 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932624AbWHDUaU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 16:30:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060804203019.WVEU6303.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 4 Aug 2006 16:30:19 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <eb09ln$h7k$1@sea.gmane.org> (Jakub Narebski's message of "Fri,
	04 Aug 2006 22:12:16 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24836>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>
>> There _already_ is a command called git-show-index, since early
>> July last year ;-).
>
> Parhaps it should be renamed then, for consistency? 

There isn't anything to make consistent.  We use the word 
"index" to mean both dircache and the pack index files.
Usually you can tell between the two usage from context.

We could rename it to git-show-pack-index, but the command has
primarily been the debugging aid and not for real use, and I was
actually thinking about removing it, perhaps until now ;-).
