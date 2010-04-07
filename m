From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH/RFC] gitk: refresh index before checking for local changes
Date: Thu, 8 Apr 2010 02:36:13 +1200
Message-ID: <x2w2cfc40321004070736q7ab306b7i6220ffd58f724cec@mail.gmail.com>
References: <l2hc6c947f61004061557x8085600fif5e973077d9eb4f3@mail.gmail.com>
	 <20100406233601.GA27533@progeny.tock>
	 <n2kc6c947f61004061647ybb6c2f55zc70197362764ef8@mail.gmail.com>
	 <20100407004353.GA11346@progeny.tock> <4BBBEC43.5000100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Alexander Gladysh <agladysh@gmail.com>, git@vger.kernel.org
To: gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 07 16:36:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzWMh-0004hv-L0
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 16:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932673Ab0DGOgS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Apr 2010 10:36:18 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:60934 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932660Ab0DGOgR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Apr 2010 10:36:17 -0400
Received: by pva18 with SMTP id 18so712131pva.19
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 07:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=brJvefDlfiJkNjHu4ewBzhfWmkfe4k4NYZCP2oz1kLE=;
        b=iq+jg0Y/RI8udoMGfYbAXwggl540oJ+mKRc41811JYt+9hUypw2TdJ+l37hFYJD2H4
         Rb/crUQjhSZJjTpQEgL5R/MEWvcid9KScBns2DbXs5blStEiW8B8IFv1B3gaRVSDzYXF
         Aa9t22SZ8NJXLHbIZaYJ17R+5N75ZxpfAeopQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CjQGqiIYvMWdyqixcVqWsoFmNvjMpmWmYKTBpARH8SBa3T2DW+SEcqr+/ZRtEK5MSU
         rNRcAyF14dqagDci+FA3pVAgvr2MsMqo2k6oYhQGMkzyNDNButFliNzKSbr/9IYwyXtk
         +rlwLcc33qfTfSzrgQZOLmt+nRN6xVP7baV8Y=
Received: by 10.114.112.15 with HTTP; Wed, 7 Apr 2010 07:36:13 -0700 (PDT)
In-Reply-To: <4BBBEC43.5000100@gmail.com>
Received: by 10.115.145.15 with SMTP id x15mr4125882wan.45.1270650974622; Wed, 
	07 Apr 2010 07:36:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144224>

On Wed, Apr 7, 2010 at 2:21 PM, A Large Angry SCM <gitzilla@gmail.com> =
wrote:
>
> NAK - gitk should not modify a repository and/or working dir unless
> _explicitly_ prompted to by the user.
>
> If you want a new _non-default_ option setting for gitk, that fine al=
so.

gitk and git gui currently behave differently in this regard.

git gui updates the indexes view of the working tree on start, gitk doe=
s not.

gitk's current behaviour is somewhat mysterious to the uninitiated -

user: "what? I have local changes?"
tool: "relax dear user what you see is dirty laundry. if you want to
see the actual state, start git gui then come back to me and refresh
me when you are done"

gitk is effectively lying to the user about the state of their working
tree. git gui does not.

Needless to say, I support this change.

jon.


> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
