From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] warn use of "git diff A..B"
Date: Thu, 24 Mar 2011 08:44:57 -0700 (PDT)
Message-ID: <m3tyesv7zh.fsf@localhost.localdomain>
References: <7voc51cydw.fsf@alter.siamese.dyndns.org>
	<7vei5xcxzm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 16:45:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2mig-0006s9-Lg
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 16:45:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755133Ab1CXPpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2011 11:45:00 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39676 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753743Ab1CXPo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 11:44:59 -0400
Received: by bwz15 with SMTP id 15so158890bwz.19
        for <git@vger.kernel.org>; Thu, 24 Mar 2011 08:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=k2dtcxP6Ml5zrSZ2JQf2Dzkv8oYjDa0xQvPAKrOUQPs=;
        b=lVpYdc1JRBJlXHI6Ddvn61/TL3qJ3xJwUyDS3gwAMQ0wgPjUbX5GpJDoCMhIqIFvVh
         CNx+bI9TwKesCGXvB5DCQeEmcBe4JGNHhVQouAPejvhJoQ+vP5QcoKby5HqDhVGt+lbU
         aNa+nXI0w+uQz9WS+66h5Fzq20Fs84H6Te1gA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=su7OIOH58OWBfoJ2fjhT1Be5jYDnpMbylv8+n/ZSJ04ag3/Td/Oing5yqEY3pnMou5
         JelW6hqsqWogQUex1J5VwXdbezIt7tlEVHNyFkXnpK6uya+0uXmY4k75WT9HY0wqIB0V
         1RfExnvVj/4xVBdz8jh2J6lGCuq+Mz5Db8LLg=
Received: by 10.204.81.224 with SMTP id y32mr7629586bkk.152.1300981498305;
        Thu, 24 Mar 2011 08:44:58 -0700 (PDT)
Received: from localhost.localdomain (abwk251.neoplus.adsl.tpnet.pl [83.8.234.251])
        by mx.google.com with ESMTPS id v21sm29357bkt.11.2011.03.24.08.44.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 Mar 2011 08:44:57 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p2OFiU9c024758;
	Thu, 24 Mar 2011 16:44:41 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p2OFiJ5F024754;
	Thu, 24 Mar 2011 16:44:19 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vei5xcxzm.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169926>

Junio C Hamano <gitster@pobox.com> writes:

> "git diff" (and "diff-tree") accepts a range notation "A..B" from the
> command line to specify the two endpoints to be compared; the right way to
> spell this would be "git diff A B".  This is merely a historical accident
> that comes from the fact that "git log" family of commands and "git diff"
> happens to share some code in their command line parsers.

I think it is quite useful to acept this notation to allow for
copy'n'paste from e.g. "git fetch" output:

     5e839c8..cd3065f  master     -> origin

On can simply paste "git diff 5e839c8..cd3065f".
                              ^^^^^^^^^^^^^^^^
-- 
Jakub Narebski
Poland
ShadeHawk on #git
