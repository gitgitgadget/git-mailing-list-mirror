From: Andrey Smirnov <allter@gmail.com>
Subject: Re: [PATCH/RFC 1/2] Add 'git subtree' command for tracking history of 
	subtrees separately.
Date: Fri, 17 Jul 2009 11:16:00 +0400
Message-ID: <cdea6cd10907170016u11af7230hbbee92682604530f@mail.gmail.com>
References: <1240784983-1477-1-git-send-email-apenwarr@gmail.com>
	 <32541b130904291927m33908bacg2dbafcf64877b88f@mail.gmail.com>
	 <20090430085853.GA21880@pvv.org>
	 <32541b130904300732i691800f5kecc2f845584071c1@mail.gmail.com>
	 <loom.20090716T160021-218@post.gmane.org>
	 <32541b130907161134n51e070a1l93690d1b8a63bee8@mail.gmail.com>
	 <cdea6cd10907161509g7771c72bl608b1924785b49fc@mail.gmail.com>
	 <32541b130907161527l1955bf06pf54b5099a5988c65@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 09:16:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRhfx-0001yx-FF
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 09:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934157AbZGQHQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 03:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934155AbZGQHQE
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 03:16:04 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:48189 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934153AbZGQHQD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2009 03:16:03 -0400
Received: by ewy26 with SMTP id 26so653153ewy.37
        for <git@vger.kernel.org>; Fri, 17 Jul 2009 00:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xsaoHnpK3VaZb7jOdAr6xc3vfqF8fiOFZ4UE7wOM2BQ=;
        b=tnIHCCotAzPUUTZcTsT2l++5eR/4lOJXANneBgxAsPMdiOvgzV39eXj2E+2DZ2KLWZ
         mSOpWJGk6yAkrAg6Ku/ZsNRKH0KOEVYYetnLg+wpm/BcZQDI45lhHMtWeoVYWvjVv2CR
         hMK+MXsZ+9mpAPsue1f3pValN1CGYyJVXaRdI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Q0U3rBdnAAOhsQjx/T9Zy0IK0qvPfgH5ZrSomeLTlhcO3a/tPLaxjaq0K9N+6IGbXy
         HcH+PFFz4Zo5SB8Cn1GjVTrJCDRSwme6LLkRsHi6SgFq/AdWhanfjesmZ2adznTWYVLH
         ivdsh0VV3rfQsVQgatBlSSe2RHMna6d880vig=
Received: by 10.216.36.79 with SMTP id v57mr226305wea.19.1247814960912; Fri, 
	17 Jul 2009 00:16:00 -0700 (PDT)
In-Reply-To: <32541b130907161527l1955bf06pf54b5099a5988c65@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123445>

On Fri, Jul 17, 2009 at 2:27 AM, Avery Pennarun<apenwarr> wrote:

>> The only thing that links git-subtree with git-rebase is the fact, that
>> git-subtree "knows" the target commit for rebases dealing with subtrees.
> rebase doesn't
> have any parameters called a "target."  What does git-subtree know
> that you don't know?

By "rebase target" I mean the mutual relation of git-rebase <newbase>
and <upstream> paramaters
that define where will be the rebased commits. git-subtree can infer
that NewProj contains library up to
test-split and that OldProj contains library upto test-split-old. The
concept of the whole git-subtee workflow
is still blurry to me though, so I will report when I gather more
usage statistics.

> I don't really understand what you're asking for here.

At most I need generic ability to shift merged and rebased
repository's or ref's "left" (selecting some directory or file)
and "right" (prepending some directory to all paths) before actual
operation(s). I.e. the antonym of 'split'
but without 'add' committree-joining semantics. This can be
implemented with some chaining/plumbing presets.

--
Sincerly yours, Andrey.
