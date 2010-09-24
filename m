From: Elijah Newren <newren@gmail.com>
Subject: Re: 'git diff' against files outside a git repo
Date: Fri, 24 Sep 2010 16:30:19 -0600
Message-ID: <AANLkTik4kL8Mao1VM=njNxFSXOY7guwuEZgmpv0UTc8R@mail.gmail.com>
References: <AANLkTinR7BJpD-FOS_DShg=r0ucF2C9oE6p-YoZU-5En@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 25 00:30:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzGmg-0003Nu-NZ
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 00:30:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758325Ab0IXWaV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Sep 2010 18:30:21 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42287 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758317Ab0IXWaV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Sep 2010 18:30:21 -0400
Received: by fxm3 with SMTP id 3so1013913fxm.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 15:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GxlNLDr7hI0N653CzQ6dowuQosFV4WiOZnxC0qR48TQ=;
        b=hSliHO+663tReJP9IuxCkOhmpz7iOl2CS6+f+QLkbFWLC2SAOxg/QUBIPxxUEAj0J3
         ySRDuVWl+gVMQJF87FmO532g54TBEvJNxvTwdQU1AvQPBGZCv5Dc/0Ry0LMexhi19nQk
         d61F5rfn+359KK3zeeu12wqju4bjx3qrk8fGE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=I6S5rqk1BGIsiNxMiV3qzkfLi+JWZ5F0At/py5HQ5B7fK9OxLuMSKSDZhd84G+WtMP
         gbeQ2XlpxMMh5l795sNRzui1UdrGEONutNcJ7vq1wEWnEZywrDQctXs7GCZdskoB6hQ0
         geOPcLkOGMJQdwys/jQRKup5oD06Fbmm8KoNE=
Received: by 10.223.112.204 with SMTP id x12mr4245244fap.24.1285367419799;
 Fri, 24 Sep 2010 15:30:19 -0700 (PDT)
Received: by 10.223.119.209 with HTTP; Fri, 24 Sep 2010 15:30:19 -0700 (PDT)
In-Reply-To: <AANLkTinR7BJpD-FOS_DShg=r0ucF2C9oE6p-YoZU-5En@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157090>

On Fri, Sep 24, 2010 at 4:23 PM, Avery Pennarun <apenwarr@gmail.com> wr=
ote:
> Hi all,
>
> I'm interested in using 'git diff' on some files that aren't actually
> inside a git repo at all. =C2=A0Specifically, the --color-words and
> --word-diff-regex are really cool and I happen to have a use for them
> on files that aren't stored verbatim in git. =C2=A0As a whole, git's
> implementation of diff seems to be the fastest-moving one out there,
> so I'd rather use it instead of another random diff implementation.
>
<snip>
> Is there already a way to get 'git diff' to do this?
>
> If not, would it be sensible to extend git-diff to do comparison
> between two outside files?

Isn't this what git diff --no-index ... does?
