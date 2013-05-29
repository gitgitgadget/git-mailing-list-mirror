From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/4] remote-helpers: rename tests
Date: Wed, 29 May 2013 12:56:36 -0500
Message-ID: <CAMP44s2-Of=AS9Jg7YAXnZ2346ozWPS4gL5irh0devwpkdBKmQ@mail.gmail.com>
References: <1369449507-18269-1-git-send-email-felipe.contreras@gmail.com>
	<1369449507-18269-3-git-send-email-felipe.contreras@gmail.com>
	<7vmwrezx7n.fsf@alter.siamese.dyndns.org>
	<51a56ce142986_807b33e18100084@nysa.mail>
	<7v8v2xvhbu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	David Aguilar <davvid@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 29 19:56:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhkc6-0005LU-2L
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 19:56:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934992Ab3E2R4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 13:56:38 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:43767 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933523Ab3E2R4h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 13:56:37 -0400
Received: by mail-wg0-f46.google.com with SMTP id l18so6533662wgh.1
        for <git@vger.kernel.org>; Wed, 29 May 2013 10:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VLpqrEetORt7k5S2amK5wllPB9JpXLgTOCY+zVHj6wM=;
        b=zxkRpUidl33uKAC/cTar/a629OgNW0JjkeWyGj58iHATaa7fKSYCFNifmtp22cMmyZ
         ak+2j3wMhy/UBtH1hQI2rXmOcDxbWvWHw3RQLWhHHQlpWlIkgmmHekAMeHlMpbpOduII
         XSBgS/gsecSGzGXlVmyjlaAYvOqbTYFnwBDaXbUOFhUmrk7Lyf0HafXvzjp8Op25+W63
         pV/UqPqzvU9UECJBlzWhglKD7bdXOBw36gvp9wUQ3KcV8Is3VukZuuufqyCVNqac90J/
         EsH0LOTwWBdzDcR+zlXqpxjRST9/CYFu/BOhiaAItHGuj6fKHoy+T2nlKCcobPdo99Y9
         //fw==
X-Received: by 10.180.72.195 with SMTP id f3mr16295990wiv.32.1369850196285;
 Wed, 29 May 2013 10:56:36 -0700 (PDT)
Received: by 10.194.47.4 with HTTP; Wed, 29 May 2013 10:56:36 -0700 (PDT)
In-Reply-To: <7v8v2xvhbu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225854>

On Wed, May 29, 2013 at 12:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>> I do not see how it makes sense to copy how they deviate from us
>>> back to our codebase, especially if we plan to eventually move some
>>> of these tests out of contrib/ area, but even without such a plan in
>>> the future.
>>
>> They deviate from us, we deviate from them, whatever. We are a single project,
>> what more than one project does is more standard.
>
> We are a single project, so it is better to consistently follow the
> local convention established here.
>
> If your proposal were to
>
>  - Convert t/*.sh to end with .t intead, to change the project
>    convention, and
>
>  - Make contrib/ things also conform to that new convention.
>
> it may make some sense to discuss the pros and cons of such a move,
> but changing only contrib/ has no effect other than making it even
> less consistent with the rest of the project.

It's already inconsistent with the rest of the project, as they are
not named tNNNN-foo.sh.

If you want I can give it a try at renaming all the tests in the whole
project to *.t, but I don't think you are truly interested in finding
a better extension for our tests.

-- 
Felipe Contreras
