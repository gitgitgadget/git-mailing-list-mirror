From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Enable highlight executable path as a configuration option
Date: Tue, 21 Sep 2010 21:09:40 +0200
Message-ID: <201009212109.41676.jnareb@gmail.com>
References: <4C96938C.5050505@cdwilson.us> <201009201110.38271.jnareb@gmail.com> <4C985DDF.8060807@cdwilson.us>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"Alejandro R. =?iso-8859-1?q?Sede=F1o?=" <asedeno@mit.edu>,
	git@vger.kernel.org
To: Christopher Wilson <cwilson@cdwilson.us>
X-From: git-owner@vger.kernel.org Tue Sep 21 21:10:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oy8E4-00086o-NG
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 21:10:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755244Ab0IUTJy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 15:09:54 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53373 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683Ab0IUTJy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 15:09:54 -0400
Received: by bwz11 with SMTP id 11so5349572bwz.19
        for <git@vger.kernel.org>; Tue, 21 Sep 2010 12:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=+pE4OzU/JwnIMDxx/sAzmXfAV2/CSpROBL1U8chVjJM=;
        b=l8IjR4405apzFCxPDj06OOLR8EtCva5wDSasbS3dYPEhTtY91nikkfF1uQJnOEGXxz
         pvnBPgv4rBoSaf9qU7xP6TwU2fyW2fNyyMfgyMW4H7L73P5v2Vk4PCi/xEbFAB6wY1DE
         ++P1I78RTXmCQPQbLpKtn5aHgGKBd6Zvgawro=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Yeg73V2rt2N0d1xnXvIIu2yRHbXbR5M/pLWJn5MY6h4RLiJOrWmRavCVMdHDlofHV4
         rlr9PZSrI4xoOAtxHUvTak98inXOc5xIpD15ipmlSU7fpIp2/AwFaAKrxuuCzpRFGJ5q
         bwvsZDvx7t2fD5S7ei+buruMpz4pbFJCNLTug=
Received: by 10.204.66.206 with SMTP id o14mr8046743bki.159.1285096192592;
        Tue, 21 Sep 2010 12:09:52 -0700 (PDT)
Received: from [192.168.1.13] (abvk112.neoplus.adsl.tpnet.pl [83.8.208.112])
        by mx.google.com with ESMTPS id d27sm7908918bku.22.2010.09.21.12.09.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 21 Sep 2010 12:09:50 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4C985DDF.8060807@cdwilson.us>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156743>

On Tue, 21 Sep 2010, Christopher Wilson wrote:

> Jakub, thanks for the helpful feedback.  I included the updated patch
> (see below) which includes the changes you suggested. 

> -- >8 --
> Subject: [PATCH] Enable highlight executable path as a configuration option
> 
> Allow build-time/run-time configuration of the highlight executable
> (must be the one from http://www.andre-simon.de due to assumptions
> about parameters and output).  Defaults to previous behavior which
> assumes that highlight is available on the server PATH. However, if
> this is not the case, the path to the highlight executable can be
> configured at build time as a configuration variable
> 
>     HIGHLIGHT_BIN = /path/to/highlight
> 
> or at runtime by configuring GITWEB_CONFIG
> 
>     $highlight_bin = /path/to/highlight
> 
> Signed-off-by: Christopher Wilson <cwilson@cdwilson.us>

For what it is worth it:

Acked-by: Jakub Narebski <jnareb@gmail.com>

It would certainly be nice to have tests for $highlight_bin, but even
assuming that HIGHLIGHT prerequisite is met, I don't know how such test
could be written.  It is not a show-stopper.

-- 
Jakub Narebski
Poland
