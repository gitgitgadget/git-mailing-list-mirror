From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: tracking a file from another project in my own project
Date: Tue, 22 Jan 2008 19:34:42 +0100
Message-ID: <200801221934.43767.jnareb@gmail.com>
References: <20080122093546.72db8da0@synchrotron-soleil.Fr> <m3fxwplw1i.fsf@roke.D-201> <877ii17opo.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: picca <picca@synchrotron-soleil.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 19:35:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHNy2-0003n0-RS
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 19:35:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752016AbYAVSex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 13:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751998AbYAVSex
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 13:34:53 -0500
Received: from mu-out-0910.google.com ([209.85.134.190]:54461 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934AbYAVSew (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 13:34:52 -0500
Received: by mu-out-0910.google.com with SMTP id w8so2111026mue.1
        for <git@vger.kernel.org>; Tue, 22 Jan 2008 10:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=MLY14NUQllOe6wYB8NvaB7NBzeqEeWnD2jcaGG6GhIQ=;
        b=ap/WpySZfBEMig5d0eDGnE9kD/Kh8BEt/lkbUcEC/KnLpEOmxHKLQQRNBex8R3UEN8BXhW66c8HREFooa4zwzh/CCcsdAsZLBvuup6ioQveUWTTbaNUZiI4P08G2d8+MTODL9tpubjH1JWXnRHEdxidwsf6lA2/qAFOCmWmTSP4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=bZ/UhELjjliS4ugAaTW6ef5A/lTL/VFctYOXMLZ7SdL8kyZNr7OcKCQ2PCQdNVYXXwLDsLkZDIMzXrOlwIbOAHC4k/+Bcsf/CgKde9MIroUa3ReAEgBIL9iqbHufFDCnMLu1jrfcllbgWJgDVIXuhJEQDtrqb1oTFyb2X3hdxEg=
Received: by 10.82.167.5 with SMTP id p5mr15380864bue.2.1201026890320;
        Tue, 22 Jan 2008 10:34:50 -0800 (PST)
Received: from ?192.168.1.10? ( [83.8.211.135])
        by mx.google.com with ESMTPS id u14sm1707467gvf.1.2008.01.22.10.34.47
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Jan 2008 10:34:48 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <877ii17opo.fsf@osv.gnss.ru>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71465>

Sergei Organov wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> picca <picca@synchrotron-soleil.Fr> writes:
>>> Junio C Hamano <gitster@pobox.com> wrote:
> 
> [...]
> 
>>>> Or "merge -s subtree".
>>> 
>>> I read the git help merge -s explanation but I do not understand how
>>> it can help in my case.
>>
>> Using subtree merge strategy you can join histories of your project
>> and git.git, embedding git.git as a subdirectory like gitk and
>> git-gui are now in git.git.  It is an alternative to using
>> submodules. 
> 
> Is subtree merge strategy documented?
> 
> $ grep subtree Documentation/merge-strategies.txt
> $

Documentation/howto/using-merge-subtree.txt

But I agree that it should be also described, or at least mentioned
in Documentation/merge-strategies.txt
-- 
Jakub Narebski
Poland
