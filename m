From: Ethan Reesor <firelizzard@gmail.com>
Subject: Re: [RFC/PATCH] shell: allow 'help' command to disable interactive shell
Date: Mon, 11 Feb 2013 01:11:21 -0500
Message-ID: <CAE_TNi=fN66+9WfMn86H6J_BVAjFP=xiE8m3JHe_4ANHB2V5wA@mail.gmail.com>
References: <20130210224345.GA32318@sigill.intra.peff.net> <7vfw13rd9x.fsf@alter.siamese.dyndns.org>
 <CAMK1S_jFUXiHM6teVwoxO9gv77B1KBQoSi-B32dwVKemXnDx9w@mail.gmail.com>
 <20130211012016.GA13243@elie.Belkin> <7v7gmfqzt1.fsf@alter.siamese.dyndns.org>
 <20130211041706.GB15329@elie.Belkin> <7vwqufpj50.fsf@alter.siamese.dyndns.org>
 <20130211043247.GD15329@elie.Belkin> <7vpq07pgpy.fsf@alter.siamese.dyndns.org>
 <CAE_TNim2wrL3SWxy_2ugyGmEFDngBJ8+z04y2tJFzMo4N8mUug@mail.gmail.com> <20130211060911.GH15329@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 07:12:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4mcY-0006MQ-BY
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 07:12:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489Ab3BKGLn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 01:11:43 -0500
Received: from mail-qc0-f175.google.com ([209.85.216.175]:45408 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717Ab3BKGLn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 01:11:43 -0500
Received: by mail-qc0-f175.google.com with SMTP id j3so2076851qcs.20
        for <git@vger.kernel.org>; Sun, 10 Feb 2013 22:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=TDGWCkNzdQVxeT+bLfa3oQNiz67YXdAwALap0t8tXVo=;
        b=PKkk1iTe+VpjDIotRDNmytx8L28USbPUUsd7gXeICeRlHn0329IUXz403oZNCtoL3s
         KfZIt8xtB4HUbk1r+zHK6uQfT3MrZV4FH7da4Dlwl9+l5fo3evbEqGqF2DTff5T7CV99
         V2e+vtIyO75miafmXcBsSU0dfEYm9bGxzRNNn5H4mLx9Wxy37/sBHfbPJzksDyvVP5Co
         1kkBB7kNIOUsmeQdBED995odN2k+wq241YocJht4lwIctDSA28LAohLJQQ5Wdi6VhDSJ
         CYozuMnz9izGGLL2OUSKdhsj3QlTDseRpRhpfzpckiLn6IRwMoVzLdXMV2BIRbN8XX27
         Th1Q==
X-Received: by 10.224.208.9 with SMTP id ga9mr5168707qab.1.1360563102112; Sun,
 10 Feb 2013 22:11:42 -0800 (PST)
Received: by 10.49.95.225 with HTTP; Sun, 10 Feb 2013 22:11:21 -0800 (PST)
In-Reply-To: <20130211060911.GH15329@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216000>

Why not have both? That way there is a way to get a customizable
response that avoids Junio's complaints and there is a way to do what
you are trying to achieve.

On Mon, Feb 11, 2013 at 1:09 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ethan Reesor wrote:
>
>>                        That way, there's a default setting, there can
>> be a system-wide message, there can be a user specific message, and
>> those messages can be set via `git-commit`.
>
> That won't let me imitate gitolite's behavior without a lot of
> config file churn:
>
>         $ ssh git@localhost
>         Hello, jrn.  This is git@elie running git-shell 1.8.1.3.
>
>          R W    path/to/one/repo
>          R      path/to/another/repo
>         $



--
Ethan Reesor (Gmail)
