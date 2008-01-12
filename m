From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] Teach remote machinery about remotes.default config variable
Date: Sat, 12 Jan 2008 08:24:56 -0500
Message-ID: <4788BFA8.2030508@gmail.com>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>	<1200022189-2400-2-git-send-email-mlevedahl@gmail.com>	<7v1w8o4ws0.fsf@gitster.siamese.dyndns.org>	<30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com>	<7v63xzzszp.fsf@gitster.siamese.dyndns.org>	<478855B5.9070600@gmail.com>	<7vbq7ry405.fsf@gitster.siamese.dyndns.org>	<47885B2C.8020809@gmail.com> <7v7iify2wm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 14:25:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDgMx-0007JI-HF
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 14:25:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754755AbYALNZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 08:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753351AbYALNZF
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 08:25:05 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:19960 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391AbYALNZC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 08:25:02 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2407582wah.23
        for <git@vger.kernel.org>; Sat, 12 Jan 2008 05:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=xsNQN0EXoHaeVaWLvIVLigNdeJprWmTHIhOjWdqCtCE=;
        b=Ed80sw6zVd61QmeYdA3sQoiOlVStfziboqh1sOWGLAx093mgGt4j26Ef/Wfn6Nd0yrNY6LgkLHUs0RwCn8rPTIIttES3K6IQbsY44cQnSNvvWx1y7WUPIEwTbzLDRKi1gaKdFwXjyNkZhhpwFb5xYiZFeQV0/gyar02kBZy8Xnc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=cgDsAhcQXSjTMkKsP9mzEp2S67+Ikyg/XrGe3sh1CdWsJDQjvv+dcMhVeKNFVgFlNiUJm+Yj+4QeyrcDnQe83ezMXi8SEdf0O2IxTKoXYcbDV43Jrn1+kMd2zhvzzMwlVjH/Qsh0ghtA7yTS5R1S4HN/ChnghulupHiJ8Bdk3WI=
Received: by 10.114.14.1 with SMTP id 1mr548123wan.9.1200144299934;
        Sat, 12 Jan 2008 05:24:59 -0800 (PST)
Received: from ?192.168.1.117? ( [71.163.17.196])
        by mx.google.com with ESMTPS id i16sm6674252wxd.30.2008.01.12.05.24.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 12 Jan 2008 05:24:57 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <7v7iify2wm.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70315>

Junio C Hamano wrote:
> Sorry, I may be missing something.
>
> Even if you have a submodule, you can go there and that will be
> a valid freestanding repository.  You can always be explicit,
> bypassing any behaviour that defaults to 'origin' to avoid
> ambiguity.
>   
"git-submodule update" *requires* that origin is defined in all 
sub-modules. There is no way to avoid this behavior.

Mark
