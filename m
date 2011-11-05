From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2] Add options to specify snapshot file name, prefix
Date: Sat, 5 Nov 2011 10:18:22 +0100
Message-ID: <201111051018.22995.jnareb@gmail.com>
References: <1320302318-28315-1-git-send-email-dermoth@aei.ca> <4EB488C9.2050301@aei.ca> <201111050947.15440.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-4"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Guyot-Sionnest <dermoth@aei.ca>
X-From: git-owner@vger.kernel.org Sat Nov 05 10:18:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMcOQ-0001RK-Ix
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 10:18:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166Ab1KEJSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Nov 2011 05:18:21 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61911 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064Ab1KEJSU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 05:18:20 -0400
Received: by faao14 with SMTP id o14so3418938faa.19
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 02:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=Qh7lmHrYfmNM0FXvPMgXkOSEt2ZVQpguWRZo9QvHMag=;
        b=Ed0VW3GfY3vp6maE/GBwBOH6vpf+N9HjeCpmmNi+OP700/A9Jjvn3Y7vmBfZhFhNMU
         Tdf2sC6rWVVAZ7GI9haAJt7flLDFZGLwowco9hvFdyA7/vKddg6vugOO5xPYCYyaqk0P
         wB5zKWk3vBCoP0jWUkf0LZXPKnhQkuGm+unKQ=
Received: by 10.223.6.129 with SMTP id 1mr20002661faz.17.1320484699583;
        Sat, 05 Nov 2011 02:18:19 -0700 (PDT)
Received: from [192.168.1.13] (abwn145.neoplus.adsl.tpnet.pl. [83.8.237.145])
        by mx.google.com with ESMTPS id y17sm20683992faa.22.2011.11.05.02.18.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Nov 2011 02:18:18 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <201111050947.15440.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184840>

Jakub Narebski wrote:

> So should we expect a re-roll?

By the way, those new query parameters ('sn' and 'sp') should IMHO
be documented in Documentation/gitweb.txt i.e. gitweb(1) manpage.

Also, shouldn't you infer snapshot format from snapshot name 
("git archive" does part of that... but not the compression part)?

-- 
Jakub Narebski
Poland
