From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Fwd: More qgit defects 2/2
Date: Sun, 30 Apr 2006 10:19:58 +0200
Message-ID: <e5bfff550604300119s7afe7b0p1e808b85cab43f81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Sun Apr 30 10:20:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fa79t-0001IB-Mi
	for gcvg-git@gmane.org; Sun, 30 Apr 2006 10:20:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbWD3IT7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Apr 2006 04:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751058AbWD3IT7
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Apr 2006 04:19:59 -0400
Received: from wproxy.gmail.com ([64.233.184.229]:62994 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751053AbWD3IT6 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Apr 2006 04:19:58 -0400
Received: by wproxy.gmail.com with SMTP id 58so393061wri
        for <git@vger.kernel.org>; Sun, 30 Apr 2006 01:19:58 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=M4KpIylAu7lUw9Ii/0zcBSgcgSSiZF3c2nXuK80P2s+RpyTh6rJO7G2yUpe+TM7VdIMxbG9HA55+D+VRLNf6CRfrNOtXpZ4Bf/oVJtMqrvfJEKM4dI6DqrjJXRnuQy0+ehq+2UALkXC6DuPBse866+KR88bB6tuv4RWySBVln1g=
Received: by 10.64.178.16 with SMTP id a16mr1745677qbf;
        Sun, 30 Apr 2006 01:19:58 -0700 (PDT)
Received: by 10.65.163.11 with HTTP; Sun, 30 Apr 2006 01:19:58 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19331>

I would like to forward this thread to the list in case someone find
it interesting and/or suggests improvements.

---------- Forwarded message ----------
From: Marco Costalba <mcostalba@gmail.com>
Date: Apr 30, 2006 10:11 AM
Subject: Re: More qgit defects
To: Pavel Roskin <proski@gnu.org>
Cc: ydirson@altern.org


Hi Pavel,
>
> I think the list items in the file window need a pop-up menu.  Without
> it, the users would not be able to discover what e.g. the double click
> would do.
>

yes, I agree.

> More generally, I feel that something is wrong with the user interface.
> I think gitk is doing it better with a single pane that has the comments
> and the diff.  Splitting the window horizontally in three panes seems to
> be too much, especially when one of the panes is used for diffs.
>

Please Pavel pull from latest qgit repo. I just pushed a patch that,
at least for my
browsing style, fixes this and IMHO is better then gitk.

Patch description is as follow:
"Usability enhancement: use 'P' key to quick toggle patch viewer

   One of the limitation of patch browsing in qgit is the use of two
   frames, one for revision logs and the other for patch viewer.

   If patch viewer is docked the space is normally limited by revision
   log frame. If patch viewer is undocked it is always at top level and
   hides main view and revision logs.

   So this patch adds a new key binding 'P' that hides/unhides diff
   viewer window.

   The intended use is simple: open patch viewer and undock it so to cover
   a good chunk of screen space, then press 'P' key and diff viewer will
   disappear.

   Now you can browse the revisions as usual and toggle diff viewer with 'P'
   key so to easily view both logs and patches without any space constrains.
"

After a little bit of using I have found this way very natural, quick
and, especially important for me, do not compromise patch view size.

What I do is to size the undocked patch viewer on my left screen, and
toggle the P key, but other adjustment are possible, see:

http://digilander.libero.it/mcostalba/qgit_P_1.png
http://digilander.libero.it/mcostalba/qgit_P_2.png

Tip: let your mouse be always over main list view so that patch view
does not steal the focus and you can browse only with keyboard arrows
as well with new key bindings (see F1).

Let me know what you think.

               Marco
