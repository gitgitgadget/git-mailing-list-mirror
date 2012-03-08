From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [ANNOUNCE] Git 1.7.10-rc0
Date: Thu, 8 Mar 2012 17:29:16 +0700
Message-ID: <CACsJy8CYTnrcAX6TNORdg=KAk4_xNupT11Uw8o8gnW6NtQtMCA@mail.gmail.com>
References: <7v7gyvkh84.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Thu Mar 08 11:30:01 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1S5abf-0006kv-Ii
	for glk-linux-kernel-3@plane.gmane.org; Thu, 08 Mar 2012 11:29:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753854Ab2CHK3t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 8 Mar 2012 05:29:49 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55116 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795Ab2CHK3r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Mar 2012 05:29:47 -0500
Received: by wgbdr13 with SMTP id dr13so348611wgb.1
        for <multiple recipients>; Thu, 08 Mar 2012 02:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=vlQmEuLUlxunYeNoQ0ZHhvczUL0RhxhDaM8WF6bCZRc=;
        b=J0g2GyAncXdWK25h3jSJqwg1ahb60ygJh+HQKvyqzqhi2P6TpCuIyuYobFkoe/WjE/
         FjabpZGl2/90j+Tx2B7bY6JX3hDNidSslrgjv9t+E3zzRnhrnYWdZF6BPs2SUeVHc52c
         vJmIqis9PKzIbuDJV+2O5MELeUHVsMqbqAgZpBDGAZczBaGZgmQ7bwr09Y9wqtr/iVq2
         NLO4W92Fd/QEmoFAISxbEd4ErfC/bJP9koM6L/FOBy7VrKd7T6apgmK4oph84SSo5ZzZ
         88mKnaNGauX1q2cs9n/oKByCXYpmgX1v4jArjimnzrIQzGsL7yJzC+5xraSWXlzVlAlk
         OtYg==
Received: by 10.180.98.8 with SMTP id ee8mr11504264wib.14.1331202586392; Thu,
 08 Mar 2012 02:29:46 -0800 (PST)
Received: by 10.223.13.5 with HTTP; Thu, 8 Mar 2012 02:29:16 -0800 (PST)
In-Reply-To: <7v7gyvkh84.fsf@alter.siamese.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192552>

On Thu, Mar 8, 2012 at 8:35 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> =C2=A0* "git clone" learned "--single-branch" option to limit cloning=
 to a
> =C2=A0 single branch (surprise!).

--single-branch also limits fetching tags to minimum, I'm not sure we
need to mention that. It may be a good idea to mention "shallow clone"
or --depth, where this feature is most beneficial, to catch people's
eyes if they are interested in shallow clone.
--=20
Duy
