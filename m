From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] exec_cmd: remove unused extern
Date: Thu, 24 Mar 2011 11:44:04 +0100
Message-ID: <AANLkTimgYHGAebKeZyqnM99UBw=_ML0AVHY2oZgy+08o@mail.gmail.com>
References: <1294696849-1428-1-git-send-email-kusmabite@gmail.com> <AANLkTinhknijHo9Qo=rqik3ksjT27AVSLhcac-tGByx9@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 11:44:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2i1s-0002lS-Cb
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 11:44:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756288Ab1CXKob convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Mar 2011 06:44:31 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62292 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754560Ab1CXKoa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Mar 2011 06:44:30 -0400
Received: by fxm17 with SMTP id 17so8271305fxm.19
        for <git@vger.kernel.org>; Thu, 24 Mar 2011 03:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=zTD6pYnb6/tKG24YCgKaMtxyRtF2FFo2fPrnF7gk0PU=;
        b=uN2av4NUNcK7nA29InlRD0x6fS4IPvLIXKyTTRNu2rDq0STP7ibhK+B4WZ0QQMAdoJ
         k2wA+TZfpYXkmRQ7wrr2nknAd3jV0OyUShGgvC6vRPilSsZpvtyGh5nrZpQf5nrUBp44
         u0BGk7uC2MptrBw/3IotDFSvZESu2qPVxB8cI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:content-type:content-transfer-encoding;
        b=SHdw04Z78gQzSeYitS8fhlBvKUVx1yewjFwfAxQci2HrxPda0kw5DG33+/FxKbv8w4
         otjkGcakJhDeG9Ubcw5jp3u6CbHo8mEsdL0wWDwXTuroRDxdAOYmZGb5CStVRfBp2Zzw
         acZYLc/wsfy+xWIFLPxJkfBwX7rX2NvbwGNsg=
Received: by 10.223.56.220 with SMTP id z28mr1043265fag.11.1300963464100; Thu,
 24 Mar 2011 03:44:24 -0700 (PDT)
Received: by 10.223.117.78 with HTTP; Thu, 24 Mar 2011 03:44:04 -0700 (PDT)
In-Reply-To: <AANLkTinhknijHo9Qo=rqik3ksjT27AVSLhcac-tGByx9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169911>

On Thu, Mar 24, 2011 at 11:39 AM, Erik Faye-Lund <kusmabite@gmail.com> =
wrote:
> On Mon, Jan 10, 2011 at 11:00 PM, Erik Faye-Lund <kusmabite@gmail.com=
> wrote:
>> This definition was added by commit 77cb17e9, but it's left unused s=
ince
>> commit 511707d. Remove the left-over definition.
>>
>> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
>> ---
>>
>> Just a left-over definition I found while looking through some code.
>>
>> =A0exec_cmd.c | =A0 =A01 -
>> =A01 files changed, 0 insertions(+), 1 deletions(-)
>>
>> diff --git a/exec_cmd.c b/exec_cmd.c
>> index bf22570..38545e8 100644
>> --- a/exec_cmd.c
>> +++ b/exec_cmd.c
>> @@ -3,7 +3,6 @@
>> =A0#include "quote.h"
>> =A0#define MAX_ARGS =A0 =A0 =A0 32
>>
>> -extern char **environ;
>> =A0static const char *argv_exec_path;
>> =A0static const char *argv0_path;
>>
>
> Bump? Or is this just too insignificant?
>

Sorry for the noise. This has already been applied, I just experienced
a brain fart while checking.
