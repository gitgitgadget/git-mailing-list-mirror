From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] command-list.txt: group common commands by theme
Date: Fri, 8 May 2015 15:00:04 -0400
Message-ID: <CAPig+cS=3KMxBGnQF7v8mkcDbpw4_2LyB4coOtbJEYq-2pymAg@mail.gmail.com>
References: <cover.1430770308.git.sebastien.guimmara@gmail.com>
	<b89d3fec640cb6fb01aa32ad50bae4e064528220.1430770308.git.sebastien.guimmara@gmail.com>
	<CAPig+cTHQikgOvPrjxikUNjQoWCv2hdubJ55OG0SqpGUs_3Pow@mail.gmail.com>
	<554A8084.10506@gmail.com>
	<CAPig+cQ2e4c5hYsRbZhgyvLcMPsqshqRUZGNLwhJd57YP9JEFA@mail.gmail.com>
	<554D03C9.9030406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users <git@vger.kernel.org>
To: =?UTF-8?Q?S=C3=A9bastien_Guimmara?= <sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 08 21:00:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqnVM-0004Yh-Rg
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 21:00:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932438AbbEHTAI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 May 2015 15:00:08 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:37647 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932173AbbEHTAF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 May 2015 15:00:05 -0400
Received: by igbsb11 with SMTP id sb11so29307130igb.0
        for <git@vger.kernel.org>; Fri, 08 May 2015 12:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=dPHebyulq/MRFBpyhonH/RuojfRYxkXMFWXUN0fpq5s=;
        b=WrFfrMaVbgY0eCRNIBlZX9Hru/xajJbl0pMIf702WbRLXikBTnxbkIzqxaqb46+j3Y
         j3mTz8zkVbktPzotqB2p1CsyVsySVinWExAcF4R8pUIfGOHOIY7ADboC4hpPfww2iWic
         6u9hoTxIRP1H0Rdm3X8K61nujVrRsoiHai1aVZ2GDQdL3WcQngGhmggu8dwJKfIIAJxt
         dXE75vO04MhQ7yH8Pzjvpk0O7/8+Pxxk5UmfDDSU4ym5cBeR8DIM1FIehidwLYLJMQHf
         NPNkK4G0CGmNikH7USLmbyiD5Vmj4FKXNC9lLpwweP+bkFrKT0962xGRFP7lYoGU6pN7
         ptoA==
X-Received: by 10.42.67.80 with SMTP id s16mr5698896ici.25.1431111604507; Fri,
 08 May 2015 12:00:04 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Fri, 8 May 2015 12:00:04 -0700 (PDT)
In-Reply-To: <554D03C9.9030406@gmail.com>
X-Google-Sender-Auth: pMLPzwP4gRIGj6mVuEUpVVzWaW4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268647>

On Fri, May 8, 2015 at 2:43 PM, S=C3=A9bastien Guimmara
<sebastien.guimmara@gmail.com> wrote:
> On 05/07/2015 06:50 PM, Eric Sunshine wrote:
>> On Wed, May 6, 2015 at 4:58 PM, S=C3=A9bastien Guimmara
>> <sebastien.guimmara@gmail.com> wrote:
>>> On 05/06/2015 08:57 AM, Eric Sunshine wrote:
>>>> On Mon, May 4, 2015 at 4:28 PM, S=C3=A9bastien Guimmara
>>>> <sebastien.guimmara@gmail.com> wrote:
>>>>> -git-fast-export                                ancillarymanipula=
tors
>>>>> -git-fast-import                                ancillarymanipula=
tors
>>>>> -git-fetch                               mainporcelain common
>>>>> +git-fast-export                         ancillarymanipulators
>>>>> +git-fast-import                         ancillarymanipulators
>>>>
>>>> Unintended whitespace changes for fast-export and fast-import line=
s? I
>>>> wouldn't have expected to see these lines change in this patch.
>>>
>>> All whitespace changes were intended to align the commands on the s=
ame
>>> column. I realize this should be the object of a separate patch.
>>
>> Strange. In my editor, all columns are already aligned. Perhaps your
>> tab with setting is incorrect? (It should be set to 8.)
>
> Actually I only removed the few tabs that were wandering in some line=
s
> to replace them by spaces (almost all lines were space aligned, only =
a few
> were tab aligned).

Ah, I see. Thanks for the explanation.
