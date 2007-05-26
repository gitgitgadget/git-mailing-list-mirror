From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [RFH] QGit: how to cram a patch in a crowded screen
Date: Sat, 26 May 2007 22:44:28 +0200
Message-ID: <e5bfff550705261344l604543e7h64c20c1fc0979f20@mail.gmail.com>
References: <e5bfff550705260146q51350f40q1c80cfe8079f47c6@mail.gmail.com>
	 <200705261034.53723.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Pavel Roskin" <proski@gnu.org>
To: "Andy Parkins" <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 26 22:44:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hs389-0006sX-DV
	for gcvg-git@gmane.org; Sat, 26 May 2007 22:44:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764063AbXEZUob (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 16:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764359AbXEZUoa
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 16:44:30 -0400
Received: from nz-out-0506.google.com ([64.233.162.231]:15207 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761665AbXEZUo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 16:44:29 -0400
Received: by nz-out-0506.google.com with SMTP id n1so618633nzf
        for <git@vger.kernel.org>; Sat, 26 May 2007 13:44:29 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lysqSQZ/4+gastYGewrQhbAubbRb1NMze/poFdXotyXfa6sE3xeCE/WRPCWtOYKE+ajj8flxEnBGDsMs13jJJC38aFosDYEHC+T/Rp4x7psw52x6HsuGMKvxRZtf7LCrDFotAxMcDWnWjMCp/8QPup5m6G168hNpaXK+Y8b/yos=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CxeOZGgauleDVp6druvz0YftNkaXxHtSDWhBslxP860ODeuAzxeLBWgnUSKz581PmGTYbZhcn39mf8CCiXPYLEEs/cASA/AHWVqAHKKQmlmG/RIS0KlG4/7NcYsmHyDOOV4xk1/vGGMia40yrqU0bMeqCsb7suegST0q6Ax38fA=
Received: by 10.114.156.1 with SMTP id d1mr2107152wae.1180212268512;
        Sat, 26 May 2007 13:44:28 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Sat, 26 May 2007 13:44:28 -0700 (PDT)
In-Reply-To: <200705261034.53723.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48492>

On 5/26/07, Andy Parkins <andyparkins@gmail.com> wrote:
>
> For example, the log view widget would show:
>
> <Header>
> <Log Message>
> <Patch>
>
> All visually distinct to improve searching by eye (perhaps including
> clear separators between files patched).  Then the file list could
> include a "<header>" psuedo-file that would jump back to the top of the
> viewer.
>

This seems really gitk like. Not that I don' t like it, but _if_ it's
possible I would prefer something a little bit more original.

>
> Here's another option, keeping the patch tab, but putting the tab widget
> in the log view window.  That way the list would be visible and you
> would just switch between the log and the patch.
>

Yes. More or less along the lines of an handful of patches I've just
pushed to git://git.kernel.org/pub/scm/qgit/qgit4.git

Now user can toggle between revision commit message and patch content
with the menu entry 'View->toggle message/diff', or with shortcut 'm'
or also with mouse clicking on top right links 'Diff->' and 'Log->'.

There is also a check box in 'Edit->settings' called 'Show always
revision message as first' that, if set, let automatically to switch
to revision message when browsing on a new revision.

With this, browsing on a repo reading both log message and patch it's
a matter of 2 clicks or 2 shortcuts per revision, one for changing
revision (and read the log message) and another to view the patch
content.

This is a good speedup from before when we needed 3 commands, one for
selecting the rev, one for switching to patch tab and viewing the diff
and one for switching back to main list.


Comments? like/dislike?

Thanks
Marco
