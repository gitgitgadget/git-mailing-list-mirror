From: solsTiCe d'Hiver <solstice.dhiver@gmail.com>
Subject: Re: [PATCH] bash-completion: Print a useful error when called in a
 non-bash shell
Date: Thu, 29 Jul 2010 21:05:07 +0200
Message-ID: <1280430307.2228.5.camel@soho.example.org>
References: <4C50B005.1030004@pileofstuff.org>
	 <7v4ofiuuf7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Andrew Sayers <andrew-git@pileofstuff.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 29 21:05:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeYQ2-0006jb-As
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 21:05:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757039Ab0G2TFS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jul 2010 15:05:18 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40792 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755118Ab0G2TFR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jul 2010 15:05:17 -0400
Received: by wyb39 with SMTP id 39so433689wyb.19
        for <git@vger.kernel.org>; Thu, 29 Jul 2010 12:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=DguP9VkHRLJHXWSrszKmKoIEt9PyexPjfuoSt3UXy/w=;
        b=DX3WTrwNPuZfphFZNE7ythSHqeBcAZzOIDI7WTYN7zRIZXQps+1lUd+j5BGBc29JpN
         oIRvR1WHT8Wv7Ga9ePDofjpDPn/sBNYcL8a48czaV5i/WiqymBzrgdrTrahuglwDP9Js
         nTN+0P5VCGfN1kuYuciCIKgfmrvP6TdfGiZe0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=Jgm1x3Au6MLB890obmzwBNp8Gv9q9hhoUvv1+bcR8r0PE8xLGV9O4ad2ZQVe+396/D
         JbmR3yc5g+xdm7U0nZWEDKaYSSzH6Zd69wtYfqCaz4dcUkJYLTGmLxW9oSt7slF6teSF
         wC/MgUq6d/Pi9Y/qfyJzVPrebFZUr96uq9ORo=
Received: by 10.227.22.33 with SMTP id l33mr609954wbb.101.1280430316079;
        Thu, 29 Jul 2010 12:05:16 -0700 (PDT)
Received: from [192.168.0.50] (ARennes-553-1-80-200.w81-250.abo.wanadoo.fr [81.250.251.200])
        by mx.google.com with ESMTPS id e31sm1079636wbe.11.2010.07.29.12.05.08
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 29 Jul 2010 12:05:09 -0700 (PDT)
In-Reply-To: <7v4ofiuuf7.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.30.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152194>

I must re-emphasize that the bug was an archlinux bug in /etc/profile.
http://bugs.archlinux.org/task/20288

Having said that, I don't see why you're trying to do anything about
that.
If I were you, I wouldn't bother to try to print any message at all.
