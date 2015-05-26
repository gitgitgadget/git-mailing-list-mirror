From: Allen Hubbe <allenbh@gmail.com>
Subject: Re: [PATCH v5 1/1] send-email: Add sendmail email aliases format
Date: Mon, 25 May 2015 21:51:58 -0400
Message-ID: <CAJ80sauXaaOjQhybxWVrHJpNQhHCKOd2Le1vFqEwBef6gYjqrQ@mail.gmail.com>
References: <49e9a95b52aa61ed4f37edf1dfa178186acb4a29.1432367540.git.allenbh@gmail.com>
	<xmqqfv6nchmf.fsf@gitster.dls.corp.google.com>
	<xmqq382ncgmb.fsf@gitster.dls.corp.google.com>
	<CAJ80savVjb3_iKhNWPjQNK72DL7eq5YkbjWWG-1Gkx5+LOjzeg@mail.gmail.com>
	<CAJ80sas_D-6z4MvuFvvjoX7U_bM6b3brCo4rvYFCUfTmKS=6bA@mail.gmail.com>
	<xmqqpp5obotk.fsf@gitster.dls.corp.google.com>
	<xmqq1ti4bbu0.fsf@gitster.dls.corp.google.com>
	<xmqqtwv09w84.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 26 03:52:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yx42I-0002Hr-6r
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 03:52:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbbEZBwA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 21:52:00 -0400
Received: from mail-wg0-f49.google.com ([74.125.82.49]:34645 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275AbbEZBv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2015 21:51:59 -0400
Received: by wghq2 with SMTP id q2so84049927wgh.1
        for <git@vger.kernel.org>; Mon, 25 May 2015 18:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=x8JA+OhNMllmQ7iwMuWOo/ICAR/Syk9bS5670nvus6E=;
        b=tBhbGSb38o7G7WQwkCQpKz5CaT9OZh1Ufm+ZZa444ehAsmvMXnH+7fvY6waQFxuMrj
         7hj7GhMW4t6dYrTvFFRXTt1TvRT8waXRAO9LE0YVu3gmGxwCwMCcaVAULOzRD13PWD7B
         FoinbEOfsiX1NyyzK9HfCK66DbKCetbavsbkY4aylcpvXIaNnal9+HCZg4SKBns2L3Wb
         mnHFXf8UIrHNKWb7fxvjgs+3JQtmDSPU1OokP2NGhwcH9wrl4Qe+LbqXmTloBvVsQtqp
         xnepybEAJ5NT2sEyhNfPj6iWzrYD2oVBPByVeRIv4Adjz3xVRqW5gsOusMgADc5rCE17
         nRSA==
X-Received: by 10.180.91.137 with SMTP id ce9mr35221772wib.76.1432605118794;
 Mon, 25 May 2015 18:51:58 -0700 (PDT)
Received: by 10.28.59.4 with HTTP; Mon, 25 May 2015 18:51:58 -0700 (PDT)
In-Reply-To: <xmqqtwv09w84.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269918>

On Mon, May 25, 2015 at 5:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>> FYI, I have tentatively queued this on top of your patch.  Please
>> see "git log master..cf954075" to double check.
>
> Sorry but I had a typo there...
>
>>       git format-patch -1 -o outdir &&
>> -     cat >>~/.tmp-email-aliases <<-\EOF &&
>> +     cat >>./.tmp-email-aliases" <<-\EOF &&
>
> This should just be
>
>         cat >>.tmp-email-aliases <<-\EOF &&
>

Thanks for letting me know.  Are you still expecting v6 from me then?
The other thing you asked for was a change in the documentation: just
mention the email programs' documentation, and describe the
exceptions.
