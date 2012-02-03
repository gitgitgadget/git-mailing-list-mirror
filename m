From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] Git 1.7.9
Date: Fri, 3 Feb 2012 21:55:25 +0100
Message-ID: <201202032155.26532.jnareb@gmail.com>
References: <7vipjwzvc2.fsf@alter.siamese.dyndns.org> <201202031352.10279.jnareb@gmail.com> <7vehubpuv7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 21:56:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtQAs-0001lR-75
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 21:56:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757727Ab2BCUze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 15:55:34 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:65097 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757605Ab2BCUzb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 15:55:31 -0500
Received: by eaah12 with SMTP id h12so1581045eaa.19
        for <git@vger.kernel.org>; Fri, 03 Feb 2012 12:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=hWsZtXxFI47rygj9tcwSPkj74zigdDUTVMLXttbRAKg=;
        b=DvB99GF8wqOb3QVsPnIv5CSlpAVR1qNbBEdUoQzNnlm6cgW9RL/nDyhn2tRaRlJbQK
         CYphXS7svANFJuSH4k3bp02Yn2RmW/RGtIM4cIeSG62t11eQEHM881lvPjtRFq11wJqi
         SH4WoSPyRLM6yGj2VeW1dWaHtNOluX4xxmS5A=
Received: by 10.213.29.11 with SMTP id o11mr2766134ebc.57.1328302529979;
        Fri, 03 Feb 2012 12:55:29 -0800 (PST)
Received: from [192.168.1.13] (abwn75.neoplus.adsl.tpnet.pl. [83.8.237.75])
        by mx.google.com with ESMTPS id y12sm26028160eeb.11.2012.02.03.12.55.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Feb 2012 12:55:29 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vehubpuv7.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189801>

On Fri, 3 Feb 2012, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:

>>>>  RPM build errors:
>>>>     Installed (but unpackaged) file(s) found:
>>>>    /usr/share/locale/is/LC_MESSAGES/git.mo
>>>>
>>> 
>>> I think it should be simply ignored at least for now.  I stopped touching
>>> the rpm spec since August last year (the only reason I was running rpmbuild
>>> was to install them on k.org), so I didn't notice.
>>
>> So for the time being something like that would be an acceptable fix?
> 
> Except that the patch probably wants to go to git.spec.in, removing that
> installation target would be a good local workaround for now.

O.K., will do.

Anyway this change makes rpmbuild process complete.
 
> I said "local workaround", meaning that I am not all that interested in
> applying such a patch myself.  Somebody who wants to do RPM needs to
> decide what subpackage(s) it should go before we start accepting more po/
> files, and at that time the workaround needs to be reverted.
> 
> And hopefully that should happen soonish ;-)

The git-i18n-Icelandic proposal for /usr/share/locale/is/LC_MESSAGES/git.mo
follow the KDE pattern (e.g. kde-i18n-Polish).  This might be a place for
translated manpages and other documentation, if there is any.

On the other hand all translations for gitk are in gitk package
(as /usr/share/gitk/lib/msgs/*.msg, not /usr/share/locale/*/LC_MESSAGES/git.mo)
Same for git-gui.

-- 
Jakub Narebski
Poland
