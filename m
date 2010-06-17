From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] Allow hashes in git rebase --interactive --autosquash.
Date: Thu, 17 Jun 2010 09:17:47 -0400
Message-ID: <AANLkTikJtNXg7Eac5CQkMBXt14tu8G7Kaxy-3t1wmhBF@mail.gmail.com>
References: <20100617125746.E86B42FC00@perkele>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Thu Jun 17 15:17:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPEyj-0002FZ-BI
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 15:17:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759978Ab0FQNRw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jun 2010 09:17:52 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64882 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759923Ab0FQNRu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jun 2010 09:17:50 -0400
Received: by iwn9 with SMTP id 9so6771708iwn.19
        for <git@vger.kernel.org>; Thu, 17 Jun 2010 06:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=LvFDWyPi6ZWFmZz1DTBnRFyQ0We33qRKwof/OxBSQK0=;
        b=MJ1F0We1jcWUVYskafgF5edls3CJFyfPj7ll8Voa+ByNsYujEtiPIjhJIdeZj76h5Y
         6Dz+PLCsDkZm+KFg4gO+dXOnZ1XsjXTQlVWcNsRxj9KXEl4QtPQalDfzS7FyvjZ2MYe8
         0KmGUjrWQHoSPcXusd76AnRDw8Rthnsbuno7M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=n2d+/+ndPbX81V55Fr79wfBCbvin1MpWgdFnhOAS6aw/aSVBLDU5C6Fljfva+sivyt
         pG2gDDyZmztwweTqFvd+CJ8G55XbN3PS2/EBxrxuOhgTW3lMMrVTS8CvVaFlZgrv1FDR
         vHnFQWfcGq/ROGK3mzMdQNtFEbqdSOT+RDajo=
Received: by 10.42.0.68 with SMTP id 4mr3672815icb.93.1276780668805; Thu, 17 
	Jun 2010 06:17:48 -0700 (PDT)
Received: by 10.231.120.19 with HTTP; Thu, 17 Jun 2010 06:17:47 -0700 (PDT)
In-Reply-To: <20100617125746.E86B42FC00@perkele>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149305>

On Thu, Jun 17, 2010 at 8:55 AM, Peter Krefting <peter@softwolves.pp.se> wrote:
> In addition to matching the "fixup!" and "squash!" commits to the commit
> message, also match the commit hash. This allows a commit message like
> "fixup! e83c5163316f89bfbde7d9ab23ca2e25604af290" to be detected as a
> fixup commit.
>
> Signed-off-by: Peter Krefting <peter@softwolves.pp.se>
> ---
>
> I actually misread the git-rebase manual page to think that this was how
> "fixup!" and "squash!" was supposed to be used, and now I have so many
> "fixup! <hash>" commits to rebase that I felt it worth it to implement
> support for it... :-)

Heh. I have this alias for creating my fixup commits:

$ git help fixup
`git fixup' is aliased to `!f() { git commit -m "$(git show -s
--pretty='format:fixup! %s%n%nFixup for %h%n' "$@")"; }; f'

:-)

j.
