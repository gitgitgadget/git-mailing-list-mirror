From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] codeBeamer MR - Easy ACL for Git
Date: Thu, 19 Nov 2009 02:43:46 -0800 (PST)
Message-ID: <m33a4adcbu.fsf@localhost.localdomain>
References: <4B03B153.1020302@intland.com>
	<20091118120936.GL17748@machine.or.cz> <4B03F451.4050709@intland.com>
	<alpine.DEB.2.00.0911182205590.5646@asgard.lang.hm>
	<4B0518A3.90903@intland.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: david@lang.hm, Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Intland Software <marketing@intland.com>
X-From: git-owner@vger.kernel.org Thu Nov 19 11:43:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NB4UW-0006EP-8X
	for gcvg-git-2@lo.gmane.org; Thu, 19 Nov 2009 11:43:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757510AbZKSKnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 05:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757434AbZKSKnn
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 05:43:43 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:55886 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755337AbZKSKnm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 05:43:42 -0500
Received: by bwz27 with SMTP id 27so2158868bwz.21
        for <git@vger.kernel.org>; Thu, 19 Nov 2009 02:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=2DGJdEkfiIXxJuapDZ3yKI+S9prK+K80tsiLXVrZKPQ=;
        b=i+LjxKZd8thXCbLtWuXRQtPJ/3lr6JCFMD88waQ5CIz73o/x6SZjyLIw1/Lgr8amRQ
         UnMq3DJCTqXNDmcI8UZSoG0tqex3O8lE/k4/uhUVrZ5UzZehsfsgkByJ4ey53m6C+J9/
         3ZJdfZCCBhY5YXlRsPuXQde+ZVxYKwQ5p4vK8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=VzDZKhX6uR7GxMXO/3UJvG9wfAqbtNsxmXgCmaRiLrMED8GQATv5VUx7sT8PDwDhkI
         rCigx3y56H6GW/MY2QbfqA+5uNN+LU4kpRtGZ00AEfo/VPHVtzROoMt2T5JmRucu4tTM
         3BdyNdlC9B8zFgIH2itai+lSbjCP3QIfgd0lw=
Received: by 10.204.34.20 with SMTP id j20mr91625bkd.57.1258627426829;
        Thu, 19 Nov 2009 02:43:46 -0800 (PST)
Received: from localhost.localdomain (abvd116.neoplus.adsl.tpnet.pl [83.8.201.116])
        by mx.google.com with ESMTPS id 16sm95522bwz.15.2009.11.19.02.43.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Nov 2009 02:43:46 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id nAJAhcsT032108;
	Thu, 19 Nov 2009 11:43:39 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id nAJAhYZn032104;
	Thu, 19 Nov 2009 11:43:34 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4B0518A3.90903@intland.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133224>

Intland Software <marketing@intland.com> writes:

> david@lang.hm wrote:

>>> our commercial license doesn't (currently) allow publishing the
>>> complete code. We have quite some large customers from the defense space
>>> that would not be happy if we opened everything ;)
>>
>> are you sure? did you see the recent memo about OpenSource by the
>> DOD?
>
>   Can you direct us to an URL please? Thanks.

Indirect links:
 * "New DoD memo on Open Source Software" (David A. Wheeler)
   http://www.dwheeler.com/blog/2009/10/27/#dod-oss-2009
 * "Notes about the DoD and OSS memo" (David A. Wheeler)
   http://www.dwheeler.com/blog/2009/10/28/#dod-oss-2009-notes

-- 
Jakub Narebski
Poland
ShadeHawk on #git
