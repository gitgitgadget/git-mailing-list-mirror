From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH] completion: avoid "words" as variable name for zsh portability
Date: Wed, 27 Apr 2011 11:42:28 +0300
Message-ID: <BANLkTinA5hfddqpGwOBjk+2oFDpwqORrSg@mail.gmail.com>
References: <1303867612-15975-1-git-send-email-felipe.contreras@gmail.com>
	<20110427013534.GA14286@elie>
	<7v62q0b8e0.fsf@alter.siamese.dyndns.org>
	<20110427064033.GB4226@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stefan Haller <lists@haller-berlin.de>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Mark Lodato <lodatom@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 10:42:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF0Kb-0001jv-LM
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 10:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755042Ab1D0Ime convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Apr 2011 04:42:34 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60672 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755063Ab1D0Ima convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2011 04:42:30 -0400
Received: by fxm17 with SMTP id 17so973803fxm.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 01:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=L7/EgYemZwanECNS9/arDO7/boBRwM+dKRobDw3iF50=;
        b=eDhNitxekyuomIYwnfy1Z0oivCF9QmiCCAsCCkLN4P3jFvxahjEyH1BmtSNtioCFgT
         QZ2YHtlZvecSob3MdJqt5lzGXMmox6pAX7OFQv3CqqMNmNATCnIhIYzHehZ0KpsmxZ4F
         OJKO+hrkNO2eQ1WCCpUB3LJvXww1SZL6n3bj0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CPdBYsUexL7LyEzQS8zhJpbPcYPf/rdG4gXQiaUQuvEGChtyluY9XhTXS3pku3l/Pw
         cMWbsnQD5NRql4LS19bAsRHzSxQjmgON39b5pocjPYlEAJXuV4GugSa4h8kRxoAi2WcX
         OXTp6CZHoW6bDdnLQtVDZnikym/G5ovQa9af0=
Received: by 10.223.87.215 with SMTP id x23mr2042594fal.32.1303893748890; Wed,
 27 Apr 2011 01:42:28 -0700 (PDT)
Received: by 10.223.74.130 with HTTP; Wed, 27 Apr 2011 01:42:28 -0700 (PDT)
In-Reply-To: <20110427064033.GB4226@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172201>

On Wed, Apr 27, 2011 at 9:40 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
>> I'd love to share the enthusiasm, but find that "as we can see" need=
s a
>> much more clarification.
>
> Sorry, I got carried away (I am happy to see someone has made some
> headway in investigating this old bug). =C2=A0How about this?

What's wrong with my patch?

> There is still a "for unknown reasons" in the above explanation.

I'm asking zsh guys:
http://www.zsh.org/mla/workers/2011/msg00515.html

--=20
=46elipe Contreras
