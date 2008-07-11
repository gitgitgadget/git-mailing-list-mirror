From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [GitStats] Bling bling or some statistics on the git.git repository
Date: Sat, 12 Jul 2008 00:05:42 +0200
Message-ID: <bd6139dc0807111505j36c42b6blec299d25d8c0ac9a@mail.gmail.com>
References: <bd6139dc0807090621n308b0159n92d946c165d3a5dd@mail.gmail.com>
	 <bd6139dc0807111404y1d3dd48ao6d2903da4cd1aa56@mail.gmail.com>
	 <alpine.DEB.1.00.0807112215050.8950@racer>
	 <alpine.DEB.1.00.0807112238350.8950@racer>
	 <alpine.DEB.1.00.0807112252250.8950@racer>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailinglist" <git@vger.kernel.org>,
	"David Symonds" <dsymonds@gmail.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 12 00:06:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHQlL-0005EV-52
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 00:06:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756049AbYGKWFs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 18:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755421AbYGKWFs
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 18:05:48 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:59826 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755366AbYGKWFs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 18:05:48 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1987383ywe.1
        for <git@vger.kernel.org>; Fri, 11 Jul 2008 15:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=zNtIo35YHSvCobxFUbzPMFGe5cF3vDdnHw0L20iTqn0=;
        b=v91tesV0lRJWKN3PnesnYAELnkgrvzGZzKPfBybLtFEs5H1EATXgzb7Ee83CPFLAcU
         y5x2CzRMriAXXdDIInf83MPEAaZ+FHrrR0ZoSmOjrwjhCAS0fyx27GU1+kUBN2rXOll4
         1/E8nni2lYCNjp63ImU01YasAz1t3eZqWImaI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=Z8lMy/UCfZ0ba4d6bWdKrmroAwt/9dhNjuLGAh6XYHkORo3W4ahfcRT04wNnt0hGvf
         ncdTLOzyLH1VQubk/Al2pnn3aTMeB0zikLcsmpgwq40TNuB9xWjkZc18Er3ezIwr1Chb
         kmxqtUqm1fNp/cf0Q0jQQxuZm5FAtvuPJoE7g=
Received: by 10.150.137.9 with SMTP id k9mr1737121ybd.82.1215813942420;
        Fri, 11 Jul 2008 15:05:42 -0700 (PDT)
Received: by 10.150.53.8 with HTTP; Fri, 11 Jul 2008 15:05:42 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807112252250.8950@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88186>

On Fri, Jul 11, 2008 at 11:55 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Fri, 11 Jul 2008, Johannes Schindelin wrote:
>
>> something else I just realized: you might want to use .mailmap, e.g. to
>> coalesce the changes of Shawn "O." Pearce correctly.
>
> Yet another thing: while it is true that git-gui is usually pulled in
> (with the subtree strategy), some parts were changed in git.git directly,
> so you will need to cope with the wholesale rename with every merge.

I think I understand the cause, but I'm not sure I understand the
consequences? Will some files at some times appear to be located at
/path/to/file.txt and at other times at /subdir/path/to/file.txt? If
so, how could I possibly handle that? How do I know that when it says
/path/to/file.txt it means /subdir/path/to/file.txt instead?

> Besides, it is slightly distracting to see the file names differently from
> what they are in HEAD^{tree}.  But that may be just me.

Different how? In that it shows the contents of subdirs? For at least
my repo this is a Very Good Thing (tm) as all my source-code is in a
/src directory. If all changes to subdirs were aggregated I wouldn't
get any useful metrics at all. Or am I misunderstanding the difference
between the current output and that of HEAD^{tree}?

-- 
Cheers,

Sverre Rabbelier
