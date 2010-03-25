From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 1/7] fmt-merge-msg: be quiet if nothing to merge
Date: Wed, 24 Mar 2010 20:48:49 -0700
Message-ID: <4BAADD21.2020900@gmail.com>
References: <1269414964-9518-1-git-send-email-bebarino@gmail.com> <1269414964-9518-2-git-send-email-bebarino@gmail.com> <7vaatxdt0d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 25 04:49:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nue4H-0007rO-3G
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 04:49:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971Ab0CYDsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 23:48:54 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47119 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430Ab0CYDsx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 23:48:53 -0400
Received: by gyg8 with SMTP id 8so3980588gyg.19
        for <git@vger.kernel.org>; Wed, 24 Mar 2010 20:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=uWiQ41U9sf3E6xKr2U145F0KrHkn1mRiPfMV4HyM+Yg=;
        b=iRuuypkIB0vJL7sdSoi2pz1RL9qpewNcJoyBOG8wFEAPP0z3CdIU8QSaE6OOswHCpc
         YUmV0zuY3NOPWZgJok0WtpXh9+2sMfHuqzI6YIAY0tEckUQ+CS/Ejjt3df+qpAh00EiV
         g69iQatiea/eV9MlBc0XHHZNk3oK0GFNzB1zc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=dWmD6vvVmiyI07FzxJrRn9TKBVI1Pkp4F02rx1Tf1LuYyldk/aJ0hgr4jWNuh9d8lo
         naJFISfLe7BSXYAj2yQrsBDwdpzNkb5hXRaK6WivC10ZBivgT1y/t2f1/BszEAZDAPmb
         DwuJVbiTLi6LzbM63Aeyr/Z28+eIagb9mgry0=
Received: by 10.101.42.12 with SMTP id u12mr7508974anj.56.1269488932420;
        Wed, 24 Mar 2010 20:48:52 -0700 (PDT)
Received: from [192.168.1.5] (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 34sm222879yxf.36.2010.03.24.20.48.50
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 24 Mar 2010 20:48:51 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.7pre) Gecko/20091214 Shredder/3.0.1pre
In-Reply-To: <7vaatxdt0d.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143145>

On 03/24/2010 07:39 PM, Junio C Hamano wrote:
>
> Hmm, doesn't pull fail in such a case anyway?  Is there a real damage?
>
> I am just trying asses if this is with a maint-worthy urgency.  The patch
> looks sane.

I don't think this is ever triggered with pull so probably not
maint-worthy. I just ordered it that way in case you figured it as such.
