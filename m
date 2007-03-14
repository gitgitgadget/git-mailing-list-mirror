From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make gc a builtin.
Date: Wed, 14 Mar 2007 04:12:56 -0700
Message-ID: <7vps7caxjb.fsf@assigned-by-dhcp.cox.net>
References: <11738375021267-git-send-email-jbowes@dangerouslyinc.com>
	<7vodmwfg2c.fsf@assigned-by-dhcp.cox.net>
	<20070314074440.GC12710@thunk.org>
	<200703141045.58739.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	James Bowes <jbowes@dangerouslyinc.com>,
	Johannes.Schindelin@gmx.de
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 12:13:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRRPp-0005Ov-Dh
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 12:13:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161130AbXCNLM7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 07:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161132AbXCNLM7
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 07:12:59 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:64238 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161130AbXCNLM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 07:12:58 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070314111256.DMNK748.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Mar 2007 07:12:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id abCx1W0021kojtg0000000; Wed, 14 Mar 2007 07:12:57 -0400
In-Reply-To: <200703141045.58739.andyparkins@gmail.com> (Andy Parkins's
	message of "Wed, 14 Mar 2007 10:45:55 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42197>

Andy Parkins <andyparkins@gmail.com> writes:

> On Wednesday 2007 March 14 07:44, Theodore Tso wrote:
>
>> I agree with Junio; I think the scripts are much more readable and
>> easier to understand; In fact, it would be nice if the script were
>> preserved somewhere, perhaps as comments in the .c file.
>
> If only there were some tool that would keep collections of files as a 
> snapshotted whole and allow us to browse the history of those snapshots in 
> some sort of connected graph, with each snapshot being given some sort of 
> unique ID.  Then we could simply refer to that unique ID when we wanted to 
> tell someone about a particular historical instance.
>
> :-)

There is a difference between having a readily greppable and
lessable copy handy to study at your own initiative, and being
able to retrieve to review only after being told.

You could argue that we can all do that with git-grep and
git-less ;-).
