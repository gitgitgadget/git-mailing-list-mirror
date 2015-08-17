From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v8 8/8] notes: teach git-notes about notes.<ref>.mergeStrategy
 option
Date: Mon, 17 Aug 2015 11:25:47 -0700
Message-ID: <CA+P7+xok1z+d2RAduPQhs6=a+SrX+jKGjKHsamUEA-ih7qBemQ@mail.gmail.com>
References: <1439801191-3026-1-git-send-email-jacob.e.keller@intel.com>
 <1439801191-3026-9-git-send-email-jacob.e.keller@intel.com> <CALKQrgeBVfkWOPZYJLnLqJiBPG5XR++G2Mmma2tyc-kwZ5aW_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Aug 17 20:26:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRP6q-0000Nm-R7
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 20:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbbHQS0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 14:26:08 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:33397 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbbHQS0H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 14:26:07 -0400
Received: by igfj19 with SMTP id j19so64310011igf.0
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 11:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Zq3a3s5JUfrbdo+CIOmBb5sr/LpyKBgXWLGDcU70zBE=;
        b=LWp9o2dn/1v5q78otL+2HUGSNC6Cw00FWOYD6x2EMoo3gicNqAyt/EhAE/MVPdrduo
         jbtQpBHW4CiruOQtN0Ac5z/2+96DKGZfygYmEF3mRgq8HPTv2lsJ2z7EpkxRj0uMqDrD
         N4+8kHXb6pb6q3jn7zb9pkZ82e9qKkulRV2f+PuRZjgH+cO765GSGdgz7FyIy8sU7wld
         OZAXeBWBgIMQxxeZx5xlqbom8RJ6flhfBj4JzfXye5l30MYpuilzOcc489AZQmpniYB7
         +M60/jJHWMqNM2tH6D3m1kffDwD00qxtWMmEgWSoAsJ13UkcvoKLPrjzBAUgEGAcMswq
         tsnA==
X-Received: by 10.50.27.39 with SMTP id q7mr16751687igg.73.1439835966895; Mon,
 17 Aug 2015 11:26:06 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Mon, 17 Aug 2015 11:25:47 -0700 (PDT)
In-Reply-To: <CALKQrgeBVfkWOPZYJLnLqJiBPG5XR++G2Mmma2tyc-kwZ5aW_A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276067>

Hi,

On Mon, Aug 17, 2015 at 6:21 AM, Johan Herland <johan@herland.net> wrote:
> Allow me to suggest a different wording, somewhat inspired by the
> branch.<name>.* documentation...
>
> On Mon, Aug 17, 2015 at 10:46 AM, Jacob Keller <jacob.e.keller@intel.com> wrote:
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> Add new option "notes.<ref>.mergeStrategy" option which specifies the merge
>> strategy for merging into a given notes ref.
>
> Add new "notes.<name>.mergeStrategy" config, which specifies the merge
> strategy for notes merges into refs/notes/<name>.
>
>> This option enables
>> selection of merge strategy for particular notes refs, rather than all
>> notes ref merges, as user may not want cat_sort_uniq for all refs, but
>> only some. Note that the <ref> is the local reference we are merging
>
> s/<ref>/<name>/
>
>> into, not the remote ref we merged from. The assumption is that users
>> will mostly want to configure separate local ref merge strategies rather
>> than strategies depending on which remote ref they merge from. Also,
>> notes.<ref>.merge overrides the general behavior as it is more specific.
>
> same here

Agreed, will fix in the next respin.

Regards,
Jake
