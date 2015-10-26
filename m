From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2] ref-filter: fallback on alphabetical comparison
Date: Mon, 26 Oct 2015 22:43:50 +0530
Message-ID: <CAOLa=ZQGwrQrie+Bp0B61LdG37-UeEdyHqvQEtq26nX9VjYu7Q@mail.gmail.com>
References: <1445790540-22764-1-git-send-email-Karthik.188@gmail.com> <CAPig+cRRB5MNxuBc-5rM_8cJh69PjH5-OSmkRNw_6OFQdQOoTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Oct 26 18:14:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqlLl-0003Nl-2S
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 18:14:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370AbbJZROV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 13:14:21 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:33006 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214AbbJZROU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 13:14:20 -0400
Received: by vkgy127 with SMTP id y127so103791687vkg.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2015 10:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Fkzg/3za9fyaNPWqq4iqkoEHdmkIlODszuIiYcWXrnQ=;
        b=uMrCpgddRpVzhGRADZD7HlIiAjI0knMKjoxWttYhtXHsrgg7GRfhqpI22EMJmKe6+0
         u1WnoxxXfkNXdmrvG14Avf8eyZjdE7zRfpAGKK9NiVsGzCJFRVDVYTQdqky3UJMbgNpn
         vOTYry+elvpCeL/IyjK8HXCJZzM8DtgrL2vXf87pgWUy1VOx8IgKJcXHSwQXKqdQE0m6
         8mokuRBumKbo8ss0E4j5JubH0d3JYAonIT4QqBPtQR/Q6rdiTsLq4wJPS5Y0vSSdPWT4
         KGREbtSiZMcAiyudeAdfI7aSeWBIyDFu4fDFkWF81m06m3uFhZ9ffxVWhKokeWO16oF5
         ZaMg==
X-Received: by 10.31.172.6 with SMTP id v6mr15324473vke.97.1445879659637; Mon,
 26 Oct 2015 10:14:19 -0700 (PDT)
Received: by 10.103.0.7 with HTTP; Mon, 26 Oct 2015 10:13:50 -0700 (PDT)
In-Reply-To: <CAPig+cRRB5MNxuBc-5rM_8cJh69PjH5-OSmkRNw_6OFQdQOoTw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280202>

On Mon, Oct 26, 2015 at 6:43 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Oct 25, 2015 at 12:29 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> In ref-filter.c the comparison of refs while sorting is handled by
>> cmp_ref_sorting() function. When sorting as per numerical values
>> (e.g. --sort=objectsize) there is no fallback comparison when both
>> refs hold the same value. This can cause unexpected results (i.e. the
>> order of listting refs with equal values cannot be pre-determined) as
>
> s/listting/listing/

Thanks for pointing out. Should I re-roll?

-- 
Regards,
Karthik Nayak
