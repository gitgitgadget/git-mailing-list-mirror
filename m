From: Colby Ranger <cranger@google.com>
Subject: Re: [PATCH 09/16] documentation: add documentation for the bitmap format
Date: Wed, 26 Jun 2013 15:33:00 -0700
Message-ID: <CAFFbUK+emr44o_2EHW2Y4o5fs8Livif_5D=G=NLDzE=2MEx6NQ@mail.gmail.com>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
	<1372116193-32762-10-git-send-email-tanoku@gmail.com>
	<CAJo=hJtcQwh-N-9_i84y1ZsL0mdREHcxhP2gepcrREiaxvxS6A@mail.gmail.com>
	<CAFFjANRwBBcORhu4mwjESBfr4GJ3zDrgYvUhY=VxK9abv7k2MA@mail.gmail.com>
	<20130626051117.GB26755@sigill.intra.peff.net>
	<CAFFbUKJZ1w2puKFLjPNZmMhSLo3_1kpfA1upv7K6qZV256vTyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Shawn Pearce <spearce@spearce.org>,
	=?ISO-8859-1?Q?Vicent_Mart=ED?= <tanoku@gmail.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 27 00:33:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UryGx-0005H3-IN
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 00:33:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753346Ab3FZWdC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jun 2013 18:33:02 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:48411 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752804Ab3FZWdB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jun 2013 18:33:01 -0400
Received: by mail-ob0-f177.google.com with SMTP id ta17so25881obb.36
        for <git@vger.kernel.org>; Wed, 26 Jun 2013 15:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=WYuGRtS7z1SpCXl/wuullm55NIC1srllGM/JJAk0E9c=;
        b=aeH+EgMhevLEkpF+/7Bj/BsNNclhvNQdwBGXsgkfrvWbuwALver9e1JYNsB1z2mnIP
         7lJnmMX1FVbRzxPfc+opj35Y5sef7yXsVPySgrzsTDCtWjwShFUFa8WWCsUyqHxswucS
         P0k9K2aEfjFR37ymYHp2kKikLdxe6IIE5f0q4HXEupTGKisy4FDGf67jBSTWfjqXA8qE
         bMB34O/o8uErXYUJkberw6DEUcAbzcOWvzWDoXxZek1Eie00f7iWhbKu4v+v4P+BjQGb
         j+yL8RcvjTQZTU4E854AWjLmAQGWi5E1A8mc3YIv+1ghagmBROLcprEZu19uZGaafC6F
         3/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-gm-message-state;
        bh=WYuGRtS7z1SpCXl/wuullm55NIC1srllGM/JJAk0E9c=;
        b=daDKhHZeT3L09wMSYr6hG/TbzrpT2JM6GepNhxYuKb7jwG/jLDKWlRbB6WiE1iENjM
         bhdcEFxOw16Q5FnqtolzL5cHfnDzOl3knkivl/NW84XDlspj13haYSJkVIY9YwDafchV
         AjlRZJROBVim6CDSfvZOgoA9wb+ZGuNLuUcYSCl7gaemVSvYvY0dLK89k3x9BNMBCqhI
         VvYPUbe0DR44iwM5Dq8dZWaRphY+cY1782SfWgefOgZScKefUPaHpA4M7+tksxqs6qhu
         mzcjoXNQaq5BrNUJd4ek1fKCrO64xO3UfOOfQPxjCqIvCEQNcd3y/thRs0Enmkv04bJA
         jA1w==
X-Received: by 10.60.37.233 with SMTP id b9mr1519760oek.61.1372285980367; Wed,
 26 Jun 2013 15:33:00 -0700 (PDT)
Received: by 10.60.125.198 with HTTP; Wed, 26 Jun 2013 15:33:00 -0700 (PDT)
In-Reply-To: <CAFFbUKJZ1w2puKFLjPNZmMhSLo3_1kpfA1upv7K6qZV256vTyQ@mail.gmail.com>
X-Gm-Message-State: ALoCoQkbuhfMvLjIE8RzCyN7V0xD3XSNJjqDvn/VT0BiQeRiPIjCOI7MZW75TUkHrZRyXDjDP1ZDzjIEQSh4HMRwh0wsuEW53Wq5Cpf1prvcMtaVeb+Z8eLOpgK7jNXAmybKKRkh/K3bi4/VRaHV3fJHpQEkjhbVUrxPqkCKGDSflvyYLkvxIAszBeFh7Iud8M1dw5Gqdr7b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229066>

>> Pinning the bitmap index on the reverse index adds complexity (lookups
>> are two-step: first find the entry in the reverse index, and then find
>> the SHA1 in the index) and is measurably slower, in both loading and
>> lookup times. Since Git doesn't have a memory problem, it's very hard
>> to make an argument for design that is more complex and runs slower to
>> save memory.
>
> Sorting by SHA1 will generate a random distribution. This will require
> you to inflate the entire bitmap on every fetch request, in order to
> do the "contains" operation.  Sorting by pack offset allows us to
> inflate only the bits we need as we are walking the graph, since they
> are usually at the start of the bitmap.
>
> What is the general size in bytes of the SHA1 sorted bitmaps?  If they
> are much larger, the size of the bitmap has an impact on how fast you
> can perform bitwise operations on them, which is important for fetch
> when doing wants AND NOT haves.

Furthermore, JGit primarily operates on the bitmap representation,
rarely converting bitmap id -> SHA1 during clone. When the bitmap of
objects to include in the output pack contains all of the objects in
the bitmap'd pack, we only do the translation of the bitmap ids of new
objects, not in the bitmap index, and it is just a lookup in an array.
Those objects are put at the front of the stream. The rest of the
objects are streamed directly from the pack, with some header munging,
since it is guaranteed to be a fully connected pack. Most of the time
this works because JGit creates 2 packs during GC: a heads pack, which
is bitmap'd, and an everything else pack.
