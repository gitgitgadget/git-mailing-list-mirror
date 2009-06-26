From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv6 3/8] gitweb: right-align date cell in shortlog
Date: Fri, 26 Jun 2009 11:33:46 +0200
Message-ID: <200906261133.47326.jnareb@gmail.com>
References: <1245926587-25074-1-git-send-email-giuseppe.bilotta@gmail.com> <1245926587-25074-3-git-send-email-giuseppe.bilotta@gmail.com> <1245926587-25074-4-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 11:34:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MK7on-0007TW-7N
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 11:34:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752778AbZFZJdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 05:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752206AbZFZJdu
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 05:33:50 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:40336 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359AbZFZJdt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 05:33:49 -0400
Received: by fg-out-1718.google.com with SMTP id e21so445374fga.17
        for <git@vger.kernel.org>; Fri, 26 Jun 2009 02:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=ihwrW5nsAfwvho/u8GYZa2nyUClJXE69uqCtNvTodpg=;
        b=Qsv5sQ/zfOkiT17BmJLj7FGnlTjpTqxcJuuo6cj9JPUpYIiON6z5xSc02g2IICP63C
         A0mPwHTJfDfQ8+iEI/AUJEXuLGohHeR0mtMrfCyjcNKJaunzLzhm16fXvH8NkSHak75m
         FeM/Gnj8DuQNDGqYBJMNSJHRw046LhuqMzkrU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Q9mhIp4Ru3jCY06eIGswiULS/PUHLGcLIRJEwAqV2ulFFuwjP7wZ4u/CkaugfrKXf5
         A6M7YsC5YzWCegwz1OiNAquPQWgqDVErSejh+osf+jOijismu2iHCXQjwpJ8LBxrOFCx
         sdooNYzLXyeIiA07MXyMaTY+D2l39APM1/vnI=
Received: by 10.86.3.11 with SMTP id 11mr3566845fgc.11.1246008830391;
        Fri, 26 Jun 2009 02:33:50 -0700 (PDT)
Received: from ?192.168.1.13? (abwa104.neoplus.adsl.tpnet.pl [83.8.224.104])
        by mx.google.com with ESMTPS id 12sm13988fgg.14.2009.06.26.02.33.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Jun 2009 02:33:49 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1245926587-25074-4-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122285>

On Thu, 25 June 2009, Giuseppe Bilotta wrote:

> diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
> index 68b22ff..7240ed7 100644
> --- a/gitweb/gitweb.css
> +++ b/gitweb/gitweb.css
> @@ -180,6 +180,10 @@ table {

> +table.shortlog td:first-child{
> +	text-align: right;
> +}

First, there is no space between ':first-child' pseudo-class selector
and opening '{'.  It should be "td:first-child {".

Second, I'd rather avoid more advanced CSS constructs; not all web
browsers support ':first-child' selector.  On the other hand adding
class attribute to handle this would make page slightly larger.

Last, and most important: I don't agree with this change.  In my
opinion it does not improve layout (and you didn't provide support
for this change).  Right-align justification should be sparingly,
as it is not natural in left-to-right languages.

NAK from me for this change.
-- 
Jakub Narebski
Poland
