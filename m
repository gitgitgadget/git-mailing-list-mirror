From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC/WIP PATCH 11/11] Document protocol version 2
Date: Mon, 1 Jun 2015 16:40:54 -0700
Message-ID: <CAGZ79kYD--dZ_V=_X_Eo31KYTKXt2njuf56XqRRdaTJeLhDjaQ@mail.gmail.com>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
	<1432677675-5118-12-git-send-email-sbeller@google.com>
	<xmqqsiafazr7.fsf@gitster.dls.corp.google.com>
	<CAGZ79kbELvZ6otnNwGHsgiC9EjgS2vrDGU2KCgF2c_Azm=-rWg@mail.gmail.com>
	<xmqqk2vraw6p.fsf@gitster.dls.corp.google.com>
	<20150529222120.GB15678@peff.net>
	<CAGZ79kaRTLX7eBCOA=yQHVwcN-H-o_aZFfQ1gw7Nx-NC82pbag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 02 01:44:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzZKH-00062H-8D
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 01:41:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754004AbbFAXk4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 19:40:56 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:36734 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753922AbbFAXkz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 19:40:55 -0400
Received: by qgf2 with SMTP id 2so53551121qgf.3
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 16:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=fvPeiG66UxbWEVu4wfuGQClv/s6mXOnSnpkwjVusJLI=;
        b=cc18lGMd6PB+bEPUg271WT0Dn3Bc3y97I120CN7ve+yLJcA4sNxUblqOHYetcUGCWx
         oV/PCwvK5amxcvr91JtJctVkUK0N9R8GX4iwezNLqY8ICK1ajWxfeses5Aj1P/bPbsj5
         XzYSFUFMT9gX8zdRQblFWyxzNV9KP7aIosygdTrkt+8NXgiLHuNVQL7Wyo2zDc9Yv2Fo
         rqYLcL3CsqmmHF23jSexiFYS3B8nv462ZeAh3eTJjLDfa5lSFIlGxDgdviMf0rBkCGiZ
         gFLfqkzzf3HCGLy9t9tdPtkZ1n5asANtJaYPzR3W7AIOJDvuR/7bAg3zDhra2aiXvZzF
         IyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=fvPeiG66UxbWEVu4wfuGQClv/s6mXOnSnpkwjVusJLI=;
        b=PNj5TfcSWXOQDzAlTo+pKSmEZY2ipAJllAHFoGYV2/EMiUfpA7/hQupsfEGEBh6KnK
         N5YJ+oNkvDLW7JixsMejBx3+QfaqfI3UUzErHcG8CyTeRSxq9HFFm+afvVZ9eIXCvEdu
         MV5Qm6xog3N0bW2iaw+OEn2Q2gg7wlC+1eSIc9PsvwkbzY46tsh41Q9L14QfafKh7p5E
         yos/oTGZRrwd2sgLCqu5DA37+PPsC4y9gqE7HVuOWsunqJms7S/biZ/gnU4HdeNEvrI1
         bGxIKACWP+zjF2kiqvlJPbH3DnvDk5rAZnFBVBJCwT7ZHOTNPaWSglA5JBZqGYlVqLyN
         Fk/g==
X-Gm-Message-State: ALoCoQlpWwMtA2TedYSlOEJU8qu/C3d/N26ZDGR1aF8KxFv5NfCmpo/eACprx8CA6ew3EuQz0xFP
X-Received: by 10.140.133.9 with SMTP id 9mr26785789qhf.5.1433202054908; Mon,
 01 Jun 2015 16:40:54 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Mon, 1 Jun 2015 16:40:54 -0700 (PDT)
In-Reply-To: <CAGZ79kaRTLX7eBCOA=yQHVwcN-H-o_aZFfQ1gw7Nx-NC82pbag@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270482>

