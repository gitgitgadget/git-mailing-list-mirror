From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Officially start moving to the term 'staging area'
Date: Thu, 29 Aug 2013 17:10:58 -0500
Message-ID: <CAMP44s3ABKMAhp_P+QZBWOfjp_wPkqB0A63v6n2mKZv_Ln+qKg@mail.gmail.com>
References: <20130829180129.GA4880@nysa>
	<xmqqeh9c4a2t.fsf@gitster.dls.corp.google.com>
	<CAM9Z-nmXPgfbXezbORb=NCqQuW4p3Dka+bHVdt_n7Sh=jehY7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Scott Chacon <schacon@gmail.com>
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 30 00:11:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFAQj-00061y-Ce
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 00:11:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756487Ab3H2WLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 18:11:00 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:43064 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753905Ab3H2WK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 18:10:59 -0400
Received: by mail-lb0-f178.google.com with SMTP id z5so1236556lbh.37
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 15:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=oMVRmuN8HKX//S08kRVv6y1y+tNTb/e0u8dbgyf+Z9s=;
        b=HnjVVGsaGTD9tYYgLep8TW+MQkpeA2oLfeKdNljy/5Jbt4S3eYTMgDD4Fo0+avJPBX
         9joy9yFMxkUvL1n/U7YMShS1YZaKSfTzTrzOoAsUIeS42rsf0TAmKbhBnpS7XiDAJoWg
         1WwXaZck5lWknAWi9jM/h0bvSr43mPXKif1woo39oTE5PhZAv8OCMkGOU8tatDEo1KKC
         7VgY7sR2mYQvDUQoXKkVqnN+QH4lyM6/CGwfw6ajwe08z+iIohrf9w5nsbLa0tUfObJS
         xRs8rtnl2Q8fMOhpCyUIdtP8urEtRL0OTSe/oxYiKna8EIMolS/f6JhLCBhNhwelMru4
         pN5w==
X-Received: by 10.152.3.42 with SMTP id 10mr4868002laz.22.1377814258471; Thu,
 29 Aug 2013 15:10:58 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Thu, 29 Aug 2013 15:10:58 -0700 (PDT)
In-Reply-To: <CAM9Z-nmXPgfbXezbORb=NCqQuW4p3Dka+bHVdt_n7Sh=jehY7A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233373>

On Thu, Aug 29, 2013 at 4:55 PM, Drew Northup <n1xim.email@gmail.com> wrote:
> On Thu, Aug 29, 2013 at 2:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> It has been discussed many times in the past that 'index' is not an
>>> appropriate description for what the high-level user does with it, and
>>> it has been agreed that 'staging area' is the best term.
>>
>> "add" is the verb, not "index" (which is a noun that refers
>> to the thing that keeps track of what will be written as a tree to
>> be committed next).
>>
>> And it will stay that way.
>>
>> IIRC, when this was discussed, many non-native speakers had trouble
>> with the verb "to stage", not just from i18n/l10n point of view.
>
> I agree with Junio.

All right, you are the only person (presumably other than Junio) that
thinks "index" is the right name for what high-level users should be
familiar with.

> This effort is better spent making the
> documentation clearer and more succinct. The reality is that a user
> needs to build a model in their mind of what they are doing which maps
> enough (completely is not required) to what is actually going on to
> get work done. If the documentation or the instruction is getting in
> the way of that in the name of simplifying the presentation then the
> presentation is wrong.
>
> We add content snapshots to the index of content (creating
> "temporary"--they will be garbage collected eventually if they become
> orphans--objects into the store at the same time). We build commits
> from those snapshots (in whole or in part, typically only using the
> most recent snapshots of new things added to the index) and save those
> in the object store with the content and tree objects. Sometimes we
> create tag objects to record something special about commits, trees,
> and content blobs.
>
> That's the real model (with some rough edges). Explaining what that
> has to do with distributed version control is the hard part.

The user doesn't need to know the format of the index, or the packs,
in fact, they don't even need to know the index or packs even exist.

All the user needs to know about this is that there's an area where
contents of the next commit are being prepared, and "staging area" is
the best name for that mental area. How that area is actually
implemented (the index) is not relevant to the user.

Everyone agrees on that, except you, and possibly Junio.

-- 
Felipe Contreras
