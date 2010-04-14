From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH v2 0/4] A new library for plumbing output
Date: Wed, 14 Apr 2010 23:16:06 +0200
Message-ID: <201004142316.07947.jnareb@gmail.com>
References: <20100411231824.67460.24844.julian@quantumfyre.co.uk> <201004142110.36453.jnareb@gmail.com> <80f140cdddc016f9b4608d79f1bc3722@212.159.54.234>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Eric Raymond <esr@thyrsus.com>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Wed Apr 14 23:15:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O29vv-0005rE-Ig
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 23:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755952Ab0DNVPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 17:15:33 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:41366 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753725Ab0DNVPc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 17:15:32 -0400
Received: by bwz1 with SMTP id 1so982837bwz.2
        for <git@vger.kernel.org>; Wed, 14 Apr 2010 14:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=YHcwezH1Ai1Q4FSGd0eMFqS0DumDA/9lw/hUBJo7Ltc=;
        b=U4x9lXoVeFbelXyQE2c1WTiYyZ4ktQSfotz+LPWGzp+575JgLc4VIy3H08aYpP0gMJ
         EA1rh5jDtLIPhGPlxxN4dCEIf2LqGzxMdeGaSvwKqSIC6jeKedz+zf48LnCdqkQKoLmB
         SxXE3qGa8a36Gy5cEGsPf1yLUAEouVak5LUOI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=BNvhXnuKNZi7lkTFC7SASlDrP5Zgd3ZCCkT/AbiCjcBejBD0o3TJIkCCg98PPKUJr7
         wYsoDePq6WZrKEE2qxRflxsZffnLICFww9CqXrtdtsCgkydSrCQy8vwXr9OJTSCraaUv
         dqs9/Brae6Ciocx7OYJ1S5c4PqWxGuyAETiYM=
Received: by 10.204.16.73 with SMTP id n9mr9419174bka.21.1271279730503;
        Wed, 14 Apr 2010 14:15:30 -0700 (PDT)
Received: from [192.168.1.13] (abvo40.neoplus.adsl.tpnet.pl [83.8.212.40])
        by mx.google.com with ESMTPS id 15sm729828bwz.4.2010.04.14.14.15.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 14 Apr 2010 14:15:29 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <80f140cdddc016f9b4608d79f1bc3722@212.159.54.234>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144917>

On Wed,  14 Apr 2010, Julian Phillips wrote:
> On Wed, 14 Apr 2010 21:10:35 +0200, Jakub Narebski <jnareb@gmail.com>
> wrote:

> > 'git blame' has --porcelain and --incremental output, which is line-based
> > and pretty much self-describing (with "header-name value" syntax for most
> > of it), and well documented.  JSON output would only add unnecessary
> > chatter and different quoting rules.
> 
> That depends really.  If you are writing something to parse the output,
> and you already have a JSON parser available then it's the current output
> that has different quoting rules. ;)

True.

> 
> Anyway, I have already converted blame to use the library for both
> --porcelain and --incremental output, so it'll be in the next version of
> the patch series.  So you can try before you buy ...

Nice.

How did you managed to work with a bit non-standard rules of --porcelain
format, namely maybe-quoting of filenames, and that not all lines conform
to "<header> SP <value> LF" syntax: group definition begins with SHA-1,
and contents is indented with TAB?

-- 
Jakub Narebski
Poland
