From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] git-p4: Disable t9819 git-p4-case-folding test on OS X
Date: Sun, 04 Oct 2015 11:49:07 -0700
Message-ID: <xmqqwpv2zcyk.fsf@gitster.mtv.corp.google.com>
References: <1443981977-64604-1-git-send-email-larsxschneider@gmail.com>
	<1443981977-64604-5-git-send-email-larsxschneider@gmail.com>
	<xmqqa8ry1ods.fsf@gitster.mtv.corp.google.com>
	<E363C89B-7039-49F6-B723-8609DBAF2C64@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, luke@diamand.org
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 04 20:49:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZioLX-0004eR-UW
	for gcvg-git-2@plane.gmane.org; Sun, 04 Oct 2015 20:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbbJDStK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2015 14:49:10 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34918 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbbJDStJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2015 14:49:09 -0400
Received: by pacfv12 with SMTP id fv12so157019553pac.2
        for <git@vger.kernel.org>; Sun, 04 Oct 2015 11:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=gr6ZhNF21IxIGENuuUlZIY1gEw04MbuR/blHA0y0++Q=;
        b=oq758230dgOqD6aKtI+n6lXnvQJYE5echMwkZ4y62g4Y+ToBux8XHxj7Fy2wCpu3b4
         YAjbdMUnDHnvSoD8C57IM4pk3Y1PrlaQEUwg0o2nKf96+iAeaYmsqPS1QrOdxXihCZ6+
         5E87M5aKe0JjFe95TClI3oDv5yDaJ5whZWGQzo2LNv7/qlDmz2amw4sxsEIhc6+Byxb/
         IiemdHmDFw6O26sjNnVk8riCalo4rNvSjFCRQxrVWL3bBFCEVotme20qMI4HAFovXFQo
         gzVlGCGivA4JnzWhokBbS5INXlyahTi/aIBSc7mcBsnPlOsY7Lf0Cl1LTXRRrjZFg9Vm
         widg==
X-Received: by 10.68.114.196 with SMTP id ji4mr34957781pbb.46.1443984548961;
        Sun, 04 Oct 2015 11:49:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:cd5:dd7c:35c8:15e])
        by smtp.gmail.com with ESMTPSA id a17sm23191080pbu.55.2015.10.04.11.49.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 04 Oct 2015 11:49:08 -0700 (PDT)
In-Reply-To: <E363C89B-7039-49F6-B723-8609DBAF2C64@gmail.com> (Lars
	Schneider's message of "Sun, 4 Oct 2015 11:38:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279023>

Lars Schneider <larsxschneider@gmail.com> writes:

> By the way... what formatting should I use?
>
> if foo
> then
>   bar
>
> or
>
> if foo; then
>   bar
>
> I think the latter is more used in the code base.

I've allowed the latter in fringe scripts (i.e. the ones that I do
not care too deeply) over time, but Documentation/CodingGuidelines
is very clear about it.

 - Do not write control structures on a single line with semicolon.
