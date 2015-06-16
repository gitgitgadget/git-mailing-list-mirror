From: Panagiotis Astithas <pastith@gmail.com>
Subject: Re: [PATCH] Fix power checking on OS X
Date: Tue, 16 Jun 2015 20:35:31 +0300
Message-ID: <CACvVhd6j_zWpvfXti1=U8iOaXE+oTUtmjrHu39VR12UNBxkY4A@mail.gmail.com>
References: <1434440167-1046-1-git-send-email-pastith@gmail.com> <xmqqr3pb5zl1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 19:43:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4utw-0007q8-0i
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 19:43:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754532AbbFPRnv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 13:43:51 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:35236 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683AbbFPRnu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 13:43:50 -0400
Received: by ykar6 with SMTP id r6so19616256yka.2
        for <git@vger.kernel.org>; Tue, 16 Jun 2015 10:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=SgBpUy1n0AgQF5hR7uiT1Q+ZvpAadheU8P5dyvqvI4Q=;
        b=CZ7RKct68E9vYkmX9/fRqfyLJv0Bbl2qQ+3sWDMuk4i6kWFYU1UCA1LJycYODIKYZ+
         0mp6S39rw1LjaX6rFbnYCocAqFg2GP1vPo2Vi5Bo3HbFW6zjQCgvPq4zEfMLTu2j5/Vd
         3hOwF9u1CWKupyzzzpW0qGgEmlq9pS8Ocsbb1lPbX6Y//vB4z1Ho0GwQgfObTXU6kV1h
         A6PqZtkqBIjFlNl7xhdEHqyGb4g4NT4kMs/tjh5HCWfsmyIS+xkXhMjo+s4JPGxjVfwA
         tMpWth8xk6yTBnE7yJN/vcP8oRe6HdsYxlhIt+7bI6qlJVPpwxqQfy1QmvmwCF2TAY60
         6TAw==
X-Received: by 10.170.125.208 with SMTP id r199mr1791544ykb.15.1434476152298;
 Tue, 16 Jun 2015 10:35:52 -0700 (PDT)
Received: by 10.37.203.77 with HTTP; Tue, 16 Jun 2015 10:35:31 -0700 (PDT)
In-Reply-To: <xmqqr3pb5zl1.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271786>

On Tue, Jun 16, 2015 at 8:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Panagiotis Astithas <pastith@gmail.com> writes:
>
>> The output of "pmset -g batt" changed at some point from
>> "Currently drawing from 'AC Power'" to the slightly different
>> "Now drawing from 'AC Power'". Starting the match from "drawing"
>> makes the check work in both old and new versions of OS X.
>>
>> Signed-off-by: Panagiotis Astithas <pastith@gmail.com>
>> ---
>
> Hmph, is there any difference between this one and the original one
> that I already queued several days ago?

None, I was just following the process outlined in SubmittingPatches
that mentions a separate email after the discussion is over.
