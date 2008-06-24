From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH v6] gitweb: add test suite with Test::WWW::Mechanize::CGI
Date: Tue, 24 Jun 2008 10:37:41 +0200
Message-ID: <4860B255.7010909@gmail.com>
References: <1214181904-30265-1-git-send-email-LeWiemann@gmail.com> <1214183688-8544-1-git-send-email-LeWiemann@gmail.com> <200806231531.13082.jnareb@gmail.com> <485FE3F7.4040102@gmail.com> <7vtzfjea64.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 10:38:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB42y-0002n3-LR
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 10:38:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752806AbYFXIhp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 04:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752217AbYFXIho
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 04:37:44 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:44718 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752063AbYFXIhn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 04:37:43 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1134851fgg.17
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 01:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=svIXSHCx2MtGFh4d4Tym1uCuA4Jy9b1Ui4py3KAnPe0=;
        b=ano9eTV6MFzLc3Yzup1RSyoDVGzOBKYt9AvPE/b6a9PUv8vw6kAEdoMVEatzcqTZuO
         iC8fLI/KBL3W4Q/2E+Kdj8Rh/zj1Rf/r4aL+xuXKhvEnbiJUhcVl+wvZQZsGvoUuFkx1
         iaBfCaRI5qbdY7qkhOPjZ+pvU//glVz9RMnec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=HJ5TKoeG/qw7Pjkt7cmnr6zwp5Yhn/xlAmE65Dah9H0/BQ9crHE95u44I4RM8BPxZr
         1nhTXTcsQh3P1dJHrrUfoOe4MKsVvcJjYXPUrCZdAGKeh96T5OxSJL5tUo+jeLgS3X01
         Bo5vw8uKibVs7Usv7aAl9AeNNcLHcv/GQJxuE=
Received: by 10.86.1.11 with SMTP id 11mr8699749fga.27.1214296662082;
        Tue, 24 Jun 2008 01:37:42 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.198.167])
        by mx.google.com with ESMTPS id e11sm10763806fga.4.2008.06.24.01.37.40
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 24 Jun 2008 01:37:41 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <7vtzfjea64.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86017>

Junio C Hamano wrote:
> We are passing down SHELL_PATH from primary Makefile to t/
> and you should be able to do the same for Perl path...

I see; that'll work, thanks!  Will send v8 soon.

> About the Test::WWW:Mechanize::CGI thing, how widely available is it?

Not very, you basically have to install it from CPAN.  If it's not 
installed, the only message you get from the test is:

ok 1: skipping gitweb tests, Test::WWW::Mechanize::CGI not found

Should optional test dependencies like Test::WWW::Mechnanize::CGI be 
documented in INSTALL?

Best,

     Lea
