From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: pre-commit to reject EOL changes
Date: Sat, 04 Jun 2011 00:52:06 -0700 (PDT)
Message-ID: <m37h92rq4p.fsf@localhost.localdomain>
References: <isbu54$dn3$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Neal Kreitzinger" <neal@rsss.com>
X-From: git-owner@vger.kernel.org Sat Jun 04 09:52:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSlf9-0001XP-Ay
	for gcvg-git-2@lo.gmane.org; Sat, 04 Jun 2011 09:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753035Ab1FDHwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Jun 2011 03:52:10 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41229 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565Ab1FDHwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jun 2011 03:52:09 -0400
Received: by fxm17 with SMTP id 17so1658048fxm.19
        for <git@vger.kernel.org>; Sat, 04 Jun 2011 00:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=3Xh3AVK76GRzTOs8XRXk0xCvcsaAyaJh/57EqWyaIC4=;
        b=Q7dJ65+4BkFrqAKFMBqQynlnjNzQXk2mNB2n7wACwc95JyAQDv0ZxAaSsR1jJdIxV3
         ZKqoocazWwPYUqSqQXv1vWPSy6WK3aYHxt4FJIS+kNVlIYKBsQKB/BJMHVN6BngJYRwf
         J1Xlikjfk9YVYUW4mNlwxnRmAQ6E5uUtdBzt8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=g4s+kYwdmzhyGXChIlVFTAZBFFzZbTFKPAl721giPL/MK/YiR9czK5DPvu93q+WtvS
         qulvCJpThYNRwZvLlFwteFSVS9p0kqVmm2D8jNZVTa/r4DCbMNV/85NS2BIGdh/vgRwn
         lluXydl+53QuDS8+PCUQ6YrQ8Gw6p7Syal0eQ=
Received: by 10.223.94.129 with SMTP id z1mr1808243fam.144.1307173928080;
        Sat, 04 Jun 2011 00:52:08 -0700 (PDT)
Received: from localhost.localdomain (abwc24.neoplus.adsl.tpnet.pl [83.8.226.24])
        by mx.google.com with ESMTPS id q14sm705574faa.3.2011.06.04.00.52.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 04 Jun 2011 00:52:06 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p547pb3L032497;
	Sat, 4 Jun 2011 09:51:49 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p547pKtN032485;
	Sat, 4 Jun 2011 09:51:20 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <isbu54$dn3$1@dough.gmane.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175056>

"Neal Kreitzinger" <neal@rsss.com> writes:

> I see that the pre-commit.sample reject introduction of lines with trailing 
> whitespaces.  Is there a way to have it reject changes in EOL format (CRLF 
> vs LF)?

Well, from description of relevant config variable, namely `core.whitespace`
it looks like by default `trailing-space` with `cr-at-eol` not enabled
(default) treats adding CR in LF -> CR LF change as whitespace error.

I don't think there is anything *canned* (out of the box) for the change
in reverse direction.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
