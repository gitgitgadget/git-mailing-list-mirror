From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2012, #10; Thu, 26)
Date: Fri, 27 Apr 2012 08:08:13 -0400
Message-ID: <CAFouetivNPz4nfsSp5BfhACL06Rh+mj20hGzAvip5XkinUJ9Rw@mail.gmail.com>
References: <xmqqlili6xfu.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 27 14:08:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNjyG-0003iJ-Ga
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 14:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760119Ab2D0MIP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Apr 2012 08:08:15 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43876 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759994Ab2D0MIO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Apr 2012 08:08:14 -0400
Received: by iadi9 with SMTP id i9so939275iad.19
        for <git@vger.kernel.org>; Fri, 27 Apr 2012 05:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=SVHL8mi3wb67U7gGbx6mzUXf7rIHA2bDc4VX9wE6Hts=;
        b=hfS5ZzecwQ3awB97gFSXhW+hyKYkktHC3F+pV86TjtiLFnAPj6OGSaYrEiEXKXbSDu
         eZbFxHd6xOPQ4pbwdqRRA2yudRMHGf+l6IcUoJY81QS+uX4tOcZZJrH3qqKvJdAPeibs
         NLl+sdjC4XT/SSzxyEoEF1BcIuKrkNwZthxZql+JC3vu22YcJyCLbZYBeIxFH6HpWWYi
         2r5QA+yFSEVrtfVhNNZ/7l9+YJH9JlJKZOpWfgmzSNTyY/GL++PxV0YQLqpODMWGSH0s
         UY8g4Z3HMo9FyTEcZVwHc1lsIrlvFPauO0GXHV6wIhooSlgfrJiC1oJa9IP5syHFkDze
         251A==
Received: by 10.50.187.226 with SMTP id fv2mr2113355igc.40.1335528494022; Fri,
 27 Apr 2012 05:08:14 -0700 (PDT)
Received: by 10.42.225.193 with HTTP; Fri, 27 Apr 2012 05:08:13 -0700 (PDT)
In-Reply-To: <xmqqlili6xfu.fsf@junio.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196467>

On Thu, Apr 26, 2012 at 4:38 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
>
> * th/difftool-diffall (2012-04-23) 8 commits
> =C2=A0- difftool: print list of valid tools with '--tool-help'
> =C2=A0- difftool: teach difftool to handle directory diffs
> =C2=A0- difftool: eliminate setup_environment function
> =C2=A0- difftool: stop appending '.exe' to git
> =C2=A0- difftool: remove explicit change of PATH
> =C2=A0- difftool: exit(0) when usage is printed
> =C2=A0- difftool: add '--no-gui' option
> =C2=A0- difftool: parse options using Getopt::Long
>
> Rolls the two-directory-diff logic from diffall script (in contrib/) =
into
> "git difftool" framework.
>
> Still being reworked.

I believe I have addressed all the review questions for this set and I
don't have any further changes planned right now.  Please let me know
if I missed anything.
