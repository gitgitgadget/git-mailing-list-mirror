From: Harring Figueiredo <harringf@gmail.com>
Subject: Re: Delivery Status Notification (Failure)
Date: Thu, 14 Mar 2013 19:36:47 -0400
Message-ID: <CAN_hzmoSQXHp3JjYYQekA1XAmaAPkWqWYVboncioT7=E-rM9JA@mail.gmail.com>
References: <CAN_hzmqrrue8jif3AJv4pZwmyMpQ6u558HaRX6dQKZCF0c_H1w@mail.gmail.com>
 <bcaec5396b50ba47be04d7e99955@google.com> <CAN_hzmomGYpfh1MchCnrSwv3jv201DL2wLEXeYrG+=eNKwX4Yw@mail.gmail.com>
 <7vsj3xwrzn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 15 00:37:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGHiN-0003ee-JS
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 00:37:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154Ab3CNXhJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Mar 2013 19:37:09 -0400
Received: from mail-ia0-f176.google.com ([209.85.210.176]:42302 "EHLO
	mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106Ab3CNXhI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Mar 2013 19:37:08 -0400
Received: by mail-ia0-f176.google.com with SMTP id i18so2647869iac.35
        for <git@vger.kernel.org>; Thu, 14 Mar 2013 16:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=F5VBjOVSL+5leRD+oqaA+iIVdNtxvm6emuaEZCGgQbA=;
        b=V3uUzAFzJrITRKztkpQy5sM2an6wE1AyfS4BE1jKvXKG2DUq7FC9cZLPyAq8P1mkyP
         sK5vZSQ0lzTMsKOOJ+c+AkS6Z72OQbQPvyKazsBRJ5ZFdy821M6yea0N+p7lVkcUCdYo
         Mw/QS4XSisKmrgnm31JvG9rNoj0OTal1mCYae96mCIOO4kY7HGBiBZnpUgxFly+DMr9K
         q+O6BHEcsV1sbgYaH7ktfZLjUmxo5ZdZX1l/Etism04Hd72PZEE+olbJ9Rhh3DSGiY+l
         gs4jFq08d21P8NiMGs9jYhiwfYEvZFxCAgB+o6qwONWmQi1I4z6y9HKPd9sxr/629UON
         zq6A==
X-Received: by 10.50.140.5 with SMTP id rc5mr13034319igb.78.1363304227391;
 Thu, 14 Mar 2013 16:37:07 -0700 (PDT)
Received: by 10.64.38.166 with HTTP; Thu, 14 Mar 2013 16:36:47 -0700 (PDT)
In-Reply-To: <7vsj3xwrzn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218182>

Got it!

=46rom the recommended site:

--
In the English singular case, the number =96 always 1 =96 can be replac=
ed
with "one":

          printf (ngettext ("One file removed", "%d files removed", n),=
 n);
This works because the =91printf=92 function discards excess arguments
that are not consumed by the format string.
--

Junio, thank you so much for the  reply and link to the docs.

-hff

On Thu, Mar 14, 2013 at 6:12 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Harring Figueiredo <harringf@gmail.com> writes:
>
>>  Just want to confirm that this is not a bug:
>> ...
>>   printf_ln(Q_("The bundle requires this ref",
>>                                       "The bundle requires these %d =
refs",
>>                                       r->nr),
>>                                    r->nr);
>> ...
>>  seems to be missing %d parameter on the first message.
>
> Perhaps visit
>
>         http://www.gnu.org/software/gettext/manual/gettext.html#Plura=
l-forms
>
> look for "In the English singular case,..." and read the
> explanation there?
>
