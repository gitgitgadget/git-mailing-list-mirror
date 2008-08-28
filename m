From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: Are these bugs?
Date: Wed, 27 Aug 2008 21:26:27 -0400
Message-ID: <76718490808271826y4ff8bc37ub046de3be5111eb5@mail.gmail.com>
References: <76718490808271636i4de8f385pdaeb1672f06a00d7@mail.gmail.com>
	 <7v1w0akolk.fsf@gitster.siamese.dyndns.org>
	 <76718490808271825j68ac6abch406a8e12b5849b1a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 28 03:27:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYWIj-0001Z7-73
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 03:27:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753227AbYH1B0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 21:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753015AbYH1B0a
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 21:26:30 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:36363 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752806AbYH1B03 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 21:26:29 -0400
Received: by yx-out-2324.google.com with SMTP id 8so85156yxm.1
        for <git@vger.kernel.org>; Wed, 27 Aug 2008 18:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=/mvxEAG/zYI0QAlPzxv3CZFS3fIdGpNAOH2NPwKQH7g=;
        b=TedXbVzEomPMfeTeMYUBaXiWodz6aS2DtT04wXvyVukk1UOKu2l65dd+YfzTWJeIRJ
         AN6zdhSplFAVlEVmnJAYbDQ591kXsdHanmlWd0OrtinLemmq22jSiBRNB0xT8JZhEaKO
         oDz1xrTTePFy8/d65mQ8jp9EfMteZzjDgNjD8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=U+2TmWvlbYVLe8oHbtOaHZslBFM01ld8Gv2RoTkR8P15xuGvBj/5GZ7pJc1NmFatSa
         oweQaf4BC1s9VAyoBD5t3YVhrTFwmrV7t2wwmYprzfImYC7F6JtlVvYpHZPN+ukF5yAy
         ZzO+IRn6rF590CofqnenqoWSl8dGZR+D5/YaM=
Received: by 10.151.156.12 with SMTP id i12mr1146119ybo.194.1219886788036;
        Wed, 27 Aug 2008 18:26:28 -0700 (PDT)
Received: by 10.150.50.2 with HTTP; Wed, 27 Aug 2008 18:26:27 -0700 (PDT)
In-Reply-To: <76718490808271825j68ac6abch406a8e12b5849b1a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94008>

Oops, should've gone to list.


---------- Forwarded message ----------
From: Jay Soffian <jaysoffian@gmail.com>
Date: Wed, Aug 27, 2008 at 9:25 PM
Subject: Re: Are these bugs?
To: Junio C Hamano <gitster@pobox.com>


On Wed, Aug 27, 2008 at 7:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Jay Soffian" <jaysoffian@gmail.com> writes:
>
>> I understand why "git reset" failed, but at best the error message is
>> confusing to a new user.
>
> This is in "patches welcome" category.

Okay, good to know. I'll add it to me "things to do in spare time" list.

>> 2. "git add --ignore-errors" doesn't work with ignored files:
>>
>> $ git add --ignore-errors foo bar
>
> The option, IIRC, is more about filesystem errors (failure to read), not
> about safety against user errors (specifying otherwise ignored paths).
>
> If you are automating something that uses xargs to drive addition to the
> index, and the feeder to xargs knows better than .gitignore files, then
> probably your script should be using '-f' unconditionally.  So I do not
> see why you would think #2 could be a bug.

Well that's just it, my feeder to xargs did *not* know better than the
.gitignore files so -f would have done the exact opposite of what I
wanted. The git-add man page's description of --ignore-errors agrees
with what you write above though, so I'll just move along on this one.

j.
