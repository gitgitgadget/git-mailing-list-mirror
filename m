From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: GIT 1.5.0 binary installer available.
Date: Fri, 16 Feb 2007 20:10:16 +0100
Message-ID: <e5bfff550702161110x3507da82v1820bca9d4e37bc1@mail.gmail.com>
References: <45D44FD5.72299A3A@eudaptics.com> <45D48FF5.2060800@xs4all.nl>
	 <Pine.LNX.4.63.0702151954480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20070215201249.GA27526@spearce.org>
	 <Pine.LNX.4.63.0702160517390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20070216050615.GC28894@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Han-Wen Nienhuys" <hanwen@xs4all.nl>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 16 20:10:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HI8Tf-0000Ss-TB
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 20:10:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946229AbXBPTKU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 14:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946230AbXBPTKU
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 14:10:20 -0500
Received: from wr-out-0506.google.com ([64.233.184.238]:19798 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946225AbXBPTKS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 14:10:18 -0500
Received: by wr-out-0506.google.com with SMTP id i31so1216525wra
        for <git@vger.kernel.org>; Fri, 16 Feb 2007 11:10:17 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ny7rU02y5/oseMa1hzBn6llmmfTjpIYpqqx60wg7Y4UHUtvW8F0usdnjMz1mCF3/UBWVL0rUzD95ZQyPHyXc8vS9J5mQAINeVlXUytocpnwWvuPHo7YpJweiS1YebVafEAo/ufnIt6vYYOPB83ZE2lErgArMSRmB1PuKQBnhpyA=
Received: by 10.114.145.1 with SMTP id s1mr2107722wad.1171653016855;
        Fri, 16 Feb 2007 11:10:16 -0800 (PST)
Received: by 10.114.60.16 with HTTP; Fri, 16 Feb 2007 11:10:16 -0800 (PST)
In-Reply-To: <20070216050615.GC28894@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39941>

On 2/16/07, Shawn O. Pearce <spearce@spearce.org> wrote:
>
> One problem that I had with the last version of qgit that I looked at
> was creating commits was sort of a secondary operation in the UI.
> It very much felt like that feature was bolted onto the side,
> and was a second class citizen.  The primary focus of the UI was
> showing the graphical history.  Which is fine if that's what your
> primary task is.  But its not for everyone I know.
>

Yes commit in qgit is very simple: check files you want to commit,
write commit message and press a button. That's all. In case you are
on a StGIT repo it will create a patch / push on top of current patch
instead.

qgit commit is definitely not for hardcore use but for a developer
that just want to save and document his job. For anything outside the
*main path* you need something else [1]. qgit is not THE git GUI
interface and IMHO it is good like this. Why?

- Easy to use for first time user approaching git (Linux and Windows)

- Easy and quick for the most common browsing/committing/ patch
export-import tasks.

- No git 'slang/glossary' required

- No deeply understanding of git main concepts required (index-merging-etc...)

So in the conquer of the SCM world by git, I see qgit as a 'git
advertising tool', it is instrumental in spreading git use among the
big part of developers that never tried/know our wonderful 'stupid
content tracker' and could be potentially scared by a frontal approach
to 'git help --all' output.

I imagine qgit at the 'entry level' of the long, and at times steep,
git learning curve.


Marco


[1] BTW for any command not supported you could use the IMHO powerful
and flexible 'custom action' paradigm, where you can associate a
custom menu entry to *any* kind of command/script you can imagine
(also with parameter passing!). As an example, in my private branch I
have created custom actions like:

- make
- make install
- git pull
- merge <branch name>

And few scripts too.

This lets qgit interface to stay simple, and on the other side allows
the user to quickly run also very complex or very uncommon git
commands. Given the sheer number of git commands times git commands
options (and counting ;-) I had no better idea then 'custom actions'
to keep it simple and at the same time potentially command complete
for any git user.
