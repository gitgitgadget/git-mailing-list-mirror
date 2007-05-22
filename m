From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] rename dirlink to gitlink.
Date: Mon, 21 May 2007 23:19:05 -0700
Message-ID: <7vd50t9y92.fsf@assigned-by-dhcp.cox.net>
References: <20070521200828.GC5412@admingilde.org>
	<e7bda7770705211612w3ce1b7dew8d48f1ddeb7d100e@mail.gmail.com>
	<7vodkdbvmk.fsf@assigned-by-dhcp.cox.net>
	<20070522055939.GG5412@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torgil Svensson <torgil.svensson@gmail.com>, git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Tue May 22 08:19:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqNiM-0003mI-3O
	for gcvg-git@gmane.org; Tue, 22 May 2007 08:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755879AbXEVGTQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 02:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756114AbXEVGTP
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 02:19:15 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:59942 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755879AbXEVGTP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 02:19:15 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070522061914.EYWH2758.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Tue, 22 May 2007 02:19:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 26KD1X00a1kojtg0000000; Tue, 22 May 2007 02:19:14 -0400
In-Reply-To: <20070522055939.GG5412@admingilde.org> (Martin Waitz's message of
	"Tue, 22 May 2007 07:59:39 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48075>

Martin Waitz <tali@admingilde.org> writes:

> hoi :)
>
> On Mon, May 21, 2007 at 04:32:51PM -0700, Junio C Hamano wrote:
>> As an internal symbol, S_IFDIRLNK makes _much_ more sense than
>> S_IFGITLINK, exactly because it is a mixture of S_IFDIR and
>> S_IFLNK.
>
> But then we also should be consequent and rename the entire
> low-level plumbing to dirlink.  I don't see a reason to keep
> both.

Ok.  Let's do that then before it is too late.
