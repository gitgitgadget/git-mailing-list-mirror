From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] minor typo fix for git-rebase
Date: Sun, 8 Aug 2010 17:08:42 -0500
Message-ID: <20100808220842.GA7634@burratino>
References: <20100808053001.GD8115@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>
To: Willy Tarreau <w@1wt.eu>
X-From: git-owner@vger.kernel.org Mon Aug 09 00:10:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiE4g-0007HZ-Tw
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 00:10:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754094Ab0HHWKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Aug 2010 18:10:10 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:50178 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569Ab0HHWKI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 18:10:08 -0400
Received: by gwb20 with SMTP id 20so3210818gwb.19
        for <git@vger.kernel.org>; Sun, 08 Aug 2010 15:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=awVmt6i8nTifxktgLMOC4pG4sVNGPwGiOp9e8CY0Viw=;
        b=pHosQlnTkPrmF/xstykL5wOM5zOOwGtUfNj452arMrNRKVMKn6rb9xIwjOsJGk3wmu
         eUxvJeoXXpXYzGHRCNvpawAcqkXzMOL1sHvrMFzwpZudTb0xZZ2FRxmjhnfAtJoHV9tB
         fV7jYaDMphixk09EH1ardadtyhRDAwv43RdGM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=vZZhMu9LDNVOoyEBnV31ld5TNR2L3Ywco9mvejhfh6+dNqitlYBdLyaqZ2mk83UJ3Q
         2DKngGAEvlazuj7orHjcjOycOMB3wLIgmDNASsABwteVny9EPHSMpnlN3aOBnEtcXah5
         m5la8EfKiz63/lZROqs+RsJREbTZ6rzE7vCKI=
Received: by 10.100.209.20 with SMTP id h20mr2132572ang.160.1281305407680;
        Sun, 08 Aug 2010 15:10:07 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id h5sm7118461anb.28.2010.08.08.15.10.05
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 08 Aug 2010 15:10:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100808053001.GD8115@1wt.eu>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152937>

Willy Tarreau wrote:

> -	-f|--f|--fo|--for|--forc|force|--force-r|--force-re|--force-reb|--force-reba|--force-rebas|--force-rebase|--no-ff)
> +	-f|--f|--fo|--for|--forc|--force|--force-r|--force-re|--force-reb|--force-reba|--force-rebas|--force-rebase|--no-ff)

Nice catch!  Thanks.
