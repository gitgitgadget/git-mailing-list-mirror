From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: push.default documented in "man git-push"?
Date: Fri, 5 Oct 2012 13:34:47 +0700
Message-ID: <CACsJy8BeWuKT_jUyRYf3cKrp7Jx07J2jPEZd96KbWEY+aiX24w@mail.gmail.com>
References: <CAN7QDoK4WCuRMu+KV6ACo9miR9_eFEE510J5PDiPk+BXLyQG9Q@mail.gmail.com>
 <CALkWK0mxLQNOE8kZUJrxYQMWXpzZW0uS+N2iGXxdRmCXTzYcBQ@mail.gmail.com>
 <CACsJy8B7Z4kVYax4igYQ-d8q6e+GrPL3UwzhHSYbJ5Qo0TiL-w@mail.gmail.com>
 <CALkWK0kKzt8ii-+O0zRM1JLenP+XKh-2Wv_v6zXkkcvTGQ2MQg@mail.gmail.com>
 <CACsJy8BB4WM1Lqz4yCGnGN2DV1Xsip3Qzh86ibBXwt2BnaNENA@mail.gmail.com>
 <CALkWK0=N0OwTyu1KDAKzM48ioevGtmMNgy5gfK2J78zSPx7CVA@mail.gmail.com>
 <CACsJy8APN-CdBZgLzuNWAa5ArR2gkcStY4GZ=79fU7sGT9pOMw@mail.gmail.com>
 <7vvcer4chm.fsf@alter.siamese.dyndns.org> <CACsJy8D5TCP+77NObD7Q58k6OKQhbZKU-i4tb2RX40xj5CPsgw@mail.gmail.com>
 <7va9w23i45.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	David Glasser <glasser@davidglasser.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 08:41:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TK1ax-00057C-8A
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 08:41:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170Ab2JEGkz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2012 02:40:55 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:40328 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040Ab2JEGkn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2012 02:40:43 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so2995779iea.19
        for <git@vger.kernel.org>; Thu, 04 Oct 2012 23:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7AxBwpTfLl+35kQYGcRa57BRh6MsE3H2j0IF3+saXwk=;
        b=WOkGgQ2pfumzuU+1GLog3Zo5lqga6bk1t9Ah+SIs7N3ihg0hvKIswdK+5/BIOB1gmq
         LJytXNZssj/yU12LJeZgJ0wCyRHtWcKOVabuz6qcgBGfM1a759LJNlc6aiVIqEImgqwH
         e4mOFS49fURO2fROuxdBdM6r6H15Cg084857XNSOFvRAx49YzXNupCGvQMPmEJWlZGc6
         OJ2kQiSuMSKrFbZxuYdesRrtAnMI3U9S3yJTMjDFRuED+rftnJzHSte24VQrWiwRIY4F
         3ZIGM1K9xFNF7X1ljTXJyw2GBPbtjgXsDV4idNABSt/dmG6WklEsBPSEsIhRth0TwwtD
         4/xQ==
Received: by 10.42.129.83 with SMTP id p19mr6450842ics.9.1349418917407; Thu,
 04 Oct 2012 23:35:17 -0700 (PDT)
Received: by 10.64.143.168 with HTTP; Thu, 4 Oct 2012 23:34:47 -0700 (PDT)
In-Reply-To: <7va9w23i45.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207069>

On Thu, Oct 4, 2012 at 12:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> On Thu, Oct 4, 2012 at 1:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> I would recommend against listing any advice.* in the command manual
>>> pages.  They are meant to give an advice in cases that are often
>>> confusing to new people and are supposed to advise how to turn it
>>> off in the message.
>>
>> OK. I think I was surprised that some messages were controlled by
>> advice.* but gave no hints about that and I found that out by other
>> means. I'll check all the advice messages.
>
> As far as I can tell,
>
>     $ git grep -e 'advice\.' Documentation
>
> shows the list in config.txt and nothing else, and they do talk
> about when they are issued, but the reasoning behind them may not be
> described to a sufficient degree (that is, unless a reader carefully
> thinks things through, s/he may not be able to figure out why).  But
> I think what we have there is more or less OK.

It's about the commands, not the documents. For example I had no idea
I could set advice.statusHints to turn off some advice. "git status"
does not say that those messages can be turned off.
-- 
Duy
