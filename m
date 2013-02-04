From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH] send-email: ignore files ending with ~
Date: Mon, 4 Feb 2013 11:43:51 +0900
Message-ID: <CAAVeFu+s4UqOxywKSviwkhc88qShfJRdEozfTt2ifpRm+=DwSA@mail.gmail.com>
References: <1359903340-14508-1-git-send-email-gnurou@gmail.com> <CALWbr2wCEHkVU86Dkzq1+mRx605h4LBo-5e8ySAwv=T0pMw62A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 03:44:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2C3B-0001mQ-9C
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 03:44:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753865Ab3BDCoZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2013 21:44:25 -0500
Received: from mail-ie0-f178.google.com ([209.85.223.178]:52168 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521Ab3BDCoY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 21:44:24 -0500
Received: by mail-ie0-f178.google.com with SMTP id c13so5099585ieb.23
        for <git@vger.kernel.org>; Sun, 03 Feb 2013 18:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=o4FhqYCwkN6YHx0+PZMYSKQPXU1/mhBA4CK/2W3vYlo=;
        b=HX/5kz19Ed3xHOj8y33nUoekvvE0WEKqhcwkIQiw2bERGCF/OIck3IHANs0wDw4xxO
         iIX9ckJWdg1QPyH0LerqFFOeh7AYTvWdfv/lr3Nz/ha7uRH32u9braKRd5NN+LEGUOIJ
         PtoM1RhcXPg2Gx1ISTi3kVcwXyppe/qA5+VK2zxY4mn+fyFfBB9LbXXf++QUsl+l1Bq3
         UgN54rOz/AVOFYXDPF/GJZQ9pp4LYKC++8VBJqWPV4umBej7qUN3QEY1KsZFmyPlGjsn
         5LHhLllwQg32EUpaPwbuYB12z401C6H9ZiQQxjDjrMQJoPtiAZ7ygdP6NzRT7YvQQ/Nf
         VoKQ==
X-Received: by 10.50.88.129 with SMTP id bg1mr4111944igb.33.1359945851283;
 Sun, 03 Feb 2013 18:44:11 -0800 (PST)
Received: by 10.64.96.232 with HTTP; Sun, 3 Feb 2013 18:43:51 -0800 (PST)
In-Reply-To: <CALWbr2wCEHkVU86Dkzq1+mRx605h4LBo-5e8ySAwv=T0pMw62A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215348>

On Mon, Feb 4, 2013 at 2:16 AM, Antoine Pelisse <apelisse@gmail.com> wrote:
> On Sun, Feb 3, 2013 at 3:55 PM, Alexandre Courbot <gnurou@gmail.com> wrote:
>> It certainly happened to a lot of people already: you carefully prepare
>> your set of patches, export them using format-patch --cover-letter,
>> write your cover letter, and send the set like this:
>>
>> $ git send-email --to=somerenowneddeveloper --to=myfutureemployer
>>   --cc=thismailinglistiwanttoimpress 00*
>
> Why don't you use 00*.patch ? That seems dubious to me to ignore files
> specified on the command line.

For the same reason I do not list all the patches individually on the
command line: laziness.

The goal of this patch is in no way to argue that using send-email
like this is a recommandable way. It just adds a safeguard on a
use-case that is probably not so uncommon.

Alex.