On Mon, Jun 1, 2015 at 4:14 PM, Stefan Beller <sbeller@google.com> wrote:
> On Fri, May 29, 2015 at 3:21 PM, Jeff King <peff@peff.net> wrote:
>> On Fri, May 29, 2015 at 02:52:14PM -0700, Junio C Hamano wrote:
>>
>>> > Currently we can do a = as part of the line after the first ref, such as
>>> >
>>> >     symref=HEAD:refs/heads/master agent=git/2:2.4.0
>>> >
>>> > so I thought we want to keep this.
>>>
>>> I do not understand that statement.
>>>
>>> Capability exchange in v2 is one packet per cap, so the above
>>> example would be expressed as:
>>>
>>>       symref=HEAD:refs/heads/master
>>>         agent=git/2:2.4.0
>>>
>>> right?  Your "keyvaluepair" is limited to [a-z0-9-_=]*, and neither
>>> of the above two can be expressed with that, which was why I said
>>> you need two different set of characters before and after "=".  Left
>>> hand side of "=" is tightly limited and that is OK.  Right hand side
>>> may contain characters like ':', '.' and '/', so your alphabet need
>>> to be more lenient, even in v1 (which I would imagine would be "any
>>> octet other than SP, LF and NUL").
>
> I think the recent issue with the push certificates shows that having arbitrary
> data after the = is a bad idea. So we need to be very cautious when to allow
> which data after the =.
>
> I'll try split up the patch.
>
>>
>> Yes. See git_user_agent_sanitized(), for example, which allows basically
>> any printable ASCII except for SP.
>>
>> I think the v2 capabilities do not even need to have that restriction.
>> It can allow arbitrary binary data, because it has an 8bit-clean framing
>> mechanism (pkt-lines). Of course, that means such capabilities cannot be
>> represented in a v1 conversation (whose framing mechanism involves SP
>> and NUL). But it's probably acceptable to introduce new capabilities
>> which are only available in a v2 conversation. Old clients that do not
>> understand v2 would not understand the capability either. It does
>> require new clients implementing the capability to _also_ implement v2
>> if they have not done so, but I do not mind pushing people in that
>> direction.
>>
>> The initial v2 client implementation should probably do a few cautionary
>> things, then:
>>
>>   1. Do _not_ fold the per-pkt capabilities into a v1 string; that loses
>>      the robust framing. I suggested string_list earlier, but probably
>>      we want a list of ptr/len pair, so that it can remain NUL-clean.
>>
>>   2. Avoid holding on to unknown packets longer than necessary. Some
>>      capability pkt-lines may be arbitrarily large (up to 64K). If we do
>>      not understand them during the v2 read of the capabilities, there
>>      is no point hanging on to them. It's not _wrong_ to do so, but just
>>      inefficient; if we know that clients will just throw away unknown
>>      packets, then we can later introduce new packets with large data,
>>      without worrying about wasting the client's resources.
>>
>>      I suspect it's not that big a deal either way, though. I have no
>>      plans for sending a bunch of large packets, and anyway network
>>      bandwidth is probably more precious than client memory.
>
> That's very sensible thoughts after rereading this email. The version
> I'll be sending out today will not follow those suggestions though. :(

Thinking about this further, maybe it is a good idea to restrict the
capabilities
advertising to alphabetical order?

The exchange would look like this:

server:
  for capability in list:
      pkt_write(capability)
  pkt_flush

client:
  do
    line = recv_pkt()
    parse_capability(line)
  while line != flush

with parse_capability checking if we know the capability and maybe setting some
internal field if we know this capability.

Now if we assume the number of capabilities grows over time a lot (someone may
"abuse" it for a cool feature, similar to the refs currently. Nobody
thought about
having so many refs in advance)

So how does parse_capability scale w.r.t the number of capabilities?
If parse_capability is just a linear search then it is O(n) and with n
capabilities
the client faces an O(n^2) computation which is bad. So if we were to require
alphabetic capabilities, you could internally keep track and the whole operation
is O(n). I just wonder if this is premature optimization or some thought we need
to think of.

To prevent this problem from popping up, it must be easier to
introduce a new phase
after the capabilities exchange than to just abuse the capabilities
phase for whatever
you plan on doing.

Thanks,
Stefan

>
>>
>> -Peff
