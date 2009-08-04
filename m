From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Please make git-am handle \r\n-damaged patches
Date: Tue, 4 Aug 2009 23:05:54 +0200
Message-ID: <81b0412b0908041405u1da859f2lf23d6ba25e3bef1f@mail.gmail.com>
References: <4A7735B0.2040703@zytor.com>
	 <81b0412b0908032335s3363849aj32a0e93efa15c012@mail.gmail.com>
	 <7v7hxk5b4y.fsf@alter.siamese.dyndns.org>
	 <40aa078e0908041359p79b111eo2f389dde25bb0876@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 23:06:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYRCt-0000Ob-54
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 23:06:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755053AbZHDVFz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Aug 2009 17:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754983AbZHDVFy
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 17:05:54 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:36222 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754726AbZHDVFy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Aug 2009 17:05:54 -0400
Received: by fxm17 with SMTP id 17so3530252fxm.37
        for <git@vger.kernel.org>; Tue, 04 Aug 2009 14:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9ok59hIs/qgY1jkPnctPwT1m6n0y01Q+ei6MClSKRAU=;
        b=LxDobM9m0STQdWy90d3riCMmgy5wmgIBzeXqkVMgt0w8p42E/xcGx/xY1XzEKlKRtA
         yQK9Kubd+owLMy3Uyrgn4lH3k2kPOhzynPToxYLEnXx5AA49VWeqa3RvaA8sXDKcp0N2
         9MUbIRw+IRw7Ep9AyIQryF00+yX4BAlcSdITI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HgT/7eLINwuOS1178IXHY//QKcd+8k/ANj6FG7nnn5WXSe7Gczl6u7GBhWFta721mc
         2DBAycCiyFDWL8Oc8bRwljCpaHANLSlsXqhXyjoT3ZjXuoqCZ8emsRRNVCYahE/tp7yh
         XPt2SIgW1HIS2NmIVShc60GjxdaiQipkt+OxM=
Received: by 10.204.52.138 with SMTP id i10mr138639bkg.0.1249419954161; Tue, 
	04 Aug 2009 14:05:54 -0700 (PDT)
In-Reply-To: <40aa078e0908041359p79b111eo2f389dde25bb0876@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124811>

On Tue, Aug 4, 2009 at 22:59, Erik Faye-Lund<kusmabite@googlemail.com> =
wrote:
> On Tue, Aug 4, 2009 at 8:46 AM, Junio C Hamano<gitster@pobox.com> wro=
te:
>> I thought about this approach, but it made me worried about a case w=
here
>> an otherwise sane piece of e-mail has \r at the end of one line as t=
he
>> real payload.=C2=A0But as long as we are talking about a text e-mail=
 (and we
>> are talking about mailsplit here and a binary payload with a CTE app=
lied
>> counts as text), I think we can safely use an approach like this.
>
> RFC 2822, section 2.3 explicitly states that a CR should not occur
> without a LF (and vice versa, but the e-mail client might convert CRL=
=46
> to LF when saving to file), so I think this should be safe.

You missed this line in original posters e-mail:
"In a serious case of craniorectal immersion..."

We are not safe from that and alike.
