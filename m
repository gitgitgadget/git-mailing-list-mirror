From: Bill Lear <rael@zopyra.com>
Subject: Re: Weird shallow-tree conversion state, and branches of shallow
 trees
Date: Sun, 15 Apr 2007 19:11:17 -0500
Message-ID: <17954.48933.484379.593657@lisa.zopyra.com>
References: <20070412005336.GA18378@curie-int.orbis-terrarum.net>
	<fcaeb9bf0704142257x3761ef2cie3996420b3bcd24a@mail.gmail.com>
	<Pine.LNX.4.64.0704151115270.5473@woody.linux-foundation.org>
	<200704152051.35639.andyparkins@gmail.com>
	<Pine.LNX.4.64.0704151317180.5473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Robin H. Johnson" <robbat2@gentoo.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 16 02:11:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdEoj-0008BL-TS
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 02:11:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754141AbXDPALf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 20:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754147AbXDPALf
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 20:11:35 -0400
Received: from mail.zopyra.com ([65.68.225.25]:60288 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754141AbXDPALe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 20:11:34 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l3G0BIr25450;
	Sun, 15 Apr 2007 18:11:18 -0600
In-Reply-To: <Pine.LNX.4.64.0704151317180.5473@woody.linux-foundation.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44556>

On Sunday, April 15, 2007 at 13:51:42 (-0700) Linus Torvalds writes:
>On Sun, 15 Apr 2007, Andy Parkins wrote:
>> 
>> You're right that it can cause problems, but it is certainly not the 
>> case that there are no valid uses for it.
>
>I'm sorry, but you're just wrong.
>
>There are no valid uses for it in the working tree. Full stop.
>
>There are valid uses to tag sources with some revision information WHEN IT 
>LEAVES THE REVISION CONTROLLED ENVIRONMENT, but not one second before 
>that. ...

Not that Linus needs any back-up from me, but I second this, very
strongly.  Decorating source code with release information is a proper
function of release management tools, not the SCM system.  We had a
similar argument in our company about this, sparked by a criticism of
git for not having keyword (version number) substitution, and I argued
that having such substitution functions in the SCM was out-of-place
and a crutch for weak release procedures.  It's easy with a proper
make system to put whatever information you want from the SCM into the
release product.

This would probably be as crazy as asking for saving and restoring
timestamps in the working tree on checkout of branches, and we know
how insane that is...


Bill
