From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Fwd: qgit 2.1 questions about range selection
Date: Mon, 31 Dec 2007 12:53:16 +0100
Message-ID: <e5bfff550712310353k64ae0991vcd293dae565a0ce@mail.gmail.com>
References: <771EDDAF-F479-45F7-AB85-F7B6603FB061@zib.de>
	 <e5bfff550712310352j3245511chbbd301d35e09204b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 31 12:53:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9JDF-0003Oq-MB
	for gcvg-git-2@gmane.org; Mon, 31 Dec 2007 12:53:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757258AbXLaLxS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2007 06:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757224AbXLaLxS
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Dec 2007 06:53:18 -0500
Received: from rv-out-0910.google.com ([209.85.198.188]:56437 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756314AbXLaLxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2007 06:53:16 -0500
Received: by rv-out-0910.google.com with SMTP id k20so4525857rvb.1
        for <git@vger.kernel.org>; Mon, 31 Dec 2007 03:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=orir33Cz7kTKqoGWcX+D5Y484XNojMZqiAlJc4PFfcg=;
        b=ZFgeecbgA5tYfasSeLlBLjav0wg15JzG9McIAb6veWw1Dt5ES1VfnkNw6evYLKZRYk5SuCo/Ld8LCFMDJmBDXlZWa2KZY1dZmAL8Qmw/iXX0audyV8XI1lOoWXkcaVva/ZBizQhWEuSXRXAsUdVREaqA7gDD0a37d+MC39rpS3M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kB3dJZ1hJupJZNceDuSt1sBUCqoFKnU4M6AWl93InSy4GDw8Sm3Dbk54D+n+JsfO+89uGIxLwMiSPqyer9FWym1eGtYZ61Sazp4iBRCHYnBdqaFAY/Txyb4iAkIqE8rrTAK5vjFd9/FAfvKkQyfR8OZF5heY14dLnI4CVl4i1Ao=
Received: by 10.141.178.5 with SMTP id f5mr6252686rvp.191.1199101996242;
        Mon, 31 Dec 2007 03:53:16 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Mon, 31 Dec 2007 03:53:16 -0800 (PST)
In-Reply-To: <e5bfff550712310352j3245511chbbd301d35e09204b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69401>

---------- Forwarded message ----------
From: Marco Costalba <mcostalba@gmail.com>
Date: Dec 31, 2007 12:52 PM
Subject: Re: qgit 2.1 questions about range selection
To: Steffen Prohaska <prohaska@zib.de>


On Dec 31, 2007 11:42 AM, Steffen Prohaska <prohaska@zib.de> wrote:
> Hello Marco,

Hi Steffen,

   I hope you don't mind if I forward this also to the git list.

Your questions are interesting, and I think could be useful also for
other people.

>
> Here is a first impressions and some questions about the range
> selection, which I find pretty hard to understand.
>
>   - The "Range select" dialog.
>     * It is displayed upon startup or when I open a new
>       repository.  But I haven't found a way to access "Range
>       select" from the menus.  I'd expected to find it as
>       "View > Range select".

Currently the only way is to open (with File->open or "open folder"
the tool button or with File->last opened repos list ) again the
_same_ repository. I understand is not the best way. Your suggestion
"View->range select" it seems a better idea.

>     * The dialog's "Top:" and "Bottom:" drop downs apparently contain
>       tags or "HEAD".  Why can't I select a specific branch?  I'd
>       expected this here, too.

You can write anything you want in top and bottom fields, they are not
read-only, so you can write a branch name or anything understandable
by 'git log'. You can also clear one filed, as example the bottom
field to have all the revisions until the initial one.

>     * The dialog's "Top:" and "Bottom:" fields are reset to a
>       default each time the dialog opens.  Why aren't the last settings
>       preserved?

Mmmmm, why not? this goes in the same playfield of "View->Range select", thanks.

>     * I find the toggles "Working dir" hard to understand.  Why
>       not always showing the working dir?  Why not displaying
>       differences to the index (as gitk does with the "green"
>       commit)?

Well differences in the index _are_ displayed with an "orange" commit
(from a long time ago also, much more then gitk BTW). The reason is
not selected by default is that on big repos, as Linux, checking for
working dir changed files takes very long and is not useful for people
that just wants to pull Linux and take a look atthe updates. Anyhow
you can always toggle this directly right clicking anywhere in the
main revision list. A pop up menu appears and "Check for modified
files" is the first entry.


>     * Similar for the toggles "All branches", "Whole history".
>       Maybe "All branches" could be included in the "Top:" drop down
>       and "Whole history" could be included in the "Bottom:" drop down.
>

There should be some tooltips that help here. But again Top and Bottom
are only range delimiters, what happens is that if you write A in the
top field and B in the bottom field git log is called with : git log
A..B

>   - The parameters of the current range selection are not obvious.
>     After closing the "Range select" dialog the history is
>     displayed.  But where can I see the parameters of the
>     selection?  I'd have expected to see an indication which
>     branches, tags, whole history, ...  I selected.  Indications
>     of this are scattered over the GUI. For example, a filter can
>     be toggled on in the tool menu bar and is greyed out if
>     activated.  Or "FILTER ON" may be displayed in the window
>     title.
>

Well there is already a "Filter ON" but is for a more advanced feature
then range select. Simply, from main list, press key 't' to show tree
view, then select some files/directories (multi selection is allowed),
then press the magic wand toolbar button: that's the FILTER ON (and
you see on the window caption BTW)

>   - "Toggle filter by tree" seems to switch to "--all".  I see
>     more commits than I expect.  I'd have expected that this
>     toggle adds a boolean "and" to the selection; that is the
>     current view would be restricted to commits touching the
>     selected path.
>

Mmmmm, if this is the case it's a bug. Thanks I will investigate.

> Maybe the range selection could be unified in the following way.
> The selection is represented as multiple lines; each line
> representing part of the selection parameters.  All lines together
> act as a boolean expression selecting the commits.  Each line
> contains drop down boxes and text fields (or other GUI elements).
> The selection filter is displayed below the tool bar and the
> tab containing the "Rev list"; or it should be included in the
> "Rev list".  For example, the following lines would select the
> commits on branch pu, not on master, touching file help.c
>
>   - Selection: [label]
>   - Branch [drop down],         origin/pu [drop down],
>   - Not on branch [drop down],  origin/master [drop down],
>   - File [drop down],           help.c [text field],
>
> Each line contains "-", "+" buttons to remove this line or add a
> line below.  The very first line has a button "+" to add a line
> at the very bottom.  I attached a snapshot of the Mac OS X
> Smartfolder GUI to illustrate this.
>
>

That's nice!

Currently you can use the "Additional options" field at the bottom of
range select to write a free text that will be pasted directly to the
git log command line arguments.


>
>
> Btw, is the git mailing list the right forum to discuss such
> suggestions?
>
> If so, feel free to reply with CC to git@vger.kernel.org.
>

Already done ;-)

Thanks
Marco
