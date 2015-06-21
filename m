From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: 'eol' documentation confusion
Date: Sun, 21 Jun 2015 09:04:51 -0500
Message-ID: <CAHd499CapqvC3pHszgmX2VexdmqiW4+N23YfkAP5jjXWDrbe0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 21 16:04:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6frl-0005TP-5I
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jun 2015 16:04:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755733AbbFUOEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 10:04:53 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:37176 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755697AbbFUOEw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2015 10:04:52 -0400
Received: by igblr2 with SMTP id lr2so38884839igb.0
        for <git@vger.kernel.org>; Sun, 21 Jun 2015 07:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=wRt9A5H08fdDCzycgkcDXqCOzKBq8r9dkmqtLx1BmSo=;
        b=RfFrIDBcRs9c8nn+D2IpFE0bLRbwlnLP/Jnm/ynIQWnjI8jIZx5TmgZ1f8YLTlQPul
         Qkvuweu0JOK13Zxg24w8c+P6NbnbRzFtmsFh+uYS4CHwUlC+7gDBUhKLn6Quunhn4qoP
         Vl1R2IaWd9gQSlNtrCt3dQ1ngTZrjG1V5/TRhuOJTWce49TwnE6bnqWoP4QSSxM3BEjl
         B37zlKnRD8jtAi1QZe+RIt1oouVqbE3TnkPQZFBibz0aUJOUP4jftvEefUC4blrbTnus
         8d1uNytxCZiZZRbtStJhV0rRLytwjSTnM/xKBTKYShMZ0i5P/HZsgLcQyJkGxfMxFwrM
         KVjQ==
X-Received: by 10.50.64.147 with SMTP id o19mr15516762igs.33.1434895491766;
 Sun, 21 Jun 2015 07:04:51 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.36.86.148 with HTTP; Sun, 21 Jun 2015 07:04:51 -0700 (PDT)
X-Google-Sender-Auth: P-tj1sn40R1eB6OaOt1hm8CpQUc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272266>

Upon inspection of the gitattributes documentation page here:
https://git-scm.com/docs/gitattributes

When comparing the documentation for 'text' with 'eol', I see the
following missing explanations for 'eol':

* eol
* -eol

Maybe the fact that these are missing means they are not valid to use.
There is also the issue that `text` usually controls EOL anyway. Is
there ever any reason to set eol in a way differently than explained
in the documentation (that is, `eol=lf` or `eol=crlf`)?

For example, what if you want a file to be treated as text BUT you do
not want it to perform EOL normalization at all. Could you do this?

    foo.txt text -eol

Just at first glance, this to me would mean line endings on checkin
and checkout are not touched (CRLF could be checked in). Is this
possible?

What about setting `eol` but not `text`?

Honestly it seems like `eol` is just a supplementary setting for
`text` and was never intended to be used in ways that are
undocumented. Some explanation to help uncloud this would help, or
maybe I missed something in the documentation that explains this.
