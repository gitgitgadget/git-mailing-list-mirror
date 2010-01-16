From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH v2] Add push --set-upstream
Date: Sun, 17 Jan 2010 07:28:17 +0900
Message-ID: <20100117072817.6117@nanako3.lavabit.com>
References: <1263595630-18962-1-git-send-email-ilari.liusvaara@elisanet.fi> <7vzl4frl7i.fsf@alter.siamese.dyndns.org> <7vfx66sz5p.fsf@alter.siamese.dyndns.org> <20100116090321.6117@nanako3.lavabit.com> <7vk4virjzh.fsf@alter.siamese.dyndns.org> <be6fef0d1001151653o7ba2cf7et8875eaf4333fc15a@mail.gmail.com> <7vhbqmn9c4.fsf@alter.siamese.dyndns.org> <7vljfyiswv.fsf@alter.siamese.dyndns.org> <be6fef0d1001152055j2f178ecifc8e0265446ab75f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 23:29:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWH8r-00084M-9T
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 23:29:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070Ab0APW3E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2010 17:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752761Ab0APW3E
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 17:29:04 -0500
Received: from karen.lavabit.com ([72.249.41.33]:59038 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752751Ab0APW3D (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 17:29:03 -0500
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id 34D2D11B99C;
	Sat, 16 Jan 2010 16:29:01 -0600 (CST)
Received: from 2414.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id TQS6CVKKBOOZ; Sat, 16 Jan 2010 16:29:01 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=i/xW2AL3wPhfUfctvLq4CkSWLKz/miYwcUBmEG9Hey0OQqDG2Att6RujUh0YX56Pydf2LxkpLB4yy/h1pBpEQUm8l1o0+9bEECJk4zB3XRaE5feFHF+T86ssPxgYDA8UpUOVOt6Bfa5ru9yJcWdc8lJ0x4QlQPmVcViTvl0SHP4=;
  h=From:To:Cc:Subject:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Message-Id;
In-Reply-To: <be6fef0d1001152055j2f178ecifc8e0265446ab75f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137266>

Quoting Tay Ray Chuan <rctay89@gmail.com>

> Hi,
>
> On Sat, Jan 16, 2010 at 12:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Tay Ray Chuan <rctay89@gmail.com> writes:
>>>
>>>> After all, there's already the config called branch.autosetupmerge and
>>>> branch.autosetuprebase.
>>>
>>> Do you mean Ilari's patch already sets up branch.name.rebase for people
>>> with branch.autosetuprebase true?
>>
>> I checked; the patch uses install_branch_config() so it should get this
>> right automatically.
>
> ok, then ignore my suggestion about --setup-merge and --setup-rebase.
>
> I guess Nanako's query about 'pull --rebase' is settled as well.

I have branch.autosetuprebase so 'git push -u' is good enough for me.
Thanks.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
