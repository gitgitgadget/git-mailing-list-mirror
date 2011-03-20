From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH -1/3] gitweb: Always call parse_date with timezone parameter
Date: Sun, 20 Mar 2011 01:25:57 +0100
Message-ID: <201103200125.59427.jnareb@gmail.com>
References: <4f21902cf5f72b30a96465cf911d13aa@localhost> <201103192318.45925.jnareb@gmail.com> <AANLkTimV7vvD0PTMejydiyW_CeUH0cuQ-2+PnRqjzob5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 01:26:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q16TR-0006qo-7l
	for gcvg-git-2@lo.gmane.org; Sun, 20 Mar 2011 01:26:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247Ab1CTA0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 20:26:08 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47635 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab1CTA0H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 20:26:07 -0400
Received: by wwa36 with SMTP id 36so6156524wwa.1
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 17:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=tHpxe2IWJrUzlJuevaX4lGU9Xg4dgnXCuj8y3HEYOQ8=;
        b=xFX1o/Nz1SOPnG0kpiF5b/DJqPMdh86jWnsnkRYCVV36cWgmA7Ae0j8Blw8iCeDNqo
         RNqqxly9IUdzrdqx+jNbZaQ4bAf6WypzxsHOXvCNLzSHBDvJ9et0BvAX5PwJWnsDaz7M
         8Gp72xk6UBZW5WOrQwh8w2ilV6qYLlnvV6ngE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=o6PG8AxrXhycyCj0xwP5J+1VOO9IpP7R3Q6ELkVl3kgt6+737VCC7mJETeXl/i8kG0
         nFHOCmJf/T7pC4tTxZs2KwsfP7Wc7sSSWFh6DZmiVDPKrrBwN/gTnvQPaOeRspTfIh+x
         blscYJaoIwhUrmUn0vVWWZ2AqK42XE5M1gVmI=
Received: by 10.216.177.71 with SMTP id c49mr2086482wem.89.1300580765841;
        Sat, 19 Mar 2011 17:26:05 -0700 (PDT)
Received: from [192.168.1.13] (abrz59.neoplus.adsl.tpnet.pl [83.8.119.59])
        by mx.google.com with ESMTPS id ed10sm2055987wbb.32.2011.03.19.17.26.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 Mar 2011 17:26:04 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTimV7vvD0PTMejydiyW_CeUH0cuQ-2+PnRqjzob5@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169477>

Kevin Cernekee wrote:

> Am I correct in interpreting "PATCH -1/3" as: "apply this before
> Kevin's set of 3 patches?"

Well, it must be applied before change of name from parse_date...
or it would have to be changed.

-- 
Jakub Narebski
Poland
