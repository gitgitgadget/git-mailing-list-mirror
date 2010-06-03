From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2010, #01; Wed, 2)
Date: Thu, 3 Jun 2010 21:53:47 +0200
Message-ID: <7E7FBDDC-2504-4145-8822-E28ED410B799@gmail.com>
References: <7v4ohlatwn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 03 21:53:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKGUH-0004RK-5b
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 21:53:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756429Ab0FCTxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 15:53:52 -0400
Received: from mail-ew0-f223.google.com ([209.85.219.223]:52930 "EHLO
	mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755793Ab0FCTxv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jun 2010 15:53:51 -0400
Received: by ewy23 with SMTP id 23so127983ewy.1
        for <git@vger.kernel.org>; Thu, 03 Jun 2010 12:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=VU7MQCWObURiqua8Cqug6wNkM2GeYy5iz0oikuStjBw=;
        b=G4NWoKTeir9FKs0HI1narTvxd0nsgKLoIUG0GWO2oWS5/T0PSyNwujv18CkA5CkUtt
         axb9nT6O9YfLw2oZ8t7NZbV2YCXsAuizOqha4e/p9D+c142AWhPoQq2ygL3poU7EzhkH
         prwDb5R5aL7c3SlkjtBGpV6IhZ/6HFX3M4vPI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=BGb3Q2j3aqKeXkNGJ3XqUKmmmNpoxEVF2eN+KdW5UanJD0dDfrMiadK0Cj8ULrHbbw
         49D/91ANsOj98muC3a5J7XWgR+x+FWAixnAnvCGIPE01uLyluA3TwipSFTHkAEeD+xoh
         WD5Vbk2Ngc9o1ErmnX/jZawN2KSeUo8nIdV/0=
Received: by 10.213.15.146 with SMTP id k18mr6914121eba.80.1275594828840;
        Thu, 03 Jun 2010 12:53:48 -0700 (PDT)
Received: from vredefort.d.eyvind.bernhardsens.net (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id 13sm240521ewy.13.2010.06.03.12.53.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 03 Jun 2010 12:53:48 -0700 (PDT)
In-Reply-To: <7v4ohlatwn.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148357>

Hi,

On 3. juni 2010, at 01.36, Junio C Hamano wrote:

> * eb/core-eol (2010-05-19) 4 commits
> - Add "core.eol" config variable
> - Rename the "crlf" attribute "text"
> - Add per-repository eol normalization
> - Add tests for per-repository eol normalization
> (this branch uses fg/autocrlf.)
> 
> Will merge to 'next'.

I have a fixup for the "core.eol" commit that modifies "core.autocrlf"'s behaviour and fixes the documentation, as discussed on the list.  Unfortunately it's on a machine that's not accessible to me right now, but I'll send it tomorrow.
-- 
Eyvind
