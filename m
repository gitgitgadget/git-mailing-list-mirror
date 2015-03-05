From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFH] GSoC 2015 application
Date: Wed, 4 Mar 2015 16:32:05 -0800
Message-ID: <CAGZ79kZzB8-r2a4VGG23GL1ZqxY7c34391vMwVr09MnCV6Hqcg@mail.gmail.com>
References: <20150218191417.GA7767@peff.net>
	<54E6C78D.3070506@alum.mit.edu>
	<20150220072924.GC8763@peff.net>
	<vpqpp94exb5.fsf@anie.imag.fr>
	<70A3994196D94205B75660D9DEFF0A12@PhilipOakley>
	<CAGZ79kaNZsBP19gLvsrDx6RLyQ7QhmbKAgSDcXg71Uwcvf9tNQ@mail.gmail.com>
	<75FBE31490904D8EA82F5C445F1F33E1@PhilipOakley>
	<CAPc5daV_igiExbvY1eH0T2SKxgawO86F0eZyoai_QK-dXc5fDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 01:32:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTJi1-000397-Mr
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 01:32:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753200AbbCEAcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 19:32:09 -0500
Received: from mail-ig0-f170.google.com ([209.85.213.170]:41399 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752511AbbCEAcG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 19:32:06 -0500
Received: by igal13 with SMTP id l13so41812027iga.0
        for <git@vger.kernel.org>; Wed, 04 Mar 2015 16:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=T/58Aqy/4EZD59M1+JsTye3j1HzSb79uvp3zfw7xTH0=;
        b=KCUaqAOhZOTSSs9iwQeap9EjL5cujLcwmf32kAM70A8M0temWM9inI0aqzoQ6R7IHc
         A1wMoPWxN83yRLFrLYy5UYroZQr1S2casjy3P+LWVbNAdt9p2IfbdZfhKGEyfgZdj5Ap
         7TQvQ+gyL9obeCeFC31G4QEsstQmAQSZbqSnxtG/HQLAPlOJBNhXlqkvjPu8pGCtzz5E
         4rDmOKxMuITbVq6Fcw44zC9ItHtym4DZ2+nS+QG9uABluxWFDoz7caqgDEnElVh76SgO
         26At8gW+w9rKvVnHooO1uzBdEbahA12L4rWaddLnyBMttW9apJGCPPqok1Rk+I6nfMVO
         Tgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=T/58Aqy/4EZD59M1+JsTye3j1HzSb79uvp3zfw7xTH0=;
        b=CvskYMyLwRTaZ/M6c93ZMrtHWNEV1kkWJgOaOndrOisS2p7WJ6WSv+g3T+HuD+vhIe
         zoY0PDVafl0AEKt3IzJsup8PyzeGJn3yMalQV/rlI+LKq3CNoKIf0OPI9reQFhZ0/rgB
         YzvAyFuf1Kk4k70QV1kwzk5hBR/drOUfAbEgJ91eJtnp8bk9MP2DZBfaO3zCfhOIU8jD
         lvOosbhUxrNTWXokzV/B98/UKi2uEe8WkY2sf3MdkHuxqidNbH/yIvSayC9JC1YpNSTx
         WO8ssmmZLGRrTOJ1v/O7XrJ0gZei7NZWcLCLREvcnNaHP4h8jT9C5wfy9ls/W9fDsO0R
         Ih3g==
X-Gm-Message-State: ALoCoQlWcZ4xDSXlXV4JqfEN5MwBCh8KS/uzJpFAtWLQKZK1ANittIaB3EwC7A3MChNeU6zJK16r
X-Received: by 10.107.36.9 with SMTP id k9mr16725345iok.2.1425515525968; Wed,
 04 Mar 2015 16:32:05 -0800 (PST)
Received: by 10.107.46.31 with HTTP; Wed, 4 Mar 2015 16:32:05 -0800 (PST)
In-Reply-To: <CAPc5daV_igiExbvY1eH0T2SKxgawO86F0eZyoai_QK-dXc5fDg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264802>

On Wed, Mar 4, 2015 at 4:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
> On Wed, Mar 4, 2015 at 4:17 PM, Philip Oakley <philipoakley@iee.org> wrote:
>>>
>>>    git clone --since 2.weeks.ago <url>
>>>    git clone --since v2.10 <url>
>>
>> The use of --since instead of --date would be an equally valid way of
>> spelling the option (coders choice;-)
>
> I think it is a demonstration of poor taste. Everywhere else, --since
> is a way to
> specify the date, not a revision. Why should this one alone should be different?

I wanted to point out the broader use case than being stylish correct,
though from
an English grammars point of view `--since` should also be able to
describe a point
in time ("since 2 weeks ago" is as valid as "since Feb 17th")

I cannot remember the usual option off hand to describe the revision
instead of a date.
Maybe we want to have one option long term to allow any kind of input (revision
and date), as this may be easier to remember, especially if it aligns well with
the English language.
