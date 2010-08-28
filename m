From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] t6200-fmt-merge-msg: Exercise 'merge.log' to
 configure shortlog length
Date: Sat, 28 Aug 2010 12:09:26 -0500
Message-ID: <20100828170926.GA1945@burratino>
References: <1282918490-5190-1-git-send-email-artagnon@gmail.com>
 <1282918490-5190-2-git-send-email-artagnon@gmail.com>
 <20100828020018.GD2004@burratino>
 <20100828103536.GA12205@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 28 19:11:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpOw5-0006V0-Ud
	for gcvg-git-2@lo.gmane.org; Sat, 28 Aug 2010 19:11:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753373Ab0H1RLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Aug 2010 13:11:19 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:57112 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752992Ab0H1RLS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Aug 2010 13:11:18 -0400
Received: by qwh6 with SMTP id 6so3750216qwh.19
        for <git@vger.kernel.org>; Sat, 28 Aug 2010 10:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=HbLZw0lGNUPKrewUEG3DzpkgaOPWPkWV4dtwyWRkKwI=;
        b=bHa9cNL6HM5d3YVMzNaXqxvs6ZwsLevJKpUU/7rVkV7SyKF0UHa134bCOuQ80gW5m1
         A1I47Drgii3BZ6FygPbDTpbmkUplPdn9h+Y+LRR9/9PrySe9wn+c+GZvvP68wihC+sBw
         gLKzMQIXhz2JNpE3ak/DvkYWUGEHi2qK7Oozg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=na2HRuEo9xNnv+amBb2K8GUWmptH82NfhO7BndpGu5vmARmmBKb49rXH5wJ6iOduiT
         O8jTPjBA936K89jDcME/OQwgpgaVbgqMh+RsmFZnUP6RXHj1Y3FappNkoxwyvxKrQ47J
         RpdERTdEimx9OwFagAPHGsCCt6gjoA+nHPgOQ=
Received: by 10.224.29.3 with SMTP id o3mr1410106qac.215.1283015477557;
        Sat, 28 Aug 2010 10:11:17 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id z6sm3337835ibc.6.2010.08.28.10.11.15
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 28 Aug 2010 10:11:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100828103536.GA12205@kytes>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154648>

Ramkumar Ramachandra wrote:
> Jonathan Nieder writes:

>> 		cat >expected <<-\EOF &&
>> 		  Left #3
>> 		  ...
>> 		EOF
>> 		git -c merge.log=3 fmt-merge-msg <.git/FETCH_HEAD >msg &&
>> 
>> 		tail -n 2 msg >actual &&
>> 		test_cmp expected actual
>> 	'
>
> Ok. I don't like the `tail` thing. Why are you doing it instead of
> comparing full outputs like the tests in the rest of the file?

No good reason. :)

Thanks,
Jonathan
