Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 334CD20281
	for <e@80x24.org>; Wed,  1 Nov 2017 10:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751332AbdKAKJh (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 06:09:37 -0400
Received: from mail-yw0-f173.google.com ([209.85.161.173]:44307 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750928AbdKAKJf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 06:09:35 -0400
Received: by mail-yw0-f173.google.com with SMTP id k11so1415552ywh.1
        for <git@vger.kernel.org>; Wed, 01 Nov 2017 03:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tprg-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T2CQYL+Hc2KnYUbHfAzK7S9926d9LjNx/j88MJ4Ma1I=;
        b=M4fGxw41TINo2Nh7GsZeykMy48r579h74m/3zyXsOPTN+guzqwLyv1kAXvuXh5UTBE
         akrLOCCiKrzZwuk/QugwEf/LKMs7zt5DLMoETypIGrNR69jb1NWhN1AupmZ9nzL7u/+B
         ldAcMr/ieHvwytzz7wvJiAgl3QC00kIG1qyhU/Zc/61MB8SLQJhZznQZUR0/955cWC9J
         zXGJr3ZOYnDl2k9rFOEkI4CouxwuhVxz4UEqFmlkAmYeONpgYuxqCGSGnKjJNOiRnczg
         0VK6R0TO2XcQlam8sK5EbwMIdiAICNsXyW4STOaImJrLZNlz0TkmSAVMDR2PmrkjMYn6
         w7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T2CQYL+Hc2KnYUbHfAzK7S9926d9LjNx/j88MJ4Ma1I=;
        b=Uo1BBWoJWkmGtnRB3RPmIlPG4JMKh0Fn+FkjBodwyac6doizMCNJGZM8IwONzKzcMy
         mA3W7/BneEeb9lb5RtnAmQlI+ahr7ySY693NLlPoMeB1Omk/DlMo3SgJHHp9ZgOI35PN
         SV0srYsgSUujrRQyUm1Rc8kFeG4kxA3kvleHswkOhLKGp3Iam/emQ1Uusp4iz/3J+NDH
         c7TNQDu0oGd4ec7yxt2/U9hMBwYbV7YWAvQYqjDorXlRZyqFfvQDJtaXo5K+V6c1aDXZ
         ouvLuIkLiDbJ8N43I3gFnZ6Gw+WCIr/Z+nosSuf1LYIpQfREfnQ60D1BF4pssrRDaJEw
         ozKQ==
X-Gm-Message-State: AMCzsaUOumZofoULteYvuVqtaQqcTLhNBsGEdU6T9uLYn8wTzpfyOTTz
        jzV2WaEQoUj72vr54vJ9FlNgjSfuImsb8xdRsG4cEgsoeV5Deu+4eK+j2PFQm1nQ+LI12+ZK0IW
        598w66xD65Yid2g1cVy2vU8lZXIc=
X-Google-Smtp-Source: ABhQp+QRo4WHuQvSyYSsUr363ns3vWc36AQKnOoyXS8+lBJ8xF43XoSEBSq/ihx12vGkIzNSIRo4Zz6uB39aW7IGhQ4=
X-Received: by 10.129.85.202 with SMTP id j193mr2998522ywb.342.1509530975094;
 Wed, 01 Nov 2017 03:09:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.161.103 with HTTP; Wed, 1 Nov 2017 03:09:34 -0700 (PDT)
In-Reply-To: <001801d35292$9871bd10$c9553730$@nexbridge.com>
References: <CAO-WtQhAPjoWnWyMPi5SkCSUM_y8A=hsbLk-MUfnCSBvWnBRNQ@mail.gmail.com>
 <20171031212251.GB7777@alpha.vpn.ikke.info> <001801d35292$9871bd10$c9553730$@nexbridge.com>
From:   Eyjolfur Eyjolfsson <eyjolfureyjolfsson@tprg.com>
Date:   Wed, 1 Nov 2017 10:09:34 +0000
Message-ID: <CAO-WtQheY-cpBwEp1TGbRAT4t7Ao7qDdGdinMBb2eB6AOeuKBA@mail.gmail.com>
Subject: Re: Is it possible to convert a Json file to xml file with Git
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     Kevin Daudt <me@ikke.info>, git@vger.kernel.org
X-tprg-gsuite: true
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

Thank you for your response and help. I am new to Git.
The reason for my question is that I am using Git or Bash.exe  (cURl)
to call a REST web service (open for test) and retrieving  Json
from the web service and storing it into file.
This works fine from the Git Bash command line . My Git Command:
$ curl https://jsonplaceholder.typicode.com/posts -o c:\temper.txt

I will look into the smudge filter.

One more question is there a possibility to call Git Bash with a
parameter like example
C:\Git\Git\git-bash.exe  curl
https://jsonplaceholder.typicode.com/posts -o c:\temper.txt

The reason I am asking this is that I am using NAV 2009 Classic Client
and want to lunch the Git Bash with
 the command  $ curl https://jsonplaceholder.typicode.com/posts -o c:\tempe=
r.txt


Best regards

(e) eyjolfureyjolfsson@tprg.com
(w) tpretailgroup.com


On 31 October 2017 at 21:52, Randall S. Becker <rsbecker@nexbridge.com> wro=
te:
>> On October 31, 2017 5:23 PM, Kevin Daudt wrote:
>> > On Tue, Oct 31, 2017 at 05:28:40PM +0000, Eyjolfur Eyjolfsson wrote:
>> > I have a question.
>> > Is it possible to convert a Json file to XML with Git
>>
>> git is a version control system, which is mostly content agnostic. It
> knows
>> nothing about json or xml, let alone how to convert them.
>>
>> You might want to use some kind of programming language to do the
>> conversion.
>
> Speculating... one possible reason to do this is during a protocol
> conversion effort, where definitions are moving from XML to JSON form. In
> legacy VCS systems, keeping interface definitions in one file and convert=
ing
> the content may be important. However, in git, with its concept of atomic=
ity
> (multiple files are committed in a single version across the whole
> repository), dropping one file (e.g., XML) and adding another (e.g., JSON=
),
> can be done in one commit, and never lost or confused as to what is
> intended. This makes git ideal for modernization and evolutionary project=
s.
>
> If, however, there is an application or systemic requirement to change th=
e
> content of a file from XML to JSON without changing the name - I've seen =
it
> happen - you may want to consider building a smudge filter that understan=
ds
> the difference and maps between the two, to allow git diff operations
> between old and new formats. I would not recommend using this approach
> except as a last possible resort. Make a new file as Kevin intimated.
>
> Just Musing on the Topic,
> Randall
>
> -- Brief whoami: NonStop&UNIX developer since approximately
> UNIX(421664400)/NonStop(211288444200000000)
> -- In my real life, I talk too much.
>
>
>



--=20
Eyjolfur Eyjolfsson

(e) eyjolfureyjolfsson@tprg.com
(w) tpretailgroup.com

--=20
This email and any files transmitted with it are confidential and intended=
=20
for the sole use of the individual or entity to whom they are addressed.=20
 Any unauthorised dissemination or copying of this email or its attachments=
=20
or disclosure of any information contained in them is strictly prohibited.=
=20
 If you have received the email in error, please notify the sender by email=
=20
immediately and delete it from your system.  The content of the email does=
=20
not necessarily represent Theo Paphitis Retail Group and associated=20
companies and any views or opinions presented are solely those of the=20
author.  Whilst we check communications we send for virus infection, you=20
should check this email and any attachments to it for viruses as we accept=
=20
no responsibility for any loss or damage caused by any virus transmitted by=
=20
this email.  Email transmission cannot be guaranteed secure or error-free.

Theo Paphitis Retail Group is the collective name for Ryman Group Limited,=
=20
registered in England and Wales, Company Number 02714395, VAT Number=20
672523729,  Registered Office: Ryman House, Savoy Road, Crewe, Cheshire,=20
CW1 6NA; Ryman Limited, registered in England and Wales, Company Number=20
3007166, VAT Number 672523729,  Registered Office: Ryman House, Savoy Road,=
=20
Crewe, Cheshire, CW1 6NA;  Robert Dyas Holdings Limited, registered in=20
England and Wales, Company Number 4041884; VAT number 742720153, Registered=
=20
Office:  1 St George=E2=80=99s Road, Wimbledon, London, SW19 4DR;  Boux Ave=
nue=20
Limited, registered in England and Wales, Company Number 7191520, VAT=20
Number 125504638,  Registered Office: 1 St George=E2=80=99s Road, Wimbledon=
,=20
London, SW19 4DR;  Boux Avenue International Limited, registered in England=
=20
and Wales, Company Number 8047333, VAT Number 125504638, Registered office:=
=20
1 St George=E2=80=99s Road, Wimbledon, London, SW19 4DR; and London Graphic=
 Centre=20
Limited, registered in England and Wales, Company Number 6062021,  VAT=20
Number 251820524, Registered Office:  Ryman House, Savoy Road, Crewe,=20
Cheshire, CW1 6NA.
