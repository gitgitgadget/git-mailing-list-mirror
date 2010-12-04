From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Splitting up a repository
Date: Sat, 4 Dec 2010 14:41:45 +0700
Message-ID: <AANLkTinLFZTFgov9RtNTFS36BV0xyTm6=kpDE3VZFcEG@mail.gmail.com>
References: <4CF9D15D.7090001@cs.wisc.edu> <AANLkTikqnnOLN=asPUKK0zYxYK9VWXcZPBPtwMZ3z-cr@mail.gmail.com>
 <4CF9EA60.7040402@cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Evan Driscoll <driscoll@cs.wisc.edu>
X-From: git-owner@vger.kernel.org Sat Dec 04 08:42:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POmlK-0007K5-5x
	for gcvg-git-2@lo.gmane.org; Sat, 04 Dec 2010 08:42:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754616Ab0LDHmS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Dec 2010 02:42:18 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42529 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752928Ab0LDHmR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Dec 2010 02:42:17 -0500
Received: by wyb28 with SMTP id 28so10267490wyb.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 23:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=jXF+LpW9VVmcv0O24o6FdVV+zyc271RRmLDcySipWlQ=;
        b=HX/KqErHx2hpoZL8z/byfYT5umtunDPIPvK/D256UARYppxTsNlIt2esVrRNAaifup
         YrICIjEHhOI258/U9iiATOQ2ScLjfiyl0wYaaiJTzGCiAe+n5iQuSAxrozm2gkNnIYyE
         bxQqgtgKAa1tKooPLV0nuyMJpW2cb+DgCwMIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=nfQd0fPlUK7ZLnN7mlT6m2RCcOWSABXIBk7Eyjl5ZEgSff2L37fVPlFQoNusLrxb27
         MMjApig4V2MfUrVngQt/uFEV0pw4S/ZtnAm91PZequi/kgpzDZwKH+kZSELbTAHBax58
         DddNr3gJc5ezK7aDkRW7A6Mqt/OCdXTd9g0Lw=
Received: by 10.216.240.75 with SMTP id d53mr2652647wer.4.1291448536098; Fri,
 03 Dec 2010 23:42:16 -0800 (PST)
Received: by 10.216.167.193 with HTTP; Fri, 3 Dec 2010 23:41:45 -0800 (PST)
In-Reply-To: <4CF9EA60.7040402@cs.wisc.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162888>

On Sat, Dec 4, 2010 at 2:14 PM, Evan Driscoll <driscoll@cs.wisc.edu> wrote:
> On 12/4/2010 1:09, Nguyen Thai Ngoc Duy wrote:
>> On Sat, Dec 4, 2010 at 12:27 PM, Evan Driscoll <driscoll@cs.wisc.edu> wrote:
>>> Say I have a repo where there are directories repo/foo, repo/bar,
>>> repo/baz. 'foo', 'bar', and 'baz' are loosely related -- closely enough
>>> that I put them together initially, but loosely enough that I now wish I
>>> could check out just 'repo/foo'. Since Git doesn't support partial
>>> checkouts (a bit annoying!),
>>
>> Um.. it does support partial checkouts (check out man page of
>> git-read-tree, sparse checkout section). But you must do a full clone
>> (i.e. your repository will have bar and baz, even if you only checkout
>> foo).
>
> That's sort of spiffy, and I did not know about that. So again, thanks.
>
> That said, I did a bit of reading around, and I'm not sure it does what
> I need.
> http://stackoverflow.com/questions/2336580/sparse-checkout-in-git-1-7-0
> is basically what I want, and the answers seem to indicate it isn't
> possible. (In other words, in my example, when I want a checkout of
> repo/foo, the .git directory needs to be a sibling of foo's contents,
> not a sibling of foo.)

If you want different layout too, then no it does not do that.
Splitting repo is probably best.
-- 
Duy
