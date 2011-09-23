From: Dmitry Ivankov <divanorama@gmail.com>
Subject: Re: Fwd: vcs-svn and friends
Date: Fri, 23 Sep 2011 19:27:27 +0600
Message-ID: <CA+gfSn8UeqiLu3trecPzzqSLsUr3eNT0yVN=-991sL6oJHar2g@mail.gmail.com>
References: <CAFfmPPOBZ6cXG51mDHbj2VRDzjvH46Q7=_LvUWeMq0SGR40S1g@mail.gmail.com>
	<20110915100106.GB2328@elie>
	<CA+gfSn9KVN2iDCevd0s+TjYHNupDez8NiKZycP3pgBCkYiraFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Michael Barr <davidbarr@google.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 15:27:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R75mu-0006Y7-Sb
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 15:27:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754116Ab1IWN1b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Sep 2011 09:27:31 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:54136 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753680Ab1IWN12 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Sep 2011 09:27:28 -0400
Received: by qyk7 with SMTP id 7so3866550qyk.19
        for <git@vger.kernel.org>; Fri, 23 Sep 2011 06:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=BsOG/KZn4xtHvfwNdPT1r2P3R/i0H8ye4gM59svhPx8=;
        b=kwCOP/V5ShzdnSsHkIeTyG72HzRSCdDbn8/zJfgkjMk9SVZTmVn0sa9IFxKvn7QR9a
         GdvKppQWn7lPJCx/24jpB+AHCidtZzEBHkJ5rv6fPUHgxYpjfsD558K/HbVuFioTZizM
         Uz5f4IEnz8qRRq5eDVOj2CYidR+x35WLwzXe0=
Received: by 10.229.26.148 with SMTP id e20mr1096178qcc.54.1316784447600; Fri,
 23 Sep 2011 06:27:27 -0700 (PDT)
Received: by 10.229.224.17 with HTTP; Fri, 23 Sep 2011 06:27:27 -0700 (PDT)
In-Reply-To: <CA+gfSn9KVN2iDCevd0s+TjYHNupDez8NiKZycP3pgBCkYiraFQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181963>

On Thu, Sep 15, 2011 at 7:00 PM, Dmitry Ivankov <divanorama@gmail.com> =
wrote:
>> =A0- 3bba32e9 ("fast-import: allow top directory as an argument for =
some
>> =A0 commands"): I'm not sure what the motivation is --- is this just
>> =A0 about the principle of least surprise, or did it come up in prac=
tice
>> =A0 somewhere?
> (to ease one's reading, commands are ls, copy and move top directory)
>
> Haven't seen them in practice. It seemed possible with svn import: if=
 there were
> no branches at start, and then someone did svn mv . trunk. But it
> turns out that my
> svn client doesn't allow such move. So more like a least surprise pur=
pose.
I think now that this commit should go separately if at all.
Especially considering
my other activity on fast-import (and thus possible merge conflicts) th=
at isn't
strictly necessary for vcs-svn and friends.
