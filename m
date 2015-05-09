From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v2 10/12] t5520: failing test for pull --all with no
 configured upstream
Date: Sat, 9 May 2015 11:10:46 +0800
Message-ID: <CACRoPnT-9Z-GY9Orid+-nUgTGENakOA8DDD8uUBJGMBw_gbqWQ@mail.gmail.com>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
	<1430988248-18285-11-git-send-email-pyokagan@gmail.com>
	<xmqq3838qoeb.fsf@gitster.dls.corp.google.com>
	<CACRoPnRXJOxUkT5sKQf2bLnWVQ-+xFPu8D2PbX2b_9XVEGwQnA@mail.gmail.com>
	<xmqq3838p6jw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 09 05:11:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqvAb-00050r-KK
	for gcvg-git-2@plane.gmane.org; Sat, 09 May 2015 05:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752784AbbEIDKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 23:10:48 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:35692 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751568AbbEIDKr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 23:10:47 -0400
Received: by lbbuc2 with SMTP id uc2so64382023lbb.2
        for <git@vger.kernel.org>; Fri, 08 May 2015 20:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=qOroavAMP6XShCdOgbMVk6LMFmWltafIfnHkEaI/MME=;
        b=0ErdHNqqxE81bgAwcIatKd0tupbgIc7HivSis7AoKVghBQMehIaXUtMcsS2mdf8aQn
         Vp9JKdg1sW6K06ZOfFYbH27Wi+B8HnnBuvsgidi75rynoNQYea+SMhlUVqt8/wY0KxLS
         TIYEGWaLdm6GIEjrgV5j6eCiXdCo8LeH8Hd5KaU/6u2PlSZxJnYtVmKB1difR6yUkHPK
         XWQ8Vcxs1QcU7fYamoIvKQd5BRVQ75WX3JEcfjKD/1QO+QVm+edUUQ8MEr5ghEFV9z/o
         TG/Ue5FZLUlGMPzewtMo82UZfhhNMb8P3dNUr5r85NHxtoaoGYp9pQePYi0HnQ9c+yhJ
         Yp5g==
X-Received: by 10.112.205.69 with SMTP id le5mr674942lbc.65.1431141046078;
 Fri, 08 May 2015 20:10:46 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Fri, 8 May 2015 20:10:46 -0700 (PDT)
In-Reply-To: <xmqq3838p6jw.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268694>

Hi Junio,

On Fri, May 8, 2015 at 2:48 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Paul Tan <pyokagan@gmail.com> writes:
>
>> .... This can be
>> done with the current git-pull.sh, but would be easier with the
>> superior C parse-options API.
>
> Just this part, but I thought parse-options API is available to
> scripts via "rev-parse --parseopt".

Yes, it kind of is, but my impression is that it only validates
command-line arguments -- we still have to loop over each of them
which means more code has to be written as compared to the C version
(especially if we want to validate all the git-fetch switches as
well).

Thanks,
Paul
