From: Pavel Roskin <proski@gnu.org>
Subject: Re: [RFH] QGit: how to cram a patch in a crowded screen
Date: Wed, 30 May 2007 20:23:33 -0400
Message-ID: <1180571013.3582.32.camel@dv>
References: <e5bfff550705260146q51350f40q1c80cfe8079f47c6@mail.gmail.com>
	 <200705261034.53723.andyparkins@gmail.com>
	 <e5bfff550705261344l604543e7h64c20c1fc0979f20@mail.gmail.com>
	 <200705301408.37929.andyparkins@gmail.com>
	 <e5bfff550705301118k4ca8720bna260e171f0eb83ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 31 02:23:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtYSJ-0003HB-35
	for gcvg-git@gmane.org; Thu, 31 May 2007 02:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755694AbXEaAXj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 20:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752886AbXEaAXj
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 20:23:39 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:49839 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752887AbXEaAXi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 20:23:38 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HtYRm-0002U8-Kg
	for git@vger.kernel.org; Wed, 30 May 2007 20:23:22 -0400
Received: from proski by gnu.org with local (Exim 4.66)
	(envelope-from <proski@gnu.org>)
	id 1HtYRx-00013m-M4; Wed, 30 May 2007 20:23:33 -0400
In-Reply-To: <e5bfff550705301118k4ca8720bna260e171f0eb83ca@mail.gmail.com>
X-Mailer: Evolution 2.10.1 (2.10.1-4.fc7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48792>

On Wed, 2007-05-30 at 21:18 +0300, Marco Costalba wrote:
> My (crazy) idea is:
> 
> - Let switch from message to diff content scrolling down after the end
> of message.
...

I'll appreciate if you follow standard conventions for standard GUI
actions and don't change the behavior of such basic keys as arrows.

It would be better to use something more advanced for application
specific behavior.  I belong to the post-vi generation, so my mind
cannot easily associate letters (like 'i' and 'k') with up and down
actions.  But we could use some key combinations with obvious
"directional meaning", such as Ctrl-arrows.

I've said it before, and it's worth repeating - any key must be
discoverable through the GUI.  No key or feature should be discovered by
accident - it would be a sign of bad design.

> So I imagine two labels for each content type:
> 
> - for message content a top right label called "Up" and one in bottom
> right position called "Diff"
...
> I plan also to change the labels in something more intuitive with
> scroll action, as example adding an up and down direction little
> arrows next to them.

I'm afraid it would misuse the paradigm of labels.  It should be
buttons, perhaps in the toolbar.

> P.S: In case someone wonders what's the goal of this label madness. It
> is to be able to browse a repo in either both sequential directions,
> up or down, using only the mouse wheel.

It may be a cool feature, but users don't expect the mouse wheel to
change anything other than position of the text.  Switching the revision
by the scrolling the wheel would be a feature discovered by accident.

-- 
Regards,
Pavel Roskin
