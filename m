From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [RFH] QGit: how to cram a patch in a crowded screen
Date: Thu, 31 May 2007 07:39:50 +0300
Message-ID: <e5bfff550705302139q224ab949h7086478ab0045a8c@mail.gmail.com>
References: <e5bfff550705260146q51350f40q1c80cfe8079f47c6@mail.gmail.com>
	 <200705261034.53723.andyparkins@gmail.com>
	 <e5bfff550705261344l604543e7h64c20c1fc0979f20@mail.gmail.com>
	 <200705301408.37929.andyparkins@gmail.com>
	 <e5bfff550705301118k4ca8720bna260e171f0eb83ca@mail.gmail.com>
	 <1180571013.3582.32.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Andy Parkins" <andyparkins@gmail.com>, git@vger.kernel.org
To: "Pavel Roskin" <proski@gnu.org>
X-From: git-owner@vger.kernel.org Thu May 31 06:40:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtcSL-0001Q5-VY
	for gcvg-git@gmane.org; Thu, 31 May 2007 06:40:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753366AbXEaEjw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 May 2007 00:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757537AbXEaEjw
	(ORCPT <rfc822;git-outgoing>); Thu, 31 May 2007 00:39:52 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:63301 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753366AbXEaEjv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2007 00:39:51 -0400
Received: by wa-out-1112.google.com with SMTP id j4so50529wah
        for <git@vger.kernel.org>; Wed, 30 May 2007 21:39:50 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UtZFANTTjQl0XH3yhthN6Nabaq/xxa+/LOLMH1lSg6728KbPDl4SL9Y84/8iAuBzXLyfc05kMEvs2vHPRdbQZe6VhWlmSHATfByNNe48Oksb2hna1wzfbYx7Wsqiav9Tb9/ZXw/CPc7EjcVDYNqajkZIgqbHIFW6q9pdHeJicRI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g5wv8iP18KgkQnX2zGdjlGyuXP6IqLMoJqni96LDF62P/UC3W4+KxUqGK01Y6KTr01LlxaCskqnTV2NJ+Pj+p6MBaRXJr08EE7p8Mdn3rp2nM66GD+0r2acxU4oiSY4+Fnb2uPyM+wRXx/MetoxZYzl8nXrQLmaX1Eqw6ag11dc=
Received: by 10.114.175.16 with SMTP id x16mr243605wae.1180586390343;
        Wed, 30 May 2007 21:39:50 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Wed, 30 May 2007 21:39:50 -0700 (PDT)
In-Reply-To: <1180571013.3582.32.camel@dv>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48799>

On 5/31/07, Pavel Roskin <proski@gnu.org> wrote:
> On Wed, 2007-05-30 at 21:18 +0300, Marco Costalba wrote:
> > My (crazy) idea is:
> >
> > - Let switch from message to diff content scrolling down after the end
> > of message.
> ...
>
> I'll appreciate if you follow standard conventions for standard GUI
> actions and don't change the behavior of such basic keys as arrows.
>
> It would be better to use something more advanced for application
> specific behavior.  I belong to the post-vi generation, so my mind
> cannot easily associate letters (like 'i' and 'k') with up and down
> actions.  But we could use some key combinations with obvious
> "directional meaning", such as Ctrl-arrows.
>
> I've said it before, and it's worth repeating - any key must be
> discoverable through the GUI.  No key or feature should be discovered by
> accident - it would be a sign of bad design.
>

yes I agree with you. The only thing that until now stopped me to add
buttons to tool bar is that it seems to me already over crowded. But I
agree keys should be discoverable. Also regarding arrow keys, they
still have the same good old action to go up and down in text content,
and will keep that.


> > So I imagine two labels for each content type:
> >
> > - for message content a top right label called "Up" and one in bottom
> > right position called "Diff"
> ...
> > I plan also to change the labels in something more intuitive with
> > scroll action, as example adding an up and down direction little
> > arrows next to them.
>
> I'm afraid it would misuse the paradigm of labels.  It should be
> buttons, perhaps in the toolbar.
>

The idea of labels comes from using gmail, where in long threads you
can see the following with a coloured label with an arrow and the name
of the sender.

The labels, used in this way and decorated with small up and down
arrows, give more the meaning of "scroll down to see what's next" then
using a button, but when yhe machinery is implemented it should be
straightforward change from labels to buttons and test also with them.


> > P.S: In case someone wonders what's the goal of this label madness. It
> > is to be able to browse a repo in either both sequential directions,
> > up or down, using only the mouse wheel.
>
> It may be a cool feature, but users don't expect the mouse wheel to
> change anything other than position of the text.  Switching the revision
> by the scrolling the wheel would be a feature discovered by accident.
>

Yes, this problem is still open. I think the key is the graphical
rapresentation of the labels/butons and their placement inside the
window to give the user the hint that when scrolling with the mouse
he'll reach what's advertised in the label. Again gmail use of "go to
next thread" labels gave me some ideas.


Thanks
Marco
