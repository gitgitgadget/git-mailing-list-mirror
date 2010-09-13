From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Mailing list headers: Date:<TAB> instead of Date:<SPACE>
Date: Mon, 13 Sep 2010 18:37:07 +0000
Message-ID: <AANLkTi=Eyq=UmOenJSfxOtBcuZDwxG1ooKgcA=Vf-qG1@mail.gmail.com>
References: <20100913150245.GT22527@danbala.tuwien.ac.at>
	<AANLkTinEb9geKox+a+HosQn-g4eKd-DW4agRCf8yqv=k@mail.gmail.com>
	<sfid-H20100913-202503-+038.68-1@spamfilter.osbf.lua>
	<4C8E6C7B.2090904@gmail.com>
	<20100913183054.GE7006@danbala.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Chris Packham <judge.packham@gmail.com>, git@vger.kernel.org
To: Thomas Klausner <tk@giga.or.at>
X-From: git-owner@vger.kernel.org Mon Sep 13 20:37:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvDuO-0002jH-EU
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 20:37:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754663Ab0IMShL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Sep 2010 14:37:11 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62203 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754622Ab0IMShI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 14:37:08 -0400
Received: by fxm16 with SMTP id 16so3338168fxm.19
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 11:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=bMtClXUeXfO6b+wt2beUMZsPojJBCLYHHDrO3CnLfBI=;
        b=e27YMtg8quZF1ex75i6e1hXLwO4MzGNDap22FZRxlEbwBz4XsLyyZfww6g29zwsuep
         20RktbT7sFfyDXilN4n75hX4NXscCgjdMrAEitdJQj+bLHhQFNc5SgVhT3Rwi4VkPfVB
         KtLDxu64LfFHznQuD798Gd43cXz32Tnbl+Tvs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=d6OJqQmgTKr19JHyelkqCeCwU+i5OpxKMhDvOFxsRUx7KXGk3Ok6gXxEZZpUwEIR7i
         uD3YuyBy/7OCLFQQDVdylzbSqZd30IzT2HZkoeGrZxRFT74XS8WyboFnu+uDnJNMdSa3
         uB5LiGe/P1HfxI17oh+uby/2MjkfJD5pAHz/Y=
Received: by 10.223.116.68 with SMTP id l4mr365267faq.98.1284403027361; Mon,
 13 Sep 2010 11:37:07 -0700 (PDT)
Received: by 10.223.120.14 with HTTP; Mon, 13 Sep 2010 11:37:07 -0700 (PDT)
In-Reply-To: <20100913183054.GE7006@danbala.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156111>

On Mon, Sep 13, 2010 at 18:30, Thomas Klausner <tk@giga.or.at> wrote:
> On Mon, Sep 13, 2010 at 11:24:59AM -0700, Chris Packham wrote:
>> There is also a problem with your definition of "uncommon". I haven't
>> checked but I'm guessing the tabs are there for every mailing list run
>> by vger.kernel.org. Those are some of the highest volume mailing lists
>> that I know of. It can't be to hard to change tin to parse a tab or
>> space character.
>
> I'm sorry if you don't like my choice of words. I have subscribed to a
> number of mailing lists and read them in tin without stumbling over
> this problem.
>
> Is my request so much to ask?

Well, yeah. You're asking that someone that maintains the mailing list
go and modify the mailing list software due to some trivial bug in a
non-RFC compliant client.

The bug can presumably just be fixed by changing something like this
in tin:

    while (*s++ == '') { ... }

to:

    while (isspace(*s++)) { ... }

So why not just do that? Then you'll have fixed the bug for all tin
users regardless of what mailing list they're subscribing to.
