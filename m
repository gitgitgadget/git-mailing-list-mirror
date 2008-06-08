From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/3] Modified test-lib.sh to output stats to /tmp/git-test-results
Date: Sun, 08 Jun 2008 07:42:59 -0700 (PDT)
Message-ID: <m3tzg4vvgw.fsf@localhost.localdomain>
References: <1212933875-29947-1-git-send-email-sverre@rabbelier.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git list" <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: "Sverre Rabbelier" <sverre@rabbelier.nl>
X-From: git-owner@vger.kernel.org Sun Jun 08 16:44:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5M7r-0007jJ-Pb
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 16:44:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753886AbYFHOnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 10:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753885AbYFHOnO
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 10:43:14 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:58528 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753808AbYFHOnN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 10:43:13 -0400
Received: by ug-out-1314.google.com with SMTP id h2so973191ugf.16
        for <git@vger.kernel.org>; Sun, 08 Jun 2008 07:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=ASKSPQISmT3WNzZpnkWF9RC+kQm9LYrM4srl9c/FJRo=;
        b=T2ESImHu1qcFUBdtS6dJ6Dl3G/6yn+a0X3z32V0sHirwmuiOYIEQk6n42eA+csSCMT
         aPhnngr03a1lTb5+l3IPgsSBRty+N4NnJBoFcnJuEnvGFyLMXWNTsK6c5X/g277UJK3F
         XRQEopUYvMZMwnPHFpnP5uIkk3yJQcmygnMOE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=FSapHZkhf03zywkXlod3m0oEYiH/VsdWCFZga807G/p5Z24Vcu8cmxUhCWbxU0tS08
         ABTOqyT18A7ZpmpEklZQw1ivuIrv3D1mHTcXqNJuecAW3mVPn64VPrrELRqh7EHuLdn9
         ZnTSMSazKvDslgxwNFPKbrYgHG4+VbEyy73X0=
Received: by 10.67.15.2 with SMTP id s2mr1031274ugi.87.1212936180631;
        Sun, 08 Jun 2008 07:43:00 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.251.161])
        by mx.google.com with ESMTPS id e34sm4228498ugd.38.2008.06.08.07.42.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 08 Jun 2008 07:42:59 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m58EgvcC008249;
	Sun, 8 Jun 2008 16:42:57 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m58Eguuj008245;
	Sun, 8 Jun 2008 16:42:56 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1212933875-29947-1-git-send-email-sverre@rabbelier.nl>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84274>

"Sverre Rabbelier" <sverre@rabbelier.nl> writes:

> Because writing to the current directory is not possible, we write to /tmp/.
> Suggestions for a better location are welcome.

> +	test_results_path="../test-results"

Errr... it looks like you forgot to update commit message.

But that aside, I quite like this series.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
