From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 00/13] remote-hg: general updates
Date: Thu, 4 Apr 2013 03:35:43 -0600
Message-ID: <CAMP44s1yseJEgb4H7REJARHHO19f5BSD=ijQi4kwqcQZei=zWg@mail.gmail.com>
References: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com>
	<20130402200948.GF2222@serenity.lan>
	<2670C2C0-E30F-47DA-8901-899FEE11059E@quendi.de>
	<CAMP44s3DETFBhexPhEEMP1TZGNrc91266=t16H2t_+VB_4V38w@mail.gmail.com>
	<EF2F8946-4F60-4659-9215-6C21C9641AB0@quendi.de>
	<CAMP44s3qAPJtNVsb4gvYd1PunN4c-crxpVJc0K9520eiBO8iwA@mail.gmail.com>
	<CAMP44s3HcLji22JDoSVZG_cLca8LXTbUPuVv8SbAM1yTqn8zcw@mail.gmail.com>
	<836B6357-AF21-4DE7-B9D7-13CAB0170599@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, gitifyhg@googlegroups.com
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Thu Apr 04 11:36:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNgac-000805-1k
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 11:36:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758819Ab3DDJfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 05:35:45 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:39284 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758807Ab3DDJfo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 05:35:44 -0400
Received: by mail-lb0-f181.google.com with SMTP id r11so2481959lbv.40
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 02:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=SDFHCv6Zm19ZBZBQmYj3hJAciP2OErhiTs0L/NSWPho=;
        b=iUgRxO0t6R2VgFdJuP8TP8mqCQ3L9PiZskElrGZ/54Flx21cGYkW5HJBvZtWhcjiXb
         Gnv2tQlJcHJN+oT81XHmsdV6MPKO5YDHJFTFVQs0VcJghKixUEoVW2MEdX257DwwGVvh
         PX67igPh4oSCNGZSJoLoL0ywL67sSCqRAsSHylG3hCY9BEft1TbwgzXA2J1Z+/W26VsT
         ctcGtBCoZZmEWwueGHHqCyZseJbGWP4P1jDkeXAdPwXPVnvndUXQTXdBI/CDB6H2ygI6
         QNSKnHRbMQrvMTspFJSzBGvmjjwhZEnTImqpzQB7vUNpCb0tsbbE9yP4TM3li3HA/COt
         szFw==
X-Received: by 10.152.128.98 with SMTP id nn2mr2867253lab.17.1365068143226;
 Thu, 04 Apr 2013 02:35:43 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Thu, 4 Apr 2013 02:35:43 -0700 (PDT)
In-Reply-To: <836B6357-AF21-4DE7-B9D7-13CAB0170599@quendi.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219995>

On Thu, Apr 4, 2013 at 3:07 AM, Max Horn <max@quendi.de> wrote:
>
> On 04.04.2013, at 08:46, Felipe Contreras wrote:
>
>> On Thu, Apr 4, 2013 at 12:42 AM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>> On Wed, Apr 3, 2013 at 6:25 PM, Max Horn <max@quendi.de> wrote:
>>>> On 03.04.2013, at 03:31, Felipe Contreras wrote:
>>>
>>>>> I only learned about it recently, I've looked at the history and to me
>>>>> it seems rather chaotic, and a lot of the code was simply copied from
>>>>> git-remote-hg without comment.
>>>>
>>>> gitifyhg was scrapped and completely restarted from scratch at some point. Based largely on your git-remote-hg code. A bit more on its history can be read here:
>>>>  http://archlinux.me/dusty/2013/01/06/gitifyhg-rewritten/
>>
>> Please don't CC the gitifyhg mailing list, unlike vger mailing lists
>> (or any other sane list), it doesn't accept mail from non-subscribers,
>> which makes communication with outsiders much more difficult, as
>> demonstrated by this.
>
> I changed the settings of the gitifyhg list settings to accept emails from anybody.

Cool.

> Moreover, I would appreciate if you could refrain from injecting all those snide side remarks, such as the one you just needlessly made about how moderated mailing lists are insane.

I did not say that, gitifyhg's mailing list was not _moderated_, it
*automatically* rejected all non-subscriber email without any
_moderation_; that is insane in my opinion, but a lot of mailing lists
do that.

-- 
Felipe Contreras
