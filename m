From: "Yin Ping" <pkufranky@gmail.com>
Subject: Re: [PATCH] status&commit: Teach them to show commits of modified submodules.
Date: Wed, 7 Nov 2007 23:20:00 +0800
Message-ID: <46dff0320711070720j2af83fabm28cdbf03b82d7862@mail.gmail.com>
References: <1194004427-26934-1-git-send-email-pkufranky@gmail.com>
	 <7vd4us1jds.fsf@gitster.siamese.dyndns.org>
	 <46dff0320711021650q4e56d025q63a961176c682a14@mail.gmail.com>
	 <7vfxzoyz7f.fsf@gitster.siamese.dyndns.org>
	 <46dff0320711040125v111c75davb49e9822537f4b19@mail.gmail.com>
	 <46dff0320711040145k1edb1fcaq1daa5469c1158e81@mail.gmail.com>
	 <7vmytus0ff.fsf@gitster.siamese.dyndns.org>
	 <46dff0320711040517r6da5d7aaid849ff06df1b5bb6@mail.gmail.com>
	 <7vwsswjeom.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 07 16:20:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipmhq-0007zg-MM
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 16:20:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753602AbXKGPUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 10:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753554AbXKGPUL
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 10:20:11 -0500
Received: from py-out-1112.google.com ([64.233.166.183]:61324 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752678AbXKGPUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 10:20:09 -0500
Received: by py-out-1112.google.com with SMTP id u77so4443190pyb
        for <git@vger.kernel.org>; Wed, 07 Nov 2007 07:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=qMk4r/kCMnSdV5+SOn9AvSm0zs4ObOzyfyhdD+2dsYo=;
        b=Mk5kMYh1IK6nSqTqeM2c/ov1RMosG7ByeCyz3ps1KXoduH0OcizmoJ3XropBWDTZc2Cf4HahQksWm8znu/8y1jycUORmBUEQdvNZx4p2ob7qhsRi4rcgRAKu71ib+qzoEs6wQRovDQoVBIkDQHmn/OeWtjSzLJUS8qZxf9KU+6c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=p40kXG1XkUlVyCPN5z7NiMUq+pPXQ9l3qgkkZgaX+a/o35Yiv/duyKqnYO+3z6JzXUcHDY5JFYrkEvGXCck2z08Jo6Wioa9+WqWDfhsWLxvZk12w3qdZBd2QfGqIlJejGIkmSsJm+Q0Iz0zWp9Ew1qA83giEaF43bpwRudxKr/w=
Received: by 10.35.69.11 with SMTP id w11mr8976292pyk.1194448800364;
        Wed, 07 Nov 2007 07:20:00 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Wed, 7 Nov 2007 07:20:00 -0800 (PST)
In-Reply-To: <7vwsswjeom.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63821>

On 11/6/07, Junio C Hamano <gitster@pobox.com> wrote:
> "Yin Ping" <pkufranky@gmail.com> writes:
>
> > However, in some cases these messages are helpful. And a third kind of
> > cases is that people care about only part of all submodules.
> >
> > So, maybe some an switch can be used to turn this on or off (default
> > off)?
>
> I personally think that is overengineering.  Isn't having/not
> having the submodule directory cloned a good enough indicator
> of which submodules are interested in by the user?
>
Good suggestion. I'll give my new patch later.

-- 
franky
