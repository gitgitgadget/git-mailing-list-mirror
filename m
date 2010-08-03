From: Eugene Sajine <euguess@gmail.com>
Subject: Re: CGIT 0.8.3.1 "chokes" on some bare repos
Date: Tue, 3 Aug 2010 11:57:13 -0400
Message-ID: <AANLkTi==+q28cS7ssz-E3vQ7xqoQxBM4Tj1Jf_SvuK0G@mail.gmail.com>
References: <AANLkTikcnv2dzY25dSgvKoTfLJ416gcaeDZA5HGa_tue@mail.gmail.com>
	<AANLkTinab6BkUqZnUE3yxmgY_lKyp0TbYUPYbKkoUKMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 03 17:57:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgJrl-0004ks-7A
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 17:57:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756377Ab0HCP5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Aug 2010 11:57:15 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:60950 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755468Ab0HCP5O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 11:57:14 -0400
Received: by qyk7 with SMTP id 7so260360qyk.19
        for <git@vger.kernel.org>; Tue, 03 Aug 2010 08:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=xT05eFvGJoVfY9Kg0RpiNHIWxCSAtNsb5otZUhOrku8=;
        b=aIDquW5WgVB/7BCxjHFqzvTxzSvxvql++yf8O4LyorFl0iGYIeFqRbRzZelAUW9/+C
         qxFO6gjV77Gns6YFQVHLZTUJpee5+Oh5CwYVJdvwpoXSt2njvL0p9/LgAcT/7ECGGJdj
         VKvySG0mQbMMMVRRyWH6HSj9RCzo9YHOnoxEo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=RYagTEzGcGpzbnHw6LrqXRclqrvoysg7HZGw0BfTVNyVtRddPdxVNeRS00+ltrbHo4
         QHQT75ja+Orc82zRnBQv6+PIXMiDiHxID4U0GgGfR6Ptf/kjQ+PNgq91tx0em5I4m3I+
         2v4olYqY0yjOeHtv2wLhSrwYU5OWt4MBEECTo=
Received: by 10.229.1.129 with SMTP id 1mr1249551qcf.163.1280851033458; Tue, 
	03 Aug 2010 08:57:13 -0700 (PDT)
Received: by 10.229.48.205 with HTTP; Tue, 3 Aug 2010 08:57:13 -0700 (PDT)
In-Reply-To: <AANLkTinab6BkUqZnUE3yxmgY_lKyp0TbYUPYbKkoUKMA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152523>

On Tue, Jun 22, 2010 at 1:14 AM, Lars Hjemli <hjemli@gmail.com> wrote:
> On Mon, Jun 21, 2010 at 23:34, Eugene Sajine <euguess@gmail.com> wrote:
>> Could you, please, advise how can i switch on some logging in CGIT so
>> it will trace all activity and tell me if there are some errors?
>
> There's no builtin logging, but running cgit.cgi under gdb (or even
> strace) should do the trick.
>
> --
> larsh
>

Lars,

I have a very strange issue with CGIT that i have no clue even how to diagnose.
We have about 250 git repos and counting and we are using CGIT to
browse all of them.

Everything works extremely well with an exception of few repositories
that when opened are not showing the tags or last commits.
I.e. when I'm looking at the source of the page i see that the HTML is
not fully generated. It stops right after it shows branches and commit
messages,
so effectively only third of a page is generated. The problem is that
it happens on selected list of repos - something seems to prevent CGIT
from completing the HTML generation...

I asked admins to run apache with "strace -f -o" and accessed a couple
of those repos. But i don't see any problems in the log... May be I'm
looking for wrong thing...

Any ideas?

Thanks,
Eugene
