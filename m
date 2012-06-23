From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: [PATCH] Restore use of 'help.format' configuration property in
 'git help'
Date: Sat, 23 Jun 2012 14:52:19 +0200
Message-ID: <4FE5BC02.4000600@lyx.org>
References: <1340369326-1840-1-git-send-email-patthoyts@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Jun 23 14:53:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiPq8-0000Pp-98
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jun 2012 14:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753471Ab2FWMwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jun 2012 08:52:25 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:35588 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439Ab2FWMwY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2012 08:52:24 -0400
Received: by eaak11 with SMTP id k11so821560eaa.19
        for <git@vger.kernel.org>; Sat, 23 Jun 2012 05:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=LiqSmIYsA9eoGRWd0l9jvl88+wQ8VrMeQ6i6E3VTDIY=;
        b=j0ctwcr4ejHg0hOImImzHFhBP0CBGz46G/VwVwhjD+knBbp/t51si4wyIMb+jd5LwK
         Su1KqDn3DKaF2ZOHKTLaZAo8GORbjN2gZ5N3FCXtNvYo4IXuzLhCMPwU5mLFFl8Yw/Kr
         l0eUSd+gO0NjEhA5QadmvNyVIjObOEldDxYG1DoqniWxRXM3ly7Yb2P6qtADWOoEp0NR
         k9VCovaydtaejK+e0AcnPQWUa275ssjnxXTyMWb+eLoqXXPahev52VbLIGPbzz/SKG2d
         P/AH5g0Uf3rAYmUx1qoBWc/6ZaUg+2Sp39pjCm8tZCe3JaTGtf803nSO8GhlO3gKHqyS
         icyg==
Received: by 10.14.27.201 with SMTP id e49mr1086555eea.230.1340455942890;
        Sat, 23 Jun 2012 05:52:22 -0700 (PDT)
Received: from [192.168.1.3] (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id e48sm6364397eea.12.2012.06.23.05.52.20
        (version=SSLv3 cipher=OTHER);
        Sat, 23 Jun 2012 05:52:21 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <1340369326-1840-1-git-send-email-patthoyts@users.sourceforge.net>
X-Gm-Message-State: ALoCoQndqjCHPhwOw45ckInVXim0Il/q7HOXGW/buUdevnr8/TnG+T8J3XmkzOOAr1u1o6jpQH3/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200499>

Op 22-6-2012 14:48, Pat Thoyts schreef:
> Commit 1cc8af0 "help: use HTML as the default help format on Windows"
> lost the ability to make use of the help.format config value by forcing
> the use of a compiled in default if no command-line argument was provided.
> This commit restores the use of the help.format value if one is
> available, overriding the compiled default.
>
>

Thanks.

Vincent
