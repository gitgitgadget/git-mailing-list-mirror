From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] Add a new option 'core.askpass'.
Date: Mon, 30 Aug 2010 09:17:39 -0500
Message-ID: <20100830141739.GG2315@burratino>
References: <201008271251.19754.k.franke@science-computing.de>
 <7vaao8hsmx.fsf@alter.siamese.dyndns.org>
 <201008301344.22983.k.franke@science-computing.de>
 <20100830135658.GC2315@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Frank Li <lznuaa@gmail.com>
To: Knut Franke <k.franke@science-computing.de>
X-From: git-owner@vger.kernel.org Mon Aug 30 16:19:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq5Ct-0002ln-C3
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 16:19:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755648Ab0H3OT0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 10:19:26 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40292 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755629Ab0H3OTZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 10:19:25 -0400
Received: by fxm13 with SMTP id 13so3234156fxm.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 07:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ano0v2SDSgv9IA8ydMizTH8BHHceEo9ReTQGlLw1sy0=;
        b=qFJIAkPBLkM6Lo79iIdiuM/N6GWMfY4g+USDdDh9QU4j5Tb2f9HeUhDg0h5ENqa4nf
         I1ewB2/f1Fpt6AkH1nnw49wfnA8oqYPBY4YG325bpwfW1GzVM86iVEy9wTf7ZB7Pb6l7
         EGBiCdbmlcfaJx8eCL7e0xi7KPT71ToF+ddv0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=XBJd1SUhp9OQQGmn2wHTz/n4wgYM6YZVpyZXTYk2KKFReHd4vz5o/9j1S3XhLC7ucQ
         hK/xEWrIoCes0ECz/r42cqr4FfThgxBdbWI65hq/fW+UBxKonYHhpffvGilZO/+de+CH
         tX7jJaVcn8UaXdH/pOUOzNjy3F+YxtvcpKowk=
Received: by 10.223.116.197 with SMTP id n5mr3891444faq.53.1283177964383;
        Mon, 30 Aug 2010 07:19:24 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id c20sm3332540fak.33.2010.08.30.07.19.22
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 30 Aug 2010 07:19:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100830135658.GC2315@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154810>

Jonathan Nieder wrote:

> Perhaps "push.askpass" and "imap.askpass", maybe with the latter
> defaulting to the former or something?  This would help preserve
> the illusion that the git commands are sort of independent tools.
> 
> Haven't thought deeply about it at all, though.

Oh, it's used for fetch, too.  Forget I said anything, then.
