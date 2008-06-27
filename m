From: "Dana How" <danahow@gmail.com>
Subject: Re: An alternate model for preparing partial commits
Date: Fri, 27 Jun 2008 11:20:27 -0700
Message-ID: <56b7f5510806271120s2c9d6d87m4f4d2ab8645c187b@mail.gmail.com>
References: <9af502e50806262350t6e794a92g7751147f1882965@mail.gmail.com>
	 <alpine.DEB.1.00.0806271408290.9925@racer>
	 <9af502e50806271014l661dcfc9o4f61ee2b54677bd6@mail.gmail.com>
	 <alpine.DEB.1.00.0806271844230.9925@racer>
	 <9af502e50806271049m4015b0b7nbb1c4c94a4e1a2f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>, danahow@gmail.com
To: "Robert Anderson" <rwa000@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 20:21:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCIZa-00074f-JQ
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 20:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757182AbYF0SUa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 14:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757122AbYF0SUa
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 14:20:30 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:60045 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757082AbYF0SU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 14:20:29 -0400
Received: by ug-out-1314.google.com with SMTP id h2so5735ugf.16
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 11:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=SoFP7gXG8FTPRIbkscdJjPspWXKwHWqgxeH4hjWW23I=;
        b=us42blPkIBKxXXEvl5mFJ4KX5sGnfcNNzMMfOsIOi0xp40DVr2dcG7KWoSzfsU/GQi
         G1d60I8lOb7/7tSYYiGqtKXxxTs3/XxGLb2EZLHFQwQgZIaDks99mKoLIwmwozzGL0i4
         ZjtW8MizvDMeQVPr3hVODcEk6leGeL25KoG4A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=KIjN3+mp+vd8y7xj4jkTEcLzJJBCAZBhRD/L2UHko3eRXuZ1gZiqBnazBS3auU7h6B
         O41eQBi4sp+CByef48Q6Aj++us+HNMouI7umenFCIiWb9d3RjaCiyUfatLH8vhF9EbiO
         ElEXOzrbV8VaCoq/XuA1SGy/D6LVFv7Qs9U5g=
Received: by 10.78.162.4 with SMTP id k4mr549634hue.43.1214590827203;
        Fri, 27 Jun 2008 11:20:27 -0700 (PDT)
Received: by 10.78.130.7 with HTTP; Fri, 27 Jun 2008 11:20:27 -0700 (PDT)
In-Reply-To: <9af502e50806271049m4015b0b7nbb1c4c94a4e1a2f4@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86619>

On Fri, Jun 27, 2008 at 10:49 AM, Robert Anderson <rwa000@gmail.com> wrote:
> On Fri, Jun 27, 2008 at 10:45 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> Hi,
>>
>> On Fri, 27 Jun 2008, Robert Anderson wrote:
>>
>>> On Fri, Jun 27, 2008 at 6:33 AM, Johannes Schindelin
>>> <Johannes.Schindelin@gmx.de> wrote:
>>>
>>> > On Thu, 26 Jun 2008, Robert Anderson wrote:
>>> >
>>> >> Seems to me the concept of the "index" is a half-baked version of
>>> >> what I really want, which is the ability to factor a working tree's
>>> >> changes into its constituent parts in preparation for committing
>>> >> them.
>>> >
>>> > Half-baked is probably too strong a word.
>>>
>>> It is too subtle.  That the index state - which becomes the next
>>> committed state - is not available for building or testing before
>>> committing is a deep flaw.
>>>
>>> > Now, this is not necessarily what everybody wants, which is why many
>>> > people are fine with the index.
>>>
>>> But it is something they should want, and should have, if they care
>>> about the quality of their commits.
>>
>> This is too narrow-minded a view for me.
>>
>> No longer interested,
>> Dscho
>>
>
> Here's a patch to match the local culture:  "It is incredible how
> stupid the idea of the index is."
>
> Clearly you should now be interested.
>
> Thanks,
> Bob

I guess I'm not interested in the over-generalizations.  ;-)

But the ability to use e.g. some stash-like feature (as suggested above)
to easily make the index-state (about to be committed) fully available
for compiling/processing/testing without losing edits not yet ready
for commit is an extra feature we would use here at least some of the time.
I will admit it's currently not the "itch" at the top of my list.

Thanks,
-- 
Dana L. How danahow@gmail.com +1 650 804 5991 cell
