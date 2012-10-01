From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] submodule: use abbreviated sha1 in 'status' output
Date: Mon, 01 Oct 2012 19:22:34 +0200
Message-ID: <5069D15A.6010105@web.de>
References: <1348926195-4788-1-git-send-email-artagnon@gmail.com> <1348926195-4788-2-git-send-email-artagnon@gmail.com> <50670655.3030600@web.de> <CALkWK0kzZvPv9jFBF=ibMzcNt-jxq4RFjy7pL173+Y4_S0jhWA@mail.gmail.com> <50670E39.8080101@web.de> <CALkWK0mqkWvveA6NX36R0L5tQE_wnRwyFu0LncLY6ORXRK-KYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 01 19:32:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIjhi-0000qA-AS
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 19:22:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162Ab2JARWj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 13:22:39 -0400
Received: from mout.web.de ([212.227.17.11]:56318 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750888Ab2JARWj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 13:22:39 -0400
Received: from [192.168.178.41] ([91.3.164.110]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0Laky4-1TgqBP1jb6-00kxoz; Mon, 01 Oct 2012 19:22:35
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <CALkWK0mqkWvveA6NX36R0L5tQE_wnRwyFu0LncLY6ORXRK-KYA@mail.gmail.com>
X-Provags-ID: V02:K0:WXL42ZccfSQMqF9GeJQXHhoNTgYi0580mCr0cnY6SLr
 jAVA8U6C48DjvyLHjilwe3a5efSS1jalQMo+Cwb2/GEKmF0hiB
 CXh9mCpohrW+ueGQixO8HHSbL6F/pBRLpX+EYhw8DB7fE27+Pn
 lA4R/tK1S/q/hctNYLb6rZ33kyazulpRohfpsLzarO7FY9DpKW
 v8yWXuevWZrJLqZXKDNnA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206744>

Am 01.10.2012 08:42, schrieb Ramkumar Ramachandra:
> Jens Lehmann wrote:
>> That is just a single user so far indicating your patch /could/ be an
>> improvement. I think we need quite some more votes on that before we
>> should do a change like this.
> 
> I thought it's a porcelain command like 'git status'- we don't need
> votes to change the output format of 'git status', do we?

Sure, we are free to change porcelain output. But that doesn't mean
we shouldn't have a good reason to do so, no? And I'm not sure yet
that it's worth risking to break scripts and user expectations.

And Marc's comment also implies that the status command might not
be heavily used (surely I never use it), so maybe we are just
wasting our time here trying to improve it. And if real users show
interest in shortening the hashes, I won't object that change.
