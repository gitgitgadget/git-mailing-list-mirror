From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Why does 'submodule add' stage the relevant portions?
Date: Mon, 25 Mar 2013 12:13:56 -0700
Message-ID: <20130325191356.GC1414@google.com>
References: <CALkWK0=PHNmT5zfjEaWh_5=aV7wcPdGgyCWFhjaeVrrWhL0OBw@mail.gmail.com>
 <7v38vjz7sx.fsf@alter.siamese.dyndns.org>
 <CALkWK0mRnDMFLeVoG85CUZ48rf7X_jHV=0XP73WL7zp2OGpezQ@mail.gmail.com>
 <20130325182023.GA1414@google.com>
 <CALkWK0kx_uQy-97nByNXBOU4UruhvdjOeXCpKHR9mNUQHs5o=A@mail.gmail.com>
 <7vppynxre7.fsf@alter.siamese.dyndns.org>
 <CALkWK0kOHPrid3V5tPWBaf5eh1t7tM_oXqsQFnXugBKUGKGpUA@mail.gmail.com>
 <20130325185032.GB1414@google.com>
 <CALkWK0nFVOhTjY3dfcwPvjqLZgJrENo6Ha=cv-x6io_Np8FfoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 25 20:14:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKCqk-0000Rw-BF
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 20:14:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758840Ab3CYTOC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 15:14:02 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:35766 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756888Ab3CYTOB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 15:14:01 -0400
Received: by mail-pd0-f174.google.com with SMTP id p12so706549pdj.19
        for <git@vger.kernel.org>; Mon, 25 Mar 2013 12:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=V1muies4GsTcug66POoTZPuu5KlimleXn+J3E/Fq4WM=;
        b=UqeVegruyHdTz3UZxDcvrziiEc20HoNGKU3GkM3U+Si5hejO9kPb4RvZFtU/D7GhCh
         26YKeunameg0IheM/YAi7Kl+YGkzE+BfvnbgoHOkTnRSlYZQgwAxzhVWc5MFRnEOuI7p
         +ibKCL95olKuZWJFZhRqaontFtmQiQI3KvpxZAkDMIgyvdffg39sO8Xfd7PgrgX9XSKf
         giQ09zqywUDC8yGUf8Ks0BYRewp9xX34dShW94lAYDi4zfxdeaYa+rk9L1WYINq/SDT3
         dTpHrWaECm5zTKC1JL4zjwxLoBXpUg6le8wlNL6IqqRT3i3hXoY0riyKdelWJ7APtdDY
         Qc9g==
X-Received: by 10.68.225.73 with SMTP id ri9mr19368078pbc.70.1364238840589;
        Mon, 25 Mar 2013 12:14:00 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id ql7sm14431164pbb.2.2013.03.25.12.13.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 25 Mar 2013 12:13:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0nFVOhTjY3dfcwPvjqLZgJrENo6Ha=cv-x6io_Np8FfoA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219067>

Ramkumar Ramachandra wrote:

> This whole "backward compatibility" thing is not black-or-white: it's
> shades of gray.  Can I ask about how "backward incompatible" the other
> suggestions I listed were, just so I get a rough idea of your scale?

It depends on how important the change is and how painful the proposed
transition is.

Please don't gratuitously break things.  If there is a smooth way to
accomplish the intended effect without much downside, that is
generally preferred, even if it is harder to write the code.

There are no absolutes here.  It is about helping people in the
real world who never asked for such-and-such feature to avoid
suffering real breakage.

Hope that helps,
Jonathan
