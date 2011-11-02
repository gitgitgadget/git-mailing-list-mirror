From: Frans Klaver <fransklaver@gmail.com>
Subject: Re: Q: "git diff" using tag names
Date: Wed, 2 Nov 2011 10:34:11 +0100
Message-ID: <CAH6sp9OdjNZ6_j-eSFMpecUcxW_y6fpkDZ0cRds62wOrc12x-Q@mail.gmail.com>
References: <4EAABC15020000A100007D9D@gwsmtp1.uni-regensburg.de>
	<20111028165943.2cc8253d@ashu.dyn.rarus.ru>
	<4EB0FFCA020000A100007DE2@gwsmtp1.uni-regensburg.de>
	<20111102132945.582707aa@ashu.dyn.rarus.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
	git@vger.kernel.org
To: Alexey Shumkin <alex.crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 02 10:34:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLXD7-0000N8-T3
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 10:34:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754811Ab1KBJeN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Nov 2011 05:34:13 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:36495 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754292Ab1KBJeM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Nov 2011 05:34:12 -0400
Received: by qabj40 with SMTP id j40so6488026qab.19
        for <git@vger.kernel.org>; Wed, 02 Nov 2011 02:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=YHc8kHRTm4HZFqfrg//STLBThLuUR0lb1aSXJnBP55I=;
        b=G/FxF5hHrcN5kuQzRjjwKK5WNh4//08r2uQYgvzbuy3TTNRTQoVP1C0cD9ewx7i5oQ
         fIFw+QLTDwE3ZSYYvQyrQz4qRC5NaT4aEELwhGtqVsDyOvfaPqsYH32PlP0GPQ40JBKg
         XGqhCDOjnjiBi1Pxr7UduExR5TyMTDedoYHG4=
Received: by 10.224.210.130 with SMTP id gk2mr1645542qab.23.1320226451877;
 Wed, 02 Nov 2011 02:34:11 -0700 (PDT)
Received: by 10.224.80.149 with HTTP; Wed, 2 Nov 2011 02:34:11 -0700 (PDT)
In-Reply-To: <20111102132945.582707aa@ashu.dyn.rarus.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184622>

On Wed, Nov 2, 2011 at 10:29 AM, Alexey Shumkin <alex.crezoff@gmail.com=
> wrote:

>> Also it seems that both syntaxes work:
>> git diff v0.4..v0.5
>> git diff v0.4 v0.5
> honestly, I do not know the difference (at the moment :))
> may be gurus or manual will help to discover it

As per the git-diff documentation, these two versions behave equally
-- i.e. no differences.

Comparing branches
$ git diff topic master    <1>
$ git diff topic..master   <2>
$ git diff topic...master  <3>
=E2=80=AA1.=E2=80=AC Changes between the tips of the topic and the mast=
er branches.
=E2=80=AA2.=E2=80=AC Same as above.
=E2=80=AA3.=E2=80=AC Changes that occurred on the master branch since w=
hen the topic
branch was started off it.

Cheers,
=46rans
