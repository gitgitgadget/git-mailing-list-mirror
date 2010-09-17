From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 7/7] gitweb: group remote heads
Date: Fri, 17 Sep 2010 19:25:43 +0200
Message-ID: <201009171925.43590.jnareb@gmail.com>
References: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com> <1284629465-14798-8-git-send-email-giuseppe.bilotta@gmail.com> <201009171854.03476.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 17 19:25:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oweh4-0004dQ-KU
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 19:25:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753111Ab0IQRZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Sep 2010 13:25:45 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63154 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472Ab0IQRZo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Sep 2010 13:25:44 -0400
Received: by bwz11 with SMTP id 11so2838410bwz.19
        for <git@vger.kernel.org>; Fri, 17 Sep 2010 10:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=j34y9UMeJTBt2Un455oRiTralLKB18+ztwPTPRw2UkA=;
        b=i+ZY5Wq6LlZRSorw7bw5FbjEoXWKtNHiLkPRg4ptEh0Pj5GAOGtYfwdE0EDcjjW7v0
         3y6f0I/DhKFQUTlILxr9xaJHFUkFGHOtVlLvYc3353xPdLJPbQuHLXVthJHrVoTjhQ4u
         EFbKdelGqA1fCD+xFz6+lcqwNyS2FkyT+RoTE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=AWeRVL4lds6RdKlHFIB7/6zwJXZwmZZ7/PVVhcz88FWyhwv1bpZdxWDs9NskeweI7x
         hXZM7aLQ3e3t46koaumwGSJrU6vkXmpVizclb3YT0oAo5EuofzycrbvbQFnP1XKEjgN6
         ojj9ZdrgiNw0BqbwfBXK327ceikMkG3kzL+3g=
Received: by 10.204.71.84 with SMTP id g20mr4171010bkj.60.1284744343589;
        Fri, 17 Sep 2010 10:25:43 -0700 (PDT)
Received: from [192.168.1.13] (abvo68.neoplus.adsl.tpnet.pl [83.8.212.68])
        by mx.google.com with ESMTPS id g12sm3832611bkb.2.2010.09.17.10.25.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 17 Sep 2010 10:25:42 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <201009171854.03476.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156404>

On Fri, 17 Sep 2010, Jakub Narebski wrote:
> On Thu, 16 Sep 2010, Giuseppe Bilotta wrote:

> > +		my @remoteheads = grep { $_->{'name'} =~ s!^\Q$remote\E/!! } @allheads;
> 
> Should we display remote even if it doesn't have any remote heads
> associated with it?

By the way, it would be place where we could limit number of 
remote-tracking branches displayed in each remote block.

-- 
Jakub Narebski
Poland
