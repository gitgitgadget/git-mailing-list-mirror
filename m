From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2013, #07; Wed, 28)
Date: Wed, 28 Aug 2013 18:14:51 -0700
Message-ID: <3820ED29-09F9-4846-ACF2-7EF67C54DCDA@gmail.com>
References: <xmqqtxi9761a.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 03:15:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEqp9-00042j-VW
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 03:15:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754194Ab3H2BOz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Aug 2013 21:14:55 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:63695 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044Ab3H2BOz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Aug 2013 21:14:55 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so6921755pbb.5
        for <git@vger.kernel.org>; Wed, 28 Aug 2013 18:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=fK/GjCXldOrOK8du9oH0ude0HTPX5zGWx+JdyJ9I448=;
        b=AnW9QLRLfcYh5LA1Bdkqx3VfGa3PYjm6xj/6C/IbnJA/xzRJVzoS1muB4f+DwdOnEj
         3PsJzC9vaZPF51KP1M8br3FtfThMISrZ3yViGEFPUBIaVKJqn+zhutpSR5r//ztUSls/
         p8bLYpd+SyV1qNdxGqULZtVXt2FxFckhqcJLuaNbCkHKrGbpU1IeNnBh4eCY0JQmgUrp
         iJs8x1GUYdKOgvfbH0tnJXK4LLOoGNNWD/sQetDNQCPo2o+RQ5JPvq3MBmv5vOYwU3FW
         iM1qCNA0r45ijSmkDdX1V7l5OxNlu4FUtzUSIjroSA13sXde4piB5qKE5E+qyWWgcdSR
         19cA==
X-Received: by 10.68.14.234 with SMTP id s10mr659960pbc.139.1377738894705;
        Wed, 28 Aug 2013 18:14:54 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id ta10sm36944282pab.5.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 28 Aug 2013 18:14:53 -0700 (PDT)
In-Reply-To: <xmqqtxi9761a.fsf@gitster.dls.corp.google.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233232>

On Aug 28, 2013, at 16:24, Junio C Hamano wrote:

> * km/svn-1.8-serf-only (2013-07-18) 3 commits
>  (merged to 'next' on 2013-08-28 at 1119134)
> + Git.pm: revert _temp_cache use of temp_is_locked
> + git-svn: allow git-svn fetching to work using serf
> + Git.pm: add new temp_is_locked function
>
> Originally merged to 'next' on 2013-07-19
>
> Subversion 1.8.0 that was recently released breaks older subversion
> clients coming over http/https in various ways.
>
> Will merge to 'master'.

This series could be cleaned up by squashing "Git.pm: revert  
_temp_cache use of temp_is_locked" into "Git.pm: add new  
temp_is_locked function" if desired since that "Git.pm: add new  
temp_is_locked function" commit contains the one-line change that  
"Git.pm: revert _temp_cache use of temp_is_locked" reverts.
