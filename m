From: Roberto Tyley <roberto.tyley@gmail.com>
Subject: Re: [PATCH 1/2] rebase -i: demonstrate incorrect behavior of post-rewrite
Date: Mon, 1 Jun 2015 23:17:41 +0100
Message-ID: <CAFY1edb75T91EMM6v4wWz09HZruTsioVmXxmZYjnGpK+_qshow@mail.gmail.com>
References: <0000014d7bc3f6bf-72bd5f07-9e26-411a-8484-e9b86a1bf429-000000@eu-west-1.amazonses.com>
	<0000014d7bc3f7a5-332dd95f-907f-4f46-a5d6-6b9e5dc70b0a-000000@eu-west-1.amazonses.com>
	<xmqq1ti8heu9.fsf@gitster.dls.corp.google.com>
	<vpqd21soead.fsf@anie.imag.fr>
	<xmqqd21sfvsm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 00:17:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzY1j-0007eJ-EI
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 00:17:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbbFAWRn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 18:17:43 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:35513 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628AbbFAWRl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 18:17:41 -0400
Received: by iesa3 with SMTP id a3so120119866ies.2
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 15:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VjrTmkfENXG2ahyAIi5WYSypnZQ0GSNcV6+dlx1Tz4I=;
        b=bb/BWy2CDBOG42+9N/ZlJQrRRd0MrPZlOVO2IyZMWvZeGV0F8QtHI74WtyxVgC6+ME
         oOw1fuGOgnvC9a+Rlcf1OBsH0VeqDI97dc8dilij1af0DWmV/2e9bmjTh96pW2L/VOvT
         u/IljkoXsXSpGmdFwACn+HqsZJCehKbNiKqjFvjh1kb7lyH6xMObsjENWkBv/Aupi8sv
         O3Nl2c7rLXZfjjKPaMz/9hvKieTKWI9zj1Q4Ok4BMhGRAk35wTROTXm4zEeOynFxVGyc
         hSkAFZWUhdBnJwgg+GsOnEUwO1jnQ35Li5YoYmDi/uQadgys4m0eIuvZ/xEtWjLVAQ47
         TjSw==
X-Received: by 10.107.32.73 with SMTP id g70mr29873644iog.23.1433197061175;
 Mon, 01 Jun 2015 15:17:41 -0700 (PDT)
Received: by 10.79.34.5 with HTTP; Mon, 1 Jun 2015 15:17:41 -0700 (PDT)
In-Reply-To: <xmqqd21sfvsm.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270474>

On 22 May 2015 at 16:59, Junio C Hamano <gitster@pobox.com> wrote:
> Roberto, isn't your threading of multi-patch series busted?
>
> Why is 1/2 a follow-up to 2/2?  Do you have a time-machine ;-)?

Oh, embarrassing, I better destroy the time-machine:

https://github.com/rtyley/submitgit/pull/5

This was due to me not realising that the GitHub API returns commit lists for
PRs in reverse-chronological order... thanks for pointing that out!
