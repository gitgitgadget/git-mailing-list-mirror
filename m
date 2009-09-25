From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 1/2] Make generated MSVC solution file open from Windows 
	Explorer
Date: Sat, 26 Sep 2009 01:58:11 +0200
Message-ID: <bdca99240909251658q395a62b6r8d5998382ac3fc7b@mail.gmail.com>
References: <4ABB84F4.7080403@gmail.com> <20090925220510.GY14660@spearce.org>
	 <bdca99240909251541h2e9932a3r67c1d8604e56a8df@mail.gmail.com>
	 <20090925225940.GB14660@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, mstormo@gmail.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Sep 26 01:58:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrKg8-0007h5-CD
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 01:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278AbZIYX6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 19:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752134AbZIYX6J
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 19:58:09 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:41980 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114AbZIYX6I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 19:58:08 -0400
Received: by fxm18 with SMTP id 18so2582199fxm.17
        for <git@vger.kernel.org>; Fri, 25 Sep 2009 16:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=ka4ETG2JN9IyVnlKkdgcR9Ojqe/sA5qiFlEly0x+GoE=;
        b=xdudd5UBhQ+YzBjzKxTAkcDi/hh0NNepDFv538CdgsIVLLtQB3azeU1HjGylbn7iAh
         eBhKkwBUUvMBgpbfh+wiqwmyxsdnEiCsiX6eS2NnGT8mSkN7NntwDArU6AHBPWWSYd1F
         KlK8r/ftdODsnzrZmzvON7lmInfg8KPpKOJSo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=fwDoh+UkrOiZQhbFcmPbc2L5p84xwmw2JGbrgY/u8d1DOBQ7jtLhgbKa2ht83HEG+n
         vvFuaIOdCskaSBizjMDO9e0k6StYWqSZvC0PH12J2DOFFEFhim7uZ13o4g1M/ETTpgrB
         rytSDAQXQ8l5CogGSIX9Y0Wx+qcwk0uH1ZJkE=
Received: by 10.86.169.25 with SMTP id r25mr1448593fge.17.1253923091308; Fri, 
	25 Sep 2009 16:58:11 -0700 (PDT)
In-Reply-To: <20090925225940.GB14660@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129135>

On Sat, Sep 26, 2009 at 00:59, Shawn O. Pearce <spearce@spearce.org> wrote:

> Sebastian Schuberth <sschuberth@gmail.com> wrote:
>> On Sat, Sep 26, 2009 at 00:05, Shawn O. Pearce <spearce@spearce.org> wrote:
>> > Something is wrong with both patches; neither applies. ??It looks
>> > to be an issue with whitespace, like context lines are gaining an
>> > extra space at the start of the line.
>>
>> Hmm, the patches apply fine onto master for me.
>
> After going through your client and the GMane email gateway?
> Or before you pasted it into the message?

Both. As a test for the first, I've copied & pasted my mail as it
appears for me in gmane.comp.version-control.git to a new file and
successfully applied that file via "git apply". I had to do it this
way, as on Windows I cannot really use "git am" with Thunderbird.

-- 
Sebastian Schuberth
