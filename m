From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: repo.or.cz wishes?
Date: Tue, 28 Aug 2007 01:16:00 +0200
Message-ID: <200708280116.00537.jnareb@gmail.com>
References: <20070826235944.GM1219@pasky.or.cz> <mj+md-20070827.195605.14967.albireo@ucw.cz> <alpine.LFD.0.999.0708271509230.25853@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Martin Mares <mj@ucw.cz>, Sven Verdoolaege <skimo@liacs.nl>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 28 01:34:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPnr9-0006F7-Jt
	for gcvg-git@gmane.org; Tue, 28 Aug 2007 01:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754947AbXH0XQZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 19:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752165AbXH0XQY
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 19:16:24 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:37797 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754572AbXH0XQD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 19:16:03 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1308704nfb
        for <git@vger.kernel.org>; Mon, 27 Aug 2007 16:16:02 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=j/2FDtt9wrYFMFIDCzVbsj1sORjKaQz0rGUhbKe2W+1cCSPTx7S5N7K7a4Img6q+u+B27WUflFByjXBmlrho77XKWO5kXCTdt/E9H++hVqqed3AISS2GwXVEI9HT+Imi4app7AmhW6PN+f6+ARfYpTmTwHdpUgQ/HK/ygbjdfMs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ONfhgnYX8+a5okVs7sxUrVkk+f6V1ZzKxMYypWVIGH8BC5G2I9Zk/ZcnRnWcsQUWhmEcsfEKUgmG+20UmQONidKhRFl96oahPjwXQcFodeXOdm0398b0k5OhO26v/PQ5ptVQ4mh4jwWFwxjk0xs7nhxf+nYLSUyAQVhBc9h9uBo=
Received: by 10.86.84.5 with SMTP id h5mr5295432fgb.1188256561661;
        Mon, 27 Aug 2007 16:16:01 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id 31sm5539419fkt.2007.08.27.16.15.59
        (version=SSLv3 cipher=OTHER);
        Mon, 27 Aug 2007 16:15:59 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LFD.0.999.0708271509230.25853@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56891>

Linus Torvalds wrote:

> As to your TLS example: if we were to do "git over TLS", it would make 
> perfect sense to use either "tls://" (although "gits://" might be more 
> natural, not because tls is wrong, but because people have gotten used to 
> "https://") if we were to have a "secure git" port. Or maybe we'd use the 
> same port number that we already have assigned for git, and just add some 
> "use TLS to authenticate/encrypt", and use "tls://" for that. It makes 
> perfect sense.

I like gits:// idea for "git over TLS", and I'm against "tls://". I wonder
if it would be hard to implement "git overt TLS"? We could resurrect patch
which allowed push over git protocol, onnly restricting pushing to gits
protocol.

-- 
Jakub Narebski
Poland
