From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Git Gems
Date: Fri, 18 Nov 2011 10:08:45 +0530
Message-ID: <CALkWK0n6msuDSLP-rjAw93E_fsi3pdPk8S2W+fjfQr2rFMrhdQ@mail.gmail.com>
References: <CAE1pOi1gyshz_502NQvLNAByfwiYXW2fzA+EnGKz8tuFrCpkxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 18 05:39:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRGEO-0004r9-2v
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 05:39:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756605Ab1KREjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Nov 2011 23:39:09 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:53157 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756387Ab1KREjH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2011 23:39:07 -0500
Received: by wwe5 with SMTP id 5so4426600wwe.1
        for <git@vger.kernel.org>; Thu, 17 Nov 2011 20:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=fEIGwHM7trzD64huhuDnow7SdtFOwnX+hK+u/TknYJA=;
        b=gR0vLLjuJjl0PKXqSTFdT3WXcHKs7GXf7LavyGWj7zuLoFyneQBb2RioxvaMI1+Z88
         cnDS1yPzDR3F5uwai43DuCIgsNHCLjigwXksu9HCdm+CaRsqyqk+s8KjTjpuaQRRwi/L
         Gcw96LnLBBU1xnjM6U0uU7zo//gXsCE69gWaI=
Received: by 10.227.208.147 with SMTP id gc19mr881787wbb.25.1321591146098;
 Thu, 17 Nov 2011 20:39:06 -0800 (PST)
Received: by 10.216.19.209 with HTTP; Thu, 17 Nov 2011 20:38:45 -0800 (PST)
In-Reply-To: <CAE1pOi1gyshz_502NQvLNAByfwiYXW2fzA+EnGKz8tuFrCpkxg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185629>

Hi Hilco,

Hilco Wijbenga wrote:
> [CC: Git Users <git@vger.kernel.org>]

For the record, this is the official Git list: both "developers" and
"users" hang out here.

> [...]
> As an example, 'git rebase' didn't really seem useful until I
> understood (well, more or less) what it did. Until then, I just
> naively assumed that merge commits and non-linear history were
> something you simply had to live with. I'm guessing that, like me, a
> lot of people come to Git with quite a few assumptions and
> preconceived notions due to their exposure to other SCM tools. :-(

I'm not sure how a listing is going to help; nevertheless, here are a
few of the lesser-known features of the top of my head (in no
particular order): rerere, attributes, replace refs, filter-branch,
blame's -C and -M switches, log's -S switch, custom diff drivers,
bundle, submodule, stash, notes, and reflog.
[You can find more by digging through the sources]

Which brings us to an interesting aside: unlike many other SCMs which
have a definite and finite set of features, git is really just a
toolkit that grows everyday- various people use various subsets and
write up their own custom scripts to help them automate tasks.  The
"git rev-list/ git rev-parse/ git cat-file" is an awesome trio to
start writing shell scripts with :)

Cheers.

-- Ram
