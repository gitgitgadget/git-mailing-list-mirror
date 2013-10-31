From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 04/16] fetch: add missing documentation
Date: Thu, 31 Oct 2013 13:08:31 -0600
Message-ID: <CAMP44s13kADwM0MudcEx=4Pk_rG0_tom2jfsEh2bz9_QXWAK5Q@mail.gmail.com>
References: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
	<1383211547-9145-5-git-send-email-felipe.contreras@gmail.com>
	<xmqqwqkt71l8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 20:08:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbxbh-0004H6-TZ
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 20:08:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755207Ab3JaTIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 15:08:34 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:49021 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753484Ab3JaTId (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 15:08:33 -0400
Received: by mail-la0-f49.google.com with SMTP id ev20so921456lab.8
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 12:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=laCDrdbOUc9GfZAQVTpZZsT1vtUnGQCeVlhQgzQcfUc=;
        b=NeW5Ir2EQ7F+q8qbm6hBi1KDeHrApWY6O22xsGMk45qlw9Hla6YQDNt4j2xzqIUr/u
         GVJ1T0cDM8SPe/hORIfqeHPiGuXjq8gdCkg99gMy1oMC+HzqzPLsslK5DvQv4cjttykJ
         pSG4rXEJzkcgQkMUKbDglw2+fQRmFjbcg9BYmNP0hfnjhMRDTDfoLRoz/+pVO5oDJcBp
         ie+UIlNlKGOHRRLo0fZdtLEdS50UR07tnjymgtUciPWLkhjO9WVYgLkL+/hfx3U3iQqN
         41p7xPo4cAmpYgOInia3rZVyGNteNRDAhdf/YrmrE24vQk7mIQkvwzwfe3PoDai5/Ru9
         hnEw==
X-Received: by 10.152.22.97 with SMTP id c1mr2992605laf.31.1383246511750; Thu,
 31 Oct 2013 12:08:31 -0700 (PDT)
Received: by 10.114.201.69 with HTTP; Thu, 31 Oct 2013 12:08:31 -0700 (PDT)
In-Reply-To: <xmqqwqkt71l8.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237161>

On Thu, Oct 31, 2013 at 12:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:

>> diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
>> index e08a028..7e75dc4 100644
>> --- a/Documentation/git-fetch.txt
>> +++ b/Documentation/git-fetch.txt
>> @@ -37,6 +37,9 @@ or from several repositories at once if <group> is given and
>>  there is a remotes.<group> entry in the configuration file.
>>  (See linkgit:git-config[1]).
>>
>> +When no remote is specified, by the default the `origin` remote will be used,
>
> I recall there were typofix comments on this line.

--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -37,7 +37,7 @@ or from several repositories at once if <group> is given and
 there is a remotes.<group> entry in the configuration file.
 (See linkgit:git-config[1]).

-When no remote is specified, by the default the `origin` remote will be used,
+When no remote is specified, by default the `origin` remote will be used,
 unless there's an upstream branch configured for the current branch.

 OPTIONS

>> +unless there's an upstream branch configured for the current branch.
>
> Also there was a phrasing comment on this one, I think.

There was no constructive comment, no alternative was proposed.

The conclusion of the discussion (at least mine) is that the phrasing is fine.

> Resending without rerolling is not very much appreciated.

I missed a valid comment in one of my 160 pending patches. Sue me.

-- 
Felipe Contreras
