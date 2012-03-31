From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: rebase -p loses amended changes
Date: Sat, 31 Mar 2012 16:55:22 +1100
Message-ID: <CAH3Anrqorf481jw6GdHqOPg9WC0rD-OraOHZ7twWRF4+oJ9X4A@mail.gmail.com>
References: <592E2EEC-6CBA-48D6-8D44-34A971DD78EC@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@student.ethz.ch>, jrobertray@gmail.com
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 31 07:55:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDrHc-0008PM-Uc
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 07:55:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278Ab2CaFzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Mar 2012 01:55:25 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:64720 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417Ab2CaFzX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2012 01:55:23 -0400
Received: by wejx9 with SMTP id x9so738948wej.19
        for <git@vger.kernel.org>; Fri, 30 Mar 2012 22:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BriX/6uAJBHHeDM6ps9WadmEtmBaN/3TbnxBaoLXo7s=;
        b=kBodv0SEOJrvoIhxHXHUpjt2Ryk/RXO46qclAkw98Y5c4GE+5GKLI1BervgfxfOFYR
         XwY+UkIrUzTW4Q3NxO9mgOmJN83lMFL+FPwOAEO7rYd7vhf4ItFIM5+bXoylEiQbRpwu
         k8TI8hb6+RZIKZ1E9bN+PkeZo5SoNtVPJNBXiosNh6p4oPN6xAViUfsEMbfdvkAydpAh
         BRE6fEDJKMGcc1RUZ4+rRwbgKvg1muB6ScIaboahuqahqmOEiy2MgkQi2jbdIwmqA84/
         HRGNAmaSgsuxhZTQaUyQ6xjKTVS9wGutRMrJVcgjrKEEwf/Uu+/cnREHLz27p9PZ2tYN
         2EFA==
Received: by 10.180.102.100 with SMTP id fn4mr3556672wib.1.1333173322561; Fri,
 30 Mar 2012 22:55:22 -0700 (PDT)
Received: by 10.180.82.35 with HTTP; Fri, 30 Mar 2012 22:55:22 -0700 (PDT)
In-Reply-To: <592E2EEC-6CBA-48D6-8D44-34A971DD78EC@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194434>

| My apologies to Thomas and Robert who also received my previous
attempts to send this to this list which were foiled by my iPad's
instance on sending HTML(via two different clients) and the mailing
list's (quite understandable) refusal to accept it.

On Sat, Mar 31, 2012 at 9:49 AM, Thomas Rast <trast@student.ethz.ch> wrote:
> J Robert Ray <jrobertray@gmail.com> writes:
>
>> If a merge is amended to add changes to a file unaffected by the
>> merge, these changes are lost after a rebase. Attached is a script to
>> demonstrate the problem.
> ...


>
> That's pretty much expected. rebase -p attempts to (conflicts will
> happen again) replay the merge.  I don't think anybody's come up with a
> clear idea of how to apply the conflicted or evil parts of the merge
> mechanically.
>

I wonder if there are any really good justifications for changing the
content, as distinct from the comments of a merge during an amendment?

If not, perhaps git could be a little bit noisy about the circumstance
at the point of the --amend commit?

jon.
