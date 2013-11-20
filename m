From: "Jason St. John" <jstjohn@purdue.edu>
Subject: Re: [PATCH] Fix typesetting in Bugs section of 'git-rebase' man page
 (web version)
Date: Tue, 19 Nov 2013 20:12:33 -0500
Message-ID: <CAEjxke-C1H1NpD=Hmiz6MO3OjtPvkUktKvF7zSqfGnruHQ9-Ew@mail.gmail.com>
References: <1384906483-15260-1-git-send-email-jstjohn@purdue.edu> <20131120003130.GC4212@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 20 02:13:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViwLk-0000bq-Me
	for gcvg-git-2@plane.gmane.org; Wed, 20 Nov 2013 02:13:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753215Ab3KTBM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Nov 2013 20:12:56 -0500
Received: from mailhub246.itcs.purdue.edu ([128.210.5.246]:59562 "EHLO
	mailhub246.itcs.purdue.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752342Ab3KTBMz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Nov 2013 20:12:55 -0500
Received: from mail-qe0-f52.google.com (mail-qe0-f52.google.com [209.85.128.52])
	(authenticated bits=0)
	by mailhub246.itcs.purdue.edu (8.14.4/8.14.4/mta-auth.smtp.purdue.edu) with ESMTP id rAK1CsZh026836
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Tue, 19 Nov 2013 20:12:54 -0500
Received: by mail-qe0-f52.google.com with SMTP id cz11so5320272qeb.39
        for <git@vger.kernel.org>; Tue, 19 Nov 2013 17:12:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Me4dhG5pf0l2qu+E+KpX4GI0Uw6rRyTxCBIwuEO4CPY=;
        b=LhoDKYujQOfk+JOmm40xqVS3ZcGP9G42c46xcr0rak++RiYnqPEA64OUJBCxE7j8dh
         FvDCXZLpfnrfuEWIRWCnx2gLg2bqyd59cnjtyjhyBHcKxwxxxOxT8KbFPjQzF1r4mGg4
         SB+AlZkz2geB7YeIeGTYo6yAVZMGTNbITl4lutJyFWDJDiNajGY90Zh4Bcc5cV9QxC3q
         6qYAr/wJTKdQsaHIRrmnAvL0t3MszEKTfTDmacpU7xTbN35ZY9w1SUtsU5Q5DaA0OtWb
         4rKmH/C/njsWYn/HqaFHGj24CB5Cr9B8PXcZlBHbDTvrs8iDwY/7o2UXILZUNi/Zm2a8
         mvKA==
X-Received: by 10.224.69.132 with SMTP id z4mr47597915qai.78.1384909974310;
 Tue, 19 Nov 2013 17:12:54 -0800 (PST)
Received: by 10.224.127.131 with HTTP; Tue, 19 Nov 2013 17:12:33 -0800 (PST)
In-Reply-To: <20131120003130.GC4212@google.com>
X-PMX-Version: 6.0.2.2308539
X-PerlMx-Virus-Scanned: Yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238058>

On Tue, Nov 19, 2013 at 7:31 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Jason St. John wrote:
>
>> Documentation/git-rebase.txt: add a blank line after the two AsciiDoc
>>     listing blocks
>
> I'd leave out the above two description lines, since they're redundant
> next to the patch text.
>

I included that because SubmittingPatches says to do so.

>> Without these blank lines, AsciiDoc thinks the opening "-----" is a
>> section heading and typesets the word "to" as such, which causes
>> cascading formatting/typesetting issues until the end of the document.
>
> Interesting.  Alas, I can't reproduce this.
>
> Are you sure it is AsciiDoc that misinterprets the document, and not,
> e.g., the predecessor of asciidoctor in gitscm-next?
>

I regrettably must admit that I didn't test this before submitting, so
I had presumed that it was AsciiDoc itself.

> Do
>
>   Documentation/git-check-attr.txt
>   Documentation/git-commit.txt
>   Documentation/git-cvsserver.txt
>   Documentation/git-p4.txt
>   Documentation/git-svn.txt
>   Documentation/gitcli.txt
>   Documentation/gitweb.txt
>   Documentation/mailmap.txt
>
> avoid this problem?
>
> Thanks and hope that helps,
> Jonathan

All of the files you referenced appear to render okay except for
git-svn.txt and gitweb.txt.

Documentation/git-svn.txt:
* Commands | fetch | --ignore-paths
* Commands | dcommit | --commit-url
* Commands | dcommit | --mergeinfo
* Commands | reset | --parent
* Caveats (third paragraph)
See http://git-scm.com/docs/git-svn#_commands and
http://git-scm.com/docs/git-svn#_caveats

Documentation/gitweb.txt:
* This cascades from the virtual host config file example until the
Bugs section.
See: http://git-scm.com/docs/gitweb#_webserver_configuration_with_multiple_projects'_root

Based on this and the source files, I suspect the problem lies with,
for example, the predecessor of asciidoctor in gitscm-next.

How do you recommend I proceed? Should I resubmit with just a revised
commit message? Should I incorporate this into a larger patch set that
should fix all of the errors in git-rebase.txt, git-svn.txt, and
gitweb.txt?

Thanks,
Jason
