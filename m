From: =?UTF-8?B?w5h5dmluZCBBLiBIb2xt?= <sunny@sunbase.org>
Subject: Re: t5516-fetch-push.sh fails with current master (74301d6)
Date: Wed, 21 Oct 2015 04:01:26 +0200
Message-ID: <CAA787rnog5BorqYcs3noKRsd5Rkbh-mm2sENEn1XywzKhgen=g@mail.gmail.com>
References: <CAA787rnfwVgE=40WF6co4cfMi0gNa8oT7dL-Wy1Gnto_gEF8AQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 21 04:02:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZoijL-00053g-UF
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 04:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752796AbbJUCCN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Oct 2015 22:02:13 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:34311 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667AbbJUCB5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Oct 2015 22:01:57 -0400
Received: by lbbwb3 with SMTP id wb3so28168253lbb.1
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 19:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:content-type:content-transfer-encoding;
        bh=dNgK/ed1Vk7ZBK0gpC+n7bwDrp/ud4LrzQ3GqCj/SVk=;
        b=J09nEUYvEwCY7rjM/Zlh6XvDn5r80tpk9R8dIktV6mNQdFJYH8t417Z3RA414ZVhXh
         wBYmkXjpmbPf6P7JFNwgOsNw3ZzU9mIp3mr2HvyYXa9ozVZUnz9jYKoz+pwgeC52+Zbv
         QTNEjOEM+t8WqLeOhHwuJonre5jfOBPBkE6YFv0n+UmrYyLHy/0nbrkWpM6z4LlyVQc5
         c8xfUESoBdDPbONPVL4LyDsgaSliD77RkJ0RW+sfRv+lKCHSNJ6xrM4DUQNFcsVzxjNr
         wltHYXvHAxmVEMuA3eVmfC4ptZz/+f9PI3fG/Dzy7MH6EeG/DJSExoR+TFHGHxMhKxW7
         juUg==
X-Received: by 10.112.163.193 with SMTP id yk1mr3580785lbb.1.1445392915946;
 Tue, 20 Oct 2015 19:01:55 -0700 (PDT)
Received: by 10.25.25.137 with HTTP; Tue, 20 Oct 2015 19:01:26 -0700 (PDT)
In-Reply-To: <CAA787rnfwVgE=40WF6co4cfMi0gNa8oT7dL-Wy1Gnto_gEF8AQ@mail.gmail.com>
X-Google-Sender-Auth: iS8xafZ1RuddY5nwNCGaxUy1Y9Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279960>

On 21 October 2015 at 03:40, =C3=98yvind A. Holm <sunny@sunbase.org> wr=
ote:
> When building from current master (74301d6, "Sync with maint",
> 2015-10-20), test #75 in t5516-fetch-push.sh fails

If it's of any value, the contents from
t/trash\ directory.t5516-fetch-push/ can be downloaded from
<http://tmp.sunbase.org/trash_directory.t5516-fetch-push.tar.gz>.

Regards,
=C3=98yvind
