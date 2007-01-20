From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-am and git-rebase inconsistency
Date: Fri, 19 Jan 2007 16:25:26 -0800
Message-ID: <7vzm8ebl3d.fsf@assigned-by-dhcp.cox.net>
References: <873b66infc.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 01:25:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8433-0004PR-AF
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 01:25:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932844AbXATAZa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 19 Jan 2007 19:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932869AbXATAZa
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 19:25:30 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:60622 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932844AbXATAZ3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Jan 2007 19:25:29 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070120002528.BRVF29122.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Fri, 19 Jan 2007 19:25:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id DCRl1W00b1kojtg0000000; Fri, 19 Jan 2007 19:25:46 -0500
To: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>
In-Reply-To: <873b66infc.fsf@morpheus.local> (David =?iso-8859-1?Q?K=E5ged?=
 =?iso-8859-1?Q?al's?= message of
	"Sat, 20 Jan 2007 00:53:11 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37229>

David K=E5gedal <davidk@lysator.liu.se> writes:

> The git-am and git-rebase commands have some similarities in that bot=
h
> try to apply patches and may fail in the middle.  Both commands can b=
e
> rerun to continue the application.  The --skip option is used in both
> to skip one patch, but when a conflict has been resolved, git-rebase
> uses --continue, and git-am uses --resolved for what seems to me to b=
e
> the equivalent action.
>
> It would probably be good, although not terribly important, if these
> commands were change to be in harmony.  But I'm not sure which option
> I like best...

Well, git-rebase did not have any options like them in the
beginning, so a logical option would be to add --resolved as a
synonym to the latter.
