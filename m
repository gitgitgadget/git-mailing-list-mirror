From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/2] log/ format-patch improvements
Date: Thu, 26 Aug 2010 00:46:59 -0500
Message-ID: <20100826054659.GC9708@burratino>
References: <1282422531-29673-1-git-send-email-artagnon@gmail.com>
 <20100825084416.GC3280@kytes>
 <20100825205416.GB2319@burratino>
 <20100826053439.GB9407@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Jakub Narebski <jnareb@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 07:48:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoVKS-0000PN-Fe
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 07:48:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642Ab0HZFsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 01:48:43 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:53215 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617Ab0HZFsl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 01:48:41 -0400
Received: by gxk23 with SMTP id 23so501687gxk.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 22:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Q0DzbsRoxbsR/naPtjH9hTSug2Htwoiqa9epF6ZXHPM=;
        b=kwEfIkAhxww6jkcwqEKTzWLb9hUDk97SVPCTS7mJYfHQOJ2iDRwBKrY9p9GillODkb
         mHcI9EuGHYxhrUo0w4gza0NgnRlbA49ZXEkiGHzF/tATD61WXmUa2Cxgch0U3zqK2ToU
         zFrsM9dX49KqRNCDZxe6lStyJcYJ3P2aCOVd8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pE7Q5U5N9md1VWpg+pNhO4Vsqi9ghrAv417tUjZuixM3XgViWyoEGzo1H4lRfxJoVN
         1EXbzKwRnAnuV8D5C0Sjv6s7lCadQe9vQZIy7IlH4ba2/3f0xUPgVFouy6fKFvGNBLQ3
         XqymcFCdRftgotPdgjQ2+lRaMCyL0DqnYmEb0=
Received: by 10.150.2.11 with SMTP id 11mr9744312ybb.257.1282801721231;
        Wed, 25 Aug 2010 22:48:41 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id c2sm7138006ybi.21.2010.08.25.22.48.39
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 25 Aug 2010 22:48:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100826053439.GB9407@kytes>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154511>

Ramkumar Ramachandra wrote:

> No,
> format-patch doesn't support merge commits at all.
[...]

> Jonathan Nieder writes:
>
>> I see value in avoiding confusion.  Maybe one solution would be to make
>> format-patch use --no-merges by default.
>
> Good idea. I'll write a patch. Do we also want people to be able to
> turn off `--no-merges`?

I don't see a need for it.

However, if you can think of good names for --undo-no-merges and
--undo-merges options to "git log", that might be a nice independent
change for the revision option parser.
