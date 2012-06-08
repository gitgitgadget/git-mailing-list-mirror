From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: Re: show refs points to a commit
Date: Fri, 8 Jun 2012 22:10:29 +0200
Message-ID: <CAN0XMOK=KwHSc0oZZJYBSmqYLG31W0vcA=Qt929uCf7PHsuqiw@mail.gmail.com>
References: <CAN0XMO+G6K0FZgu35OuuqGEp322vLpakXHXBTPpUQmoex68srA@mail.gmail.com>
	<4FD256CC.5010801@lyx.org>
	<CAN0XMO+FpCWgf96ffZ0qd7TNEmdBXicvvk23fnXBaTK_7weV-g@mail.gmail.com>
	<7v4nqld11k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Vincent van Ravesteijn <vfr@lyx.org>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 08 22:10:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sd5Vy-0004Vs-VO
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 22:10:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759401Ab2FHUKb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jun 2012 16:10:31 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:37086 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758931Ab2FHUKa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jun 2012 16:10:30 -0400
Received: by wgbdr13 with SMTP id dr13so1214018wgb.1
        for <git@vger.kernel.org>; Fri, 08 Jun 2012 13:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=gLi7Fnn9w6kSIOO/025kf3tPmAdw/NbeCY9Rikebm7A=;
        b=UbxSLMtgamGWCVntmiCIW4hlBueShczpNfwQgaknhcFF0v+/JegFT2aMXPFn7RCREs
         dfOCN7IEAU+NKo1QJzjSYe4qWXkZA/ltqe9aIY0yrmx7ySgSA+3m8xZXIquvx1LJ/0AA
         awGtvKzm7NIHV76oLWItWlgweRi7pn11yKdtdCna3RAycN4K/dWTmno1Z//uOBQFYy2n
         xfUnIPRMkX/lD4iCS2jPOvbrpSJ4tvcrBfLJkvhV1hgf/5bUiIfQgMVojbPBs7/72ENt
         cJkMudEoxmSonrY3NbXVef2nvqADrsALu9xScSspybm0DoK+SeCPuwAyheQTXWYdLNcC
         xspQ==
Received: by 10.180.80.37 with SMTP id o5mr3091829wix.12.1339186229740; Fri,
 08 Jun 2012 13:10:29 -0700 (PDT)
Received: by 10.194.0.132 with HTTP; Fri, 8 Jun 2012 13:10:29 -0700 (PDT)
In-Reply-To: <7v4nqld11k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199529>

> "git for-each-ref" gives the mapping from the tip of your refs to
> object names. =C2=A0We do not keep and give reverse mapping but there
> should be enough information in for-each-refs output to get the
> information yourself, I think.

But you need to grep if you have a big list, don't you?
Michael H. points me to: "git log -1 --decorate"
which works very well to me.

Thanks
