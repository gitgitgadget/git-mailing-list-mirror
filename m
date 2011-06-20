From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH/RFC] Move contents of libgit.a to lib subdirectory
Date: Mon, 20 Jun 2011 11:55:58 -0300
Message-ID: <BANLkTimo71oftT2h4tXJhX7=zqjZipV3qw@mail.gmail.com>
References: <alpine.LNX.2.00.1106192014410.41113@linux.foleyremote.com>
	<BANLkTimjixOT=j9Xf=Ti-04cRw2noC0NiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Peter Foley <pefoley2@verizon.net>, git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jun 20 16:56:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYftT-0003tu-T0
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 16:56:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356Ab1FTOz7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jun 2011 10:55:59 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:64065 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262Ab1FTOz6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2011 10:55:58 -0400
Received: by yia27 with SMTP id 27so2109300yia.19
        for <git@vger.kernel.org>; Mon, 20 Jun 2011 07:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=gG4fUrk42eeiFjZ20tuZYarxfFeX4DfK23oUZQJM2s4=;
        b=IWgJSLbNufpOPGuos5NdSObXEPQJPG5kglAFtcewH63ucvGSdwArJt/bu1Fx1TMuXI
         Zl3H9Oe01+Q9C+x+uoVKwFx1rbe57IRwFusTacNviyfBliC8KUiDypZ+lYfbY89Chyc3
         9R72ui9zpmxvqf6zE5hx09H0yMP3V1g2OydBc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=R9JfRIKC+/x2mTSsPdWn/ArE8iYi0lQhavEct5ubkAhSFuU9s4rroHd3N+AckpLDC/
         jw6xYzjd7xyE129yUmf1gnyBzgg+LaKXCaCd6w46iqloNykRsSauZaNgOYIAyGVr05ol
         iJMrYZhdwnbz/3CYvwz0eLByx5L7+46HjyjVs=
Received: by 10.150.166.1 with SMTP id o1mr6135269ybe.154.1308581758319; Mon,
 20 Jun 2011 07:55:58 -0700 (PDT)
Received: by 10.151.85.20 with HTTP; Mon, 20 Jun 2011 07:55:58 -0700 (PDT)
In-Reply-To: <BANLkTimjixOT=j9Xf=Ti-04cRw2noC0NiQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176069>

On Sun, Jun 19, 2011 at 10:06 PM, Shawn Pearce <spearce@spearce.org> wrote:
> On Sun, Jun 19, 2011 at 17:50, Peter Foley <pefoley2@verizon.net> wrote:
>> This patch tries to organize the git source tree by moving the files which
>> make up libgit.a to a lib subdirectory.
>> Before this patch the toplevel source directory contained 285 files.
>> After this patch the root directory will contain 167 files and
>> the lib subdirectory will contain 119 files
> ...
>
> Thanks. But why is this amount of churn necessary or being
> recommended?
If that becomes from time to time as Jonathan pointed out, probably it
means that other people thinks the physical layout of the source files
could be improved.

> What problem does this address?
I think it's the big number of source files at the toplevel directory.
