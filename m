From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2] Documentation: Document diff.<tool>.* and filter.<driver>.* in config
Date: Fri, 1 Apr 2011 15:50:16 +0200
Message-ID: <201104011550.17750.jnareb@gmail.com>
References: <m3ipuy49fg.fsf@localhost.localdomain> <1301654600-8901-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Git list <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 15:50:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5ekF-00030Q-Hb
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 15:50:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756138Ab1DANua (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 09:50:30 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37925 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755938Ab1DANu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 09:50:29 -0400
Received: by wya21 with SMTP id 21so2958157wya.19
        for <git@vger.kernel.org>; Fri, 01 Apr 2011 06:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=CJhEDc8M3JMmOKOv+ICJit2keBmO5n7drD0jDf5NHb8=;
        b=wbM47PzlMTzJbyKWJsA4znv+DvLtaidN6TxsZnvzeLWEsGGHliJjA/ZJGpKJZmzbtF
         vtQAzshWwNdsJmvdpMEewSewFWa9AOPZE0qCxjIxH+8BM1vgC96S3Rn9qP2LXchS4ru6
         nUDvMYzDPgjKJYQF6Lj01zTsA9NweSsDulw0c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=TXPcYliNeJ+kHTJS8dOUuEhEfFHuSrvRwmiEQUBAaF4cJ2p0R0YFkMJ8cVeyLJRKkz
         mYPdg+ILT8xTv2cm8A3A3ajuNtdv+2iRzNJ/E1YlYcx9txYtnQIrCqkX7UypEF9GxO53
         vgTmcmwCgiI7JZUH17vIs5ru9Gftsdo03g9N4=
Received: by 10.216.123.66 with SMTP id u44mr3726390weh.109.1301665828269;
        Fri, 01 Apr 2011 06:50:28 -0700 (PDT)
Received: from [192.168.1.13] (abvl248.neoplus.adsl.tpnet.pl [83.8.209.248])
        by mx.google.com with ESMTPS id r57sm1013319wes.1.2011.04.01.06.50.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 01 Apr 2011 06:50:25 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1301654600-8901-1-git-send-email-artagnon@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170583>

Ramkumar Ramachandra wrote:

> +diff.<tool>.funcname::
> +	Specifies a regular expression that matches a line to use as
> +	the hunk header for files with `diff=<tool>` gitattribute. A
> +	built-in pattern may also be used.  See
> +	linkgit:gitattributes[5] for details.
> +
> +diff.<tool>.xfuncname::
> +	Same as 'diff.<tool>.funcname', except that an extended
> +	regular expression can be specified in this case.

Don't we deprecate funcname in favor of xfuncname, perhaps to the point 
of not documenting the former?

-- 
Jakub Narebski
Poland
