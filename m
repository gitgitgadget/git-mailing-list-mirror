From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCHv1 0/2] git-p4: work on a detached head
Date: Wed, 9 Sep 2015 18:59:02 -0700
Message-ID: <CA+P7+xqTGR4EfQGmOyvB=hS5YNS1hnhddFRqdjXp+DiTSbMdRQ@mail.gmail.com>
References: <1441461738-25066-1-git-send-email-luke@diamand.org>
 <6B07CAFE-6A10-481A-9D15-0DBFF6AB0B11@gmail.com> <CA+P7+xqZ+MOMN6so1AVSbQdHjuWp+48jQw8gp8cxE0CaYc8Ldw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Luke Diamand <luke@diamand.org>, Git List <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 03:59:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZr97-0000dR-7L
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 03:59:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821AbbIJB7Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Sep 2015 21:59:24 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:33439 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642AbbIJB7W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Sep 2015 21:59:22 -0400
Received: by igbkq10 with SMTP id kq10so9143079igb.0
        for <git@vger.kernel.org>; Wed, 09 Sep 2015 18:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=WVcb5G+CgLZy1WqGz/pe9LsQcm0Ews31AoFIpK6AQO8=;
        b=sWsOs0AcOJu0othdrSIS48FI19bSRIXEgio0HdTPHPv0a5X3427whGZZgD9pXZQjl6
         vCqwmBpdf48HN15WNmqYsm0Ly9Fq0EUB8dEpSbelsFHv3OJnkaXi+EVIHpb8aovwm5jy
         6CuvCB9iRlCOLdW5lA4yjoQXfvvuqiSTmjIS2IeT3ME+OXyw5wskQ1KOZMQI16DSl3lH
         D20BBj81GDJPOptFewB5zhtYvKkq68vQXjvCmLQAuNxirThBT1yax4I6UdlITRopRGpl
         hy9XLWDAbdtz4RC6P8DBSbrvQzkxemMzqwN39PmfcTjcITryIhzC22aN5vYZBmlY3sS0
         SoaQ==
X-Received: by 10.50.3.66 with SMTP id a2mr909914iga.92.1441850361557; Wed, 09
 Sep 2015 18:59:21 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Wed, 9 Sep 2015 18:59:02 -0700 (PDT)
In-Reply-To: <CA+P7+xqZ+MOMN6so1AVSbQdHjuWp+48jQw8gp8cxE0CaYc8Ldw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277571>

On Wed, Sep 9, 2015 at 6:57 PM, Jacob Keller <jacob.keller@gmail.com> w=
rote:
> On Wed, Sep 9, 2015 at 5:03 AM, Lars Schneider <larsxschneider@gmail.=
com> wrote:
>> I wanted to play with the patch and apply it to my source but the pr=
ocess is really complicated for me. I wonder if you can give me a few r=
ecommendations how to work efficiently with email patches. I don=E2=80=99=
t want to start a flame-war about what email client is =E2=80=9Cright",=
 I am just curious how you work and what clients, scripts, or tricks yo=
u use :-)
>>
>> Usually I use Apple Mail. I experimented with mutt but it was not dr=
amatically more convenient.
>>
>> Thanks,
>> Lars
>
> Generally, any client which lets you save patches as mbox format. The=
n
> you can feed the file via git-am
>
> I don't know what clients make this easy. I normally use Evolution,
> which has as "save as mbox" option. It's possible Apple Mail does too=
=2E
>
> Regards,
> Jake

=46or the record, you can use "show original" from GMail, and save that
file as well, I believe. I don't know about Apple Mail specifically,
however.

Regards,
Jake
