From: Jacopo Notarstefano <jacopo.notarstefano@gmail.com>
Subject: [GSoC14][RFC] Is there any interest in adding a port of checkpatch.pl
 to contrib/?
Date: Tue, 18 Mar 2014 02:38:04 +0100
Message-ID: <CAL0uuq0RWpWPa2TOk09xE9SjG0-Z=EAMG2iQ9Y0z_XMYvRsJ3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 18 02:38:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPiz3-0008Ba-Pk
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 02:38:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701AbaCRBiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 21:38:07 -0400
Received: from mail-ve0-f173.google.com ([209.85.128.173]:42566 "EHLO
	mail-ve0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582AbaCRBiF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 21:38:05 -0400
Received: by mail-ve0-f173.google.com with SMTP id oy12so6277215veb.18
        for <git@vger.kernel.org>; Mon, 17 Mar 2014 18:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=5T8OrcPqz/2M4TrMYy051DialDgsJCNJgwclcuGHhnM=;
        b=oXsdQWu8uh4Hd/fuBOrNuj8CxYQucMT1sTkM+7/uCaNQhTHbyNfEfx+q8KdeKEbwwY
         Q8mJd0nrDFXsjGbBGPi9FwkUANotJNuAIK4gDBA0yBRPehB2xXoV4dJcJdj/umtuyR/r
         n7y+fVglGLjZjKpkPYAvUI7Vr0jQu36aGqal64bHPO8n3j4mnr6r9Trcpnf+jmULDXAb
         qdy+cYDqgD1dfSp1/ldnJC3OdtCzWmuYzfcRRemPr+Y9BXp56TqIHn9GtZrQ3wjHiZYl
         lHjwC4gRnpXVRvhuZ4VvNzz2w/HIzx2n2zFtlEQUKqfVg6uUeRq3v0kaBnUopqeLxsL5
         WDrw==
X-Received: by 10.58.202.106 with SMTP id kh10mr1344976vec.31.1395106684492;
 Mon, 17 Mar 2014 18:38:04 -0700 (PDT)
Received: by 10.52.2.165 with HTTP; Mon, 17 Mar 2014 18:38:04 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244317>

It seems to me that the topic of adding the checkpatch.pl script to
Git's source tree has cropped up several times in the past, as
recently as a couple of days ago: $gmane/243607.

It should be noted that its usage for its sake has been discouraged by
Junio Hamano in $gmane/205998. Also, its use is somewhat controversial
and has led to flames and even a public fork.

Despite this, I think that git might benefit from a port of
checkpatch.pl. In fact, even Junio had admitted to use part of its
features later in $gmane/205998.

We could simply use linux's script/checkpatch.pl, but I think a port
is needed for these reasons:

1. Git style guidelines are somewhat different and less strict than
their Linux equivalents.
2. Several patch threads bounce back and forth because of style fixes.
A checkpatch script added as a hook could help reduce these and use
more efficiently our time.
3. As far as I can tell, checkpatch needs to be run from the root
folder of a linux repository clone. Cloning several hundred MBs for a
single perl script looks a little foolish to me.

So, is there any interest in adding a port of checkpatch.pl to
contrib/? I might work on this as part of GSoC. I still haven't
submitted my application about git bisect (life got in the way!), but
Michael Heggarty remarked in $gmane/242703 that my original idea had
too little meat in it to constitute a good GSoC proposal.

Cheers,
Jacopo Notarstefano
