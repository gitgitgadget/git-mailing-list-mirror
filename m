From: =?UTF-8?B?0JvQtdC20LDQvdC60LjQvSDQmNCy0LDQvQ==?= 
	<abyss.7@gmail.com>
Subject: Re: Huge possible memory leak while cherry-picking.
Date: Mon, 12 Aug 2013 14:04:41 +0400
Message-ID: <CAJc7Lbrmsna4u4s+fdCGZ7jn9HzgZkinL3tbjbjcuw40Of5umg@mail.gmail.com>
References: <CAJc7LbpRuqug9pLFVVg=XMvJ9u_P0ZVSy2MVBDaCVkjvfKnfJw@mail.gmail.com>
	<CAMP44s282DD+tQUgVHawdRDJayjTxMjOu_R3robbCVhkbksEtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 12 12:04:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8ozW-0006al-KZ
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 12:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755998Ab3HLKEm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Aug 2013 06:04:42 -0400
Received: from mail-ve0-f179.google.com ([209.85.128.179]:53537 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755974Ab3HLKEm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Aug 2013 06:04:42 -0400
Received: by mail-ve0-f179.google.com with SMTP id c13so5446738vea.38
        for <git@vger.kernel.org>; Mon, 12 Aug 2013 03:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=fDqjeaPTEoQGDEnZXpVuMnatTqcT0rg9fwh0sgTE1cw=;
        b=Ruo3w6FUjh7P6Sv3pufWK2YYvWY4yWtsBW8rQnelOHjOlvEitM4iE2Q2GHlr58y2DA
         vy23hQpD/fOEiQ0QuYPx2PTsr9vUfuQVaCciNQpo2OjohfP9aYkv2eMEUTx2ZdLvp5Yk
         HfWF/wkVyozResYJeQR+KT8qZHut06wmpnDtxnxg0zbBiCVkCnlxKwV6KUD0Uc8miQuo
         nWJ9YvnO7iWopFfXb+HKT0ZgrP7OPRclYibU8S2vuS1BxUkIwBPeAk43CyapiDzbPtlP
         qU1eh7UzMuJG4YUxCLu/7qdyCBbeQ86rE09CEBm66MxTj9PlPms0R3J3dhm/t98rR4fn
         768A==
X-Received: by 10.220.101.81 with SMTP id b17mr12243696vco.79.1376301881379;
 Mon, 12 Aug 2013 03:04:41 -0700 (PDT)
Received: by 10.58.80.40 with HTTP; Mon, 12 Aug 2013 03:04:41 -0700 (PDT)
In-Reply-To: <CAMP44s282DD+tQUgVHawdRDJayjTxMjOu_R3robbCVhkbksEtQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232180>

Thank you, it works very well!
Will this patch go to upstream?

Also, there is still some unexpected memory consumption - about 2Gb
per ~200 commits, but it's bearable.
I will do a futher investigation.

=46elipe, should I exclude you from my futher reports on possible memor=
y leaks?

On 10 August 2013 00:39, Felipe Contreras <felipe.contreras@gmail.com> =
wrote:
> On Fri, Aug 9, 2013 at 7:13 AM, =D0=9B=D0=B5=D0=B6=D0=B0=D0=BD=D0=BA=D0=
=B8=D0=BD =D0=98=D0=B2=D0=B0=D0=BD <abyss.7@gmail.com> wrote:
>> I have tried to cherry-pick a range of ~200 commits from one branch =
to
>> another. And you can't imagine how I was surprised when the git
>> process ate 8 Gb of RAM and died - before cherry-picking was complet=
e.
>
> Try this:
> http://article.gmane.org/gmane.comp.version-control.git/226757
>
> --
> Felipe Contreras
