From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Using gitrevisions :/search style with other operators
Date: Wed, 10 Nov 2010 19:19:31 +0100
Message-ID: <201011101919.32848.jnareb@gmail.com>
References: <20101109083023.783fad9b@chalon.bertin.fr> <m3eiatfbg2.fsf@localhost.localdomain> <7vsjz9hz2p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Yann Dirson <dirson@bertin.fr>, Kevin Ballard <kevin@sb.org>,
	git list <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 10 19:19:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGFGx-0007qk-G2
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 19:19:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753287Ab0KJSTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 13:19:45 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:33581 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751215Ab0KJSTo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 13:19:44 -0500
Received: by ywh2 with SMTP id 2so101683ywh.19
        for <git@vger.kernel.org>; Wed, 10 Nov 2010 10:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=hToyYIeOGP0+2qwXk1rUjPzZZD8f4JBhaZUzYfQNTwA=;
        b=W1MHx3wrdA+OkwTob4EwbTmcITKp2E+8ej9Uv/gfVaAZqXtk8/7JXZIPoDJfbzp4RY
         zhA4fwifY9mboMcHQXyjdNK5+/+Xh++ssQhKhtlEcFih4hGe2zeOtL6MalOddi01OlqX
         FNmjM8b2lnfmfgQhEZQtTnS3Kv8RZ3L448SrI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=a5V9GItkfWPWIien3Bsd7e+BI55B3yFGsEpPOyLX3fKCJa28nWrwy9WtyU811P10fk
         ++1WrqsqkyxDcjf1fJ8k5ZVA4BoqVRMJuoRu/lOrJgm23MtiSYn/rFyfnasK4uBheybm
         Q/Ue9ACg6VX9XOGIadK485682GxGf6Dx6ICJ0=
Received: by 10.204.55.4 with SMTP id s4mr8572248bkg.37.1289413182586;
        Wed, 10 Nov 2010 10:19:42 -0800 (PST)
Received: from [192.168.1.13] (abvo97.neoplus.adsl.tpnet.pl [83.8.212.97])
        by mx.google.com with ESMTPS id d27sm507282bkw.2.2010.11.10.10.19.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Nov 2010 10:19:41 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vsjz9hz2p.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161167>

On Wed, 10 Nov 2010, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > The <ref>@<sth> is about reflogs
> 
> Wrong.  "@" in the olden days were limited about reflogs but not these
> days.  <ref>@<something> is about refs; <objectname>^<operation> is about
> objects (most often commits).

Fact.  I even provided example, and didn't notice it: [<ref>]@{upstream}
does not use reflogs, but config.
-- 
Jakub Narebski
Poland
