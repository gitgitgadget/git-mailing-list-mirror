From: Mikael Magnusson <mikachu@gmail.com>
Subject: Re: BUG: 'error: invalid key: pager.show_ref' on 'git show_ref'
Date: Sat, 7 Feb 2015 01:03:15 +0100
Message-ID: <CAHYJk3T8e6DgvQmq-y9iNrQroYu1Gd+kYuAMHDyCUgS2ybb=kQ@mail.gmail.com>
References: <20150206124528.GA18859@inner.h.apk.li>
	<20150206193313.GA4220@peff.net>
	<xmqqbnl6hljt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Andreas Krey <a.krey@gmx.de>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 07 01:03:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJsro-0001mz-UW
	for gcvg-git-2@plane.gmane.org; Sat, 07 Feb 2015 01:03:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097AbbBGADQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2015 19:03:16 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:41022 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182AbbBGADP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2015 19:03:15 -0500
Received: by iecvy18 with SMTP id vy18so5246129iec.8
        for <git@vger.kernel.org>; Fri, 06 Feb 2015 16:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=bsE66KF1EEVRIz1uyxDq/ufwz3bpfGsVKygclvRtA1I=;
        b=G69a7WkPc9k36atRT+s42V4eq3qRaCPXQYJAng2iLEEfQOl4HY2QSkoLLI29IXpkhY
         jo6oODiNQA4kLitADvzRn3658Kvmljz3npIqqKM2ZJb0Hy4AQ9wUTG2uxDTGT/UIjUr+
         hL2kh+U7YgrW9SXNHgdxFToyo2aDWWilk92y2ryCRjgGkUMMx5HQQBUedX1t1nuQBa5d
         ns9pOZB66fqhZMqmhFjYh5Pel79xYLqZ3lExBgMz4Z87/N8ptAO03iw10HTWDp3QodXG
         tcmTnGRDxefzxe+TixxUwpZM+WE1PMJb2t6RmL2KpeaZQW5eYsbxmejlVQLajuguROG9
         Hmnw==
X-Received: by 10.50.111.168 with SMTP id ij8mr4953832igb.43.1423267395090;
 Fri, 06 Feb 2015 16:03:15 -0800 (PST)
Received: by 10.36.122.8 with HTTP; Fri, 6 Feb 2015 16:03:15 -0800 (PST)
In-Reply-To: <xmqqbnl6hljt.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263436>

On Fri, Feb 6, 2015 at 8:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> On Fri, Feb 06, 2015 at 01:45:28PM +0100, Andreas Krey wrote:
>>
>>>   $ git show_ref
>>>   error: invalid key: pager.show_ref
>>>   error: invalid key: alias.show_ref
>>>   git: 'show_ref' is not a git command. See 'git --help'.
>>>
>>> Apparently we need to squelch this message from
>>> within git_config_get_* in this case?

I reported this issue a few months ago,
http://permalink.gmane.org/gmane.comp.version-control.git/258886
Someone sent a patch that never went anywhere,
http://comments.gmane.org/gmane.comp.version-control.git/258895

-- 
Mikael Magnusson
