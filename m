From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Dates in Commits and other issues of style (Re: [RFC 2/5] Pretty Print: show tz when using DATE_LOCAL)
Date: Mon, 25 Apr 2011 03:45:03 -0700 (PDT)
Message-ID: <m3bozuwqyz.fsf@localhost.localdomain>
References: <0f30e048-7dd2-4aff-8c1f-00bf0dfa3d34-mfwitten@gmail.com>
	<acbcf231-e0a6-440e-be42-5f25da3e318d-mfwitten@gmail.com>
	<7vtydrutbq.fsf@alter.siamese.dyndns.org>
	<811b01a9-f10e-4444-9e5e-581adaf059c2-mfwitten@gmail.com>
	<87sjt76rzo.fsf@catnip.gol.com>
	<7vhb9nkmo1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miles Bader <miles@gnu.org>, Michael Witten <mfwitten@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 12:45:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEJIa-0001lc-Rw
	for gcvg-git-2@lo.gmane.org; Mon, 25 Apr 2011 12:45:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758375Ab1DYKpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2011 06:45:07 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33977 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758356Ab1DYKpF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2011 06:45:05 -0400
Received: by fxm17 with SMTP id 17so1231182fxm.19
        for <git@vger.kernel.org>; Mon, 25 Apr 2011 03:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=DdWdK/giLHfSJLrea6xpcYFpddzzekVQknqNw+poew8=;
        b=IKWj/L/EjbB5trMgoyOW/Fq2qWoHyx39ubaffGFSwE0sxlKev7wfWXSBwGZQNOTm0l
         smgRtsCz8649OUxxyhQJsEL4chmVxY78/QIMbs/ZbleO3RZW8xBaXy5buaWIKHuylMLm
         DOqrysuU2NNiJqm1t1i272+Z8ELpea/AR/xhI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=SEiQzAOQf7nL8Zrs7p9IKIVXXMfCs7tKrFUJd5jkK4s01eBCHagW8QMjZxIhWjWVzv
         1KiYFzu3W/84Jyd2Eohwk30uC7KZiC4WX8lsB5EOemO701EKcaFAJKQ5Qn0Q6JEFf6Jr
         lVVnvseKdtyzAtPOK31htZ73uDU4A8KUKh42c=
Received: by 10.223.44.86 with SMTP id z22mr4325284fae.3.1303728304000;
        Mon, 25 Apr 2011 03:45:04 -0700 (PDT)
Received: from localhost.localdomain (abwn49.neoplus.adsl.tpnet.pl [83.8.237.49])
        by mx.google.com with ESMTPS id j18sm1651407faa.42.2011.04.25.03.45.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 25 Apr 2011 03:45:03 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p3PAiPmA021240;
	Mon, 25 Apr 2011 12:44:35 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p3PAi40c021233;
	Mon, 25 Apr 2011 12:44:04 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vhb9nkmo1.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172025>

Junio C Hamano <gitster@pobox.com> writes:

> Enforcing consistency is one of the important tasks the maintainers do in
> their projects.  Besides ensuring that the intent of the change each patch
> brings to the codebase is good, that the log entry describes the change in
> a useful way for future readers, and that the patch correctly implements
> the described change, we also need to make sure that the resulting code
> matches the style of the surrounding code, and the style, structure and
> tone the log messages are delivered in a consistent voice.  Otherwise it
> would quickly get very tiring when you have to dig into the history of the
> codebase.  The code and the history are read a lot more often than are
> written. [...]

This information should be put e.g. in SubmittingPatches, or
CodingGuidelines, or MaintNotes, isn't it?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
