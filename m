From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: git remote update -> rejected
Date: Tue, 22 Apr 2008 16:10:47 +0200
Message-ID: <480DF1E7.5040900@gnu.org>
References: <1208857733.4695.37.camel@marge.simson.net> <20080422103458.GA14751@sigio.intra.peff.net> <1208861703.18689.2.camel@marge.simson.net> <20080422111113.GB11238@sigill.intra.peff.net> <20080422124118.GA3098@mithlond.arda.local> <alpine.DEB.1.00.0804221354180.4460@eeepc-johanness> <20080422133926.GB3098@mithlond.arda.local> <alpine.DEB.1.00.0804221449240.4460@eeepc-johanness> <20080422140440.GC3098@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Mike Galbraith <efault@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Tue Apr 22 16:13:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoJDh-0005wS-1H
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 16:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765045AbYDVOKw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 10:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764586AbYDVOKw
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 10:10:52 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:53460 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763581AbYDVOKv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 10:10:51 -0400
Received: by nf-out-0910.google.com with SMTP id g13so773363nfb.21
        for <git@vger.kernel.org>; Tue, 22 Apr 2008 07:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:newsgroups:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        bh=1+Te70jVX122XuvHisT4/m3ubhJxrE6RnCIzAcrOZGQ=;
        b=qwbJnbDgLUc9BgGfcJ3EBnTpeHJNFtF4VeN0DHSapZN4s2oh5ig4E8I/L5S0F9BwTdCg6L4G7EGqS0azp0vFM2FHmcg4kuDwVCGt6lOifGXqaNRMuMqnfjiMllePBfagXtFX9CS1C3iGtL4EltNRj9YDZTxEVxSTdr1pzHE1CLM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=qCexf3ymq5zSpDjRKsTE7geg1/QjHwLY27bQ8Tkf8nuPvyu/bq06Fx0OvGK2VvJc86bk/37HUY/DrKVCzUD2x88CkH3XSoVVA1/0SnYfKv9G8fpnQGHkZvKEjamUmA86yP9jr9g2wVdIJ5O2cnrmjI9sJtgZ0xPpE7CWXNZNJwQ=
Received: by 10.86.54.3 with SMTP id c3mr568349fga.73.1208873447868;
        Tue, 22 Apr 2008 07:10:47 -0700 (PDT)
Received: from scientist-2.mobile.usilu.net ( [195.176.176.226])
        by mx.google.com with ESMTPS id d6sm4958221fga.9.2008.04.22.07.10.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 22 Apr 2008 07:10:47 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20080422140440.GC3098@mithlond.arda.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80124>


>> Okay, how about this: take Peff's patch, but add a warning if --mirror
>> is used on a non-bare repository?
> 
> Sounds good to me. Indeed, giving a warning is _very_ good idea as
> --mirror is potentially, even likely, destructive with local changes and
> working directory.

What about changing --mirror to add a push line instead of a fetch line?

Paolo
