From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2013, #05; Fri, 11)
Date: Mon, 14 Jan 2013 08:13:51 +0700
Message-ID: <CACsJy8CJqOcjjx5UB3w4iCC-3bmtg3oz6ieQNH5o4EGAesbO5w@mail.gmail.com>
References: <7vip739su3.fsf@alter.siamese.dyndns.org> <CACsJy8CRbkLAD7LtoE_6FA_zW4YTW6Nb0mJU3ejqbu5URTrU1Q@mail.gmail.com>
 <7vobgsheko.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 02:14:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuYdQ-0003yA-CN
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 02:14:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755219Ab3ANBOX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2013 20:14:23 -0500
Received: from mail-oa0-f41.google.com ([209.85.219.41]:47177 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754978Ab3ANBOW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2013 20:14:22 -0500
Received: by mail-oa0-f41.google.com with SMTP id k14so3488502oag.28
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 17:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ytB6aGObiAg1dix5/GCLCVU13e3DWNVJzU3qjJ3Occs=;
        b=xC5Iewpm+cbfpAezP/3hRcCcH1tkV40+pzexgS4/JVFscokrP/m8Ums8efCwQE8+9h
         MyAWeGQRrQ8vnerkAh6evfcTfUk8uXXMWKt0lD7bZvEitFGuRzYosveXPfWJj2MwAh/s
         I0nnoh96w7kt9IQbp1gl49z7YBUTLvHXzQEQ0eqTB+IquIIP1bdYZmb4ld22pRnwMVQL
         SYhcvpqAMwCAsOdPxVuqjX53wYThpJ20tnNjZ6QCBh3rUB7dAzUv/RVDTMpCsraHgO6Q
         VT0qKh7YyhUqZoNHIfR6kaNwJRL3K0FTxa9aesEGrMCXYBhFWIYrU4QKzUyO7MRS+yNT
         Nw4Q==
Received: by 10.182.159.5 with SMTP id wy5mr59629511obb.31.1358126062109; Sun,
 13 Jan 2013 17:14:22 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Sun, 13 Jan 2013 17:13:51 -0800 (PST)
In-Reply-To: <7vobgsheko.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213414>

On Mon, Jan 14, 2013 at 6:02 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Sat, Jan 12, 2013 at 6:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> * nd/parse-pathspec (2013-01-11) 20 commits
>>>
>>>  Uses the parsed pathspec structure in more places where we used to
>>>  use the raw "array of strings" pathspec.
>>>
>>>  Unfortunately, this conflicts a couple of topics in flight. I tried
>>>  to be careful while resolving conflicts, though.
>>
>> parse_pathspec has not picked up init_pathspec changes from
>> jk/pathspec-literal and nd/pathspec-wildcard (already in master) so
>> --literal-pathspecs is probably broken in 'pu' after a lot of
>> init_pathspec -> parse_pathspec conversion.
>
> I guess it may be a better way forward to hold the series off, and
> instead help polishing the other topics that are depended on so that
> they can graduate sooner, given multiple topics in flight wants to
> touch pathspecs (either change the way they are handled, or adds new
> places that use them).

No problem. Just tell me when you want me to flood git@vger again.
-- 
Duy
