From: Christian MICHON <christian.michon@gmail.com>
Subject: Re: Appropriateness of git for digital video production versioning
Date: Fri, 30 Jan 2009 11:13:54 +0100
Message-ID: <46d6db660901300213q21ad099w2b49ceba8690d51a@mail.gmail.com>
References: <8c4a72800901290736p4952e53byddca243f300dd8af@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Charles Earl <charles.cearl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 30 11:15:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSqPE-00078z-9I
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 11:15:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbZA3KN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 05:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751601AbZA3KN6
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 05:13:58 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:41984 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500AbZA3KN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 05:13:57 -0500
Received: by ewy14 with SMTP id 14so631810ewy.13
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 02:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RqeycW6wV4l30EOdiZL60GCDwRtiDS9J5Y3/UVtGMfA=;
        b=aJ0m9mgxwPVRT0zZ375kb0wTbJDkSOgs6ldsXnsZsBfpGMbycd79oRP1CQCqH+TkFZ
         eg7LA2LRMzWCgUtA+9gV37GBd8BX6voj0NKEtzG9GQeCQC5dZTqzIdqb8fBeKHAgSl52
         8BZPoN9YnpDLpok41+NexD/09GFlj5mZeJWC8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=O93VWkpth5EbICyV3k2/BuRobA0njUMW6BWF8NU+L74mdbM5epictGRQ7eAquHk7kA
         oqWxcz4GNU5InpNgSpzjEdeQubsAS+jP43/I5Uto4BTqslcoLrcf2jy7Z/IHPAKL0PjY
         IF4aLPGSyId2s6UtomFFQvC0V0hgn1A+9f6KE=
Received: by 10.103.119.19 with SMTP id w19mr499262mum.80.1233310434966; Fri, 
	30 Jan 2009 02:13:54 -0800 (PST)
In-Reply-To: <8c4a72800901290736p4952e53byddca243f300dd8af@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107786>

On Thu, Jan 29, 2009 at 4:36 PM, Charles Earl <charles.cearl@gmail.com> wrote:
> Hi,
> Are there past instances of git having been adapted to support version
> control of digital media production workflow?
> I'm evaluating CMS and versioning systems for the backend of a SaaS
> for digital media production workflow.
> The bulk of content stored is binary data -- there have been posts on
> this about integration of various binary diff implemetations with git.
> The versioning of metadata, scripts, project structure seems to argue
> for applicability of system such as git -- these fit the paradigm of
> traditional scm.
> Example content is from media production suites such as Adobe After
> Effects/Premier: video, compositions, etc.
> I'd also like the object storage to be in S3/Amazon BlockStore or
> similar remote stores.
> Charles
> --

for what it's worth (call me crazy, call me sick), I used msysgit only
on the project files from Windows Movie Maker (not on the media files,
but the timeline and my personal cuts, etc...).

it works perfectly, so (whatever system you're using) my advice would
be identify the small files and formats saved by your video editing
software (I see xml files are usually used there), only add these in
the git repository and make sure the video inputs and outputs files
are in .gitignore

doing so, you have a fast and cheap tracker of your timeline edition,
splitting and joining of video files.

HIH

-- 
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git inside !
