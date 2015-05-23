From: Allen Hubbe <allenbh@gmail.com>
Subject: Re: [PATCH v5 1/1] send-email: Add sendmail email aliases format
Date: Sat, 23 May 2015 18:24:52 -0400
Message-ID: <CAJ80savVjb3_iKhNWPjQNK72DL7eq5YkbjWWG-1Gkx5+LOjzeg@mail.gmail.com>
References: <49e9a95b52aa61ed4f37edf1dfa178186acb4a29.1432367540.git.allenbh@gmail.com>
	<xmqqfv6nchmf.fsf@gitster.dls.corp.google.com>
	<xmqq382ncgmb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 24 00:25:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwHqm-00055J-Ro
	for gcvg-git-2@plane.gmane.org; Sun, 24 May 2015 00:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbbEWWYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2015 18:24:54 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:32990 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbbEWWYx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2015 18:24:53 -0400
Received: by wgez8 with SMTP id z8so45590977wge.0
        for <git@vger.kernel.org>; Sat, 23 May 2015 15:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=l9LGJU8GZ4m4sGXWOazbOEsA7SfwMk3e/khbAroEmUI=;
        b=L/QTiBwaKQbznpnxL02jh7pU90m2yn9vvxtbxacp5deQj23aSRigORgWoQy4av5+WB
         OVzNl/W9+OJGkWILQs1KUW1Ti0glip4QSV22DcVPWlkOZzpGCBfwhGDzUIheABSZaS2I
         VUeW8Fm8SZD+m6RAPhQFj6YOr5vLYblYs85ro1hJt5FV8bIaSmbasnQlhIYJe81QQ/ij
         syF4aImiIOfzgrsbdihpSkKUijFc3l8Ag6gbqpMU3QGcLOZpWhNYi/7FsDFBl9QuPp6a
         wJKCFKZSwJHTDmW8IbqgQK0gPIB7SlwA/S/p6s/xSljJUj+R742TnDkctbsB4Q9ADX5U
         5YvQ==
X-Received: by 10.180.206.229 with SMTP id lr5mr19154216wic.86.1432419892186;
 Sat, 23 May 2015 15:24:52 -0700 (PDT)
Received: by 10.28.59.4 with HTTP; Sat, 23 May 2015 15:24:52 -0700 (PDT)
In-Reply-To: <xmqq382ncgmb.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269819>

On Sat, May 23, 2015 at 2:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> A small thing I noticed in the test (and this patch is not adding a
>> new "breakage"---there are a few existing instances) is the use of
>> "~/"; it should be spelled "$HOME/" instead for portability (not in
>> POSIX, even though bash, dash and ksh all seem to understand it).
>
> Well, I was wrong. Tilde expansion is in POSIX.
>
> Nevertheless, I'd prefer if we avoided it.

Alright, $HOME it will be.
