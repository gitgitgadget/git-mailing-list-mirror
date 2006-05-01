From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: cvsserver problem with eclipse?
Date: Tue, 2 May 2006 08:38:45 +1200
Message-ID: <46a038f90605011338i5498f857lf230d9a965aa759@mail.gmail.com>
References: <4455B863.8040808@mobilereasoning.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 01 22:38:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FafAP-00040m-Jr
	for gcvg-git@gmane.org; Mon, 01 May 2006 22:38:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbWEAUir (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 May 2006 16:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbWEAUiq
	(ORCPT <rfc822;git-outgoing>); Mon, 1 May 2006 16:38:46 -0400
Received: from wproxy.gmail.com ([64.233.184.239]:20687 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932237AbWEAUiq convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 1 May 2006 16:38:46 -0400
Received: by wproxy.gmail.com with SMTP id i21so2149859wra
        for <git@vger.kernel.org>; Mon, 01 May 2006 13:38:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DEzStePGUcdR1rtr10N8hc9eKWoyh85Oer5GscfrCCidKiZlgfu0bkOQD0XYMmI2BJu4bW5TM3Zutfz2tLmkfqBPN1+vVeTnVX5kL2k5iU9YRSTDOI+n3ZAh7b/qH84DL6IXqmPXeqQdRgwjC6l6VCZ/6klik/do6cFKAa9T1A4=
Received: by 10.54.127.13 with SMTP id z13mr1171984wrc;
        Mon, 01 May 2006 13:38:45 -0700 (PDT)
Received: by 10.54.127.4 with HTTP; Mon, 1 May 2006 13:38:45 -0700 (PDT)
To: "Bill Burdick" <bill@mobilereasoning.com>
In-Reply-To: <4455B863.8040808@mobilereasoning.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19387>

On 5/1/06, Bill Burdick <bill@mobilereasoning.com> wrote:
> OK, I changed the way I was testing this to match your usage plan and I
> still got the same results.  It works just fine for vanilla CVS; cvs
> status shows the re revision in the repo and cvs update brings it in.

That's a good start!

> Eclipse has the same funky behavior: Compare with latest at the project
> level shows no differences, but compare with latest on the changed file
> actually does an update instead of popping up the Eclipse diff viewer.

Hmmm. Eclipse does some weird funky sh*t sometimes. Can you ask it to
get you a log? There's an option in Eclipse CVS control settings that
will enable logging of cvs commands to the console. Enable it, and
then start Eclipse from the commandline, piping stderr and stdout to a
logfile.

There are also some weird differences depending on how you ask for the
update or diff. I hate doing this but I'll have to ask you to tell me
exactly how you ask for the diff and for the update.

And the platform you are running Eclipse on.

> By the way, I had trouble at first accessing the repo with SSH because
> of permissions on the sqlite db.  I'm not totally sure about the
> implications for multiple users, but maybe just using a common group
> will work fine?

Yes, a common group is the thing to do.

  $ chgrp gitusers *sqlite
  $ chmod g+w *sqlite

> I'm really happy with git and git-cvsserver!  I'm hoping to be able to
> standardize on it for our Eclipse work.  It seems like it should be

Great to hear that!

cheers,



martin
