From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] mergetool--lib: add p4merge as a pre-configured mergetool 
	option
Date: Wed, 28 Oct 2009 23:17:43 -0700
Message-ID: <76718490910282317g56d97652k3b9fa1dbbe4abdbd@mail.gmail.com>
References: <d411cc4a0910271536u5817802at43f7477dd8ccabc7@mail.gmail.com>
	 <20091027230043.GA11607@hashpling.org>
	 <20091028090022.GA90780@gmail.com>
	 <d411cc4a0910280837h52596089je9ab4d03383d43cc@mail.gmail.com>
	 <d411cc4a0910281439v3388c243v42b3700f73744623@mail.gmail.com>
	 <7v1vkngkdm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Scott Chacon <schacon@gmail.com>, git list <git@vger.kernel.org>,
	Charles Bailey <charles@hashpling.org>,
	David Aguilar <davvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 07:24:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3OQf-0005lF-Rg
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 07:24:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753064AbZJ2GRj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Oct 2009 02:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752263AbZJ2GRj
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 02:17:39 -0400
Received: from mail-iw0-f180.google.com ([209.85.223.180]:61947 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798AbZJ2GRi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Oct 2009 02:17:38 -0400
Received: by iwn10 with SMTP id 10so1166213iwn.4
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 23:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=iuRIg/h6FP95iS/+ZZgzc7ljpNVCnIxrqF+6vwOBSGY=;
        b=CbFBf9IJLX8Q4gglPxOekktUB0dLWbgOreqHDH54QGZnf1YLsYKBgaInOCTA8xglHo
         Osa8wc723s1AsYWP1kJ17eni/8kx7oiQQMk1O7LkscoO4ZAFTXjjyg6schrp3gPZLdzk
         hr3yZ9uuiaPWSzJvyegcK7bnTekq8OHXLiG84=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MvvWpg3rrggBO2BbbS2EpXKmQCC+H8oP//R16xEMfwReNaEEWN3ZP6SAUDbna5e5iM
         ZraxvDQx4wlD06qxhOFpWWyg56R78Y1iJS7SBq8czzieiBB7NLAQoOS4KMdsdDRhCQuS
         9j/0wOAzjTQgTl8u59ZO2PgJ41lZczxyq3khc=
Received: by 10.231.20.230 with SMTP id g38mr7692346ibb.49.1256797063422; Wed, 
	28 Oct 2009 23:17:43 -0700 (PDT)
In-Reply-To: <7v1vkngkdm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131555>

On Wed, Oct 28, 2009 at 4:37 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Thanks. =C2=A0Is Jay happy with this version?

It's good enough, but I'm still going to send a follow up patch that
looks in /Applications and $HOME/Applications since I don't think the
user should have to set the full path (they don't on other platforms).

So:

Acked-by: Jay Soffian

j.
