From: Luke Diamand <luke@diamand.org>
Subject: Re: git-p4 using notes
Date: Fri, 16 Dec 2011 19:55:59 +0000
Message-ID: <4EEBA24F.8030103@diamand.org>
References: <CAFLRbori1Dinc2epputWfjgCOWp7M2f=+TA0w2jHq_fmRC=y3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Michael Horowitz <michael.horowitz@ieee.org>
X-From: git-owner@vger.kernel.org Fri Dec 16 20:57:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rbdu0-0008WP-4I
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 20:57:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964919Ab1LPT4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 14:56:48 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52928 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030221Ab1LPT4L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 14:56:11 -0500
Received: by wgbdr13 with SMTP id dr13so6763086wgb.1
        for <git@vger.kernel.org>; Fri, 16 Dec 2011 11:56:10 -0800 (PST)
Received: by 10.180.19.137 with SMTP id f9mr4936903wie.62.1324065370369;
        Fri, 16 Dec 2011 11:56:10 -0800 (PST)
Received: from [86.26.7.206] (cpc1-cmbg14-2-0-cust973.5-4.cable.virginmedia.com. [86.26.7.206])
        by mx.google.com with ESMTPS id er5sm15757723wbb.11.2011.12.16.11.56.00
        (version=SSLv3 cipher=OTHER);
        Fri, 16 Dec 2011 11:56:04 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <CAFLRbori1Dinc2epputWfjgCOWp7M2f=+TA0w2jHq_fmRC=y3w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187310>

On 16/12/11 16:07, Michael Horowitz wrote:
> For those of you using git-p4 because of a company requirement to use
> Perforce, but really wish you could use git only, the most frustrating
> part is the fact that when changes are submitted, the commit message
> is rewritten to include a reference to the P4 change number which is
> used by the sync.  When syncing back changes, this causes the commit
> hash to be different, and so blows away your old commit and any parent
> commit references and such.
>
> I read someplace, I can't remember where at this point, that if git-p4
> used notes to write the P4 change information, that would not impact
> the commit hash, so when merging back, things would not be
> overwritten, and you can maintain branches and commit history properly
> in git.
>
> I just ran into this project, where it seems that someone has
> re-written git-p4 to use notes: https://github.com/ermshiperete/git-p4
>
> I was wondering if any of the maintainers of git-p4 has considered
> this, and might want to leverage this work to merge into the main git
> repo, possibly with an option to choose between the two behaviors.

I'm not sure I qualify for such a grand title as maintainer, but I was 
going to give this a go in the new year as it would be quite useful, 
unless someone beat me to it. I want to fix some problems with labels 
first though.

Regards!
Luke
