From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 6/7] gitweb: group styling
Date: Fri, 17 Sep 2010 18:26:15 +0200
Message-ID: <201009171826.15454.jnareb@gmail.com>
References: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com> <1284629465-14798-7-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 17 18:26:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwdlX-0006nl-2d
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 18:26:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755830Ab0IQQ0S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Sep 2010 12:26:18 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:52874 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755794Ab0IQQ0R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Sep 2010 12:26:17 -0400
Received: by bwz11 with SMTP id 11so2785398bwz.19
        for <git@vger.kernel.org>; Fri, 17 Sep 2010 09:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Trz1YM7W2Ybu0xzRTokQ3vFZpXSpbavtQN2tBdL7PKM=;
        b=CdAzC9qxBTgfpinfIU0vTQ2UjtxHJEmKtGB9yOtN1vbGB4bwnT0soGmLur7T1/ne3e
         o4zvhOnlCCkIk5jaxWGI27yzJaSIunHo+eMFDWmaEGife5PXClbqYJRtJ0wkKrH1K5y5
         JSrJdnDCpbxofmt1aCNyzeK7gZ6Vh7yoEkMxs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=p7+v7jncInAPbdbeQfuwVn0YAF/PYI+muz/LpU3WzcCZCE7g1i1a+LX5A7T5YqpOzr
         0QTA904xp2AeJb2wxMSkNFNWom8WwBRY8aWnEz/uh/Vt/7STKSFvxPV3XAqTkz5qJIhS
         +JWFiVTJyks/hIjsg56BIqk337a+BncpWtEzA=
Received: by 10.204.103.16 with SMTP id i16mr3704947bko.98.1284740776009;
        Fri, 17 Sep 2010 09:26:16 -0700 (PDT)
Received: from [192.168.1.13] (abvo68.neoplus.adsl.tpnet.pl [83.8.212.68])
        by mx.google.com with ESMTPS id g12sm3782666bkb.14.2010.09.17.09.26.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 17 Sep 2010 09:26:14 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1284629465-14798-7-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156395>

On Thu, 16 Sep 2010, Giuseppe Bilotta wrote:

> +div.group {
> +	margin: .5em;
> +	border: 1px solid #d9d8d1;
> +	display: inline-block;

Is this 'display: inline-block;' really necessary?  I think we can do
without it (and I've heard that there are problems with it, but those
might not matter in layout used by gitweb).

Otherwise nice.

> +}

-- 
Jakub Narebski
Poland
