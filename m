From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Thu, 24 May 2007 10:13:58 -0700
Message-ID: <7vabvuywix.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0705240039370.4113@racer.site>
	<20070524072945.GO28023@spearce.org>
	<20070524073652.GH942MdfPADPa@greensroom.kotnet.org>
	<Pine.LNX.4.64.0705241039200.4648@racer.site>
	<20070524105112.GI942MdfPADPa@greensroom.kotnet.org>
	<Pine.LNX.4.64.0705241201270.4648@racer.site>
	<20070524111645.GK942MdfPADPa@greensroom.kotnet.org>
	<Pine.LNX.4.64.0705241230410.4648@racer.site>
	<20070524114354.GN942MdfPADPa@greensroom.kotnet.org>
	<Pine.LNX.4.64.0705241315290.4648@racer.site>
	<8c5c35580705240541j7f632fc4lbd308c9386c2bde6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>, skimo@liacs.nl,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	"Martin Waitz" <tali@admingilde.org>,
	"Alex Riesen" <raa.lkml@gmail.com>
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 24 19:14:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrGt2-00067h-R4
	for gcvg-git@gmane.org; Thu, 24 May 2007 19:14:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbXEXROA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 13:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbXEXROA
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 13:14:00 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:48478 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbXEXRN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 13:13:59 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070524171400.QDDC22040.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Thu, 24 May 2007 13:14:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 35Dy1X0011kojtg0000000; Thu, 24 May 2007 13:13:58 -0400
In-Reply-To: <8c5c35580705240541j7f632fc4lbd308c9386c2bde6@mail.gmail.com>
	(Lars Hjemli's message of "Thu, 24 May 2007 14:41:57 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48276>

"Lars Hjemli" <hjemli@gmail.com> writes:

> I think the whole point of the 'remote config' stuff is to get an
> unversioned/out-of-tree .gitmodules file, right?

Why does this have to be out-of-tree and unversioned to begin
with?

When you are bootstrapping, you will start by a fetch/clone of
the superproject.  Why can't that tree contain necessary
information that is relevant to the superproject in question?

Isn't the information about which subprojects are used by the
superproject specific to each superproject, and also specific to
each version of the superproject (as a superproject can start
using more projects than it did before)?
