From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 3/3] Add option to transpose parents of merge commit
Date: Wed, 28 Nov 2012 07:56:25 +0100
Message-ID: <50B5B599.3020105@viscovery.net>
References: <1354057217-65886-1-git-send-email-draenog@pld-linux.org> <1354057217-65886-4-git-send-email-draenog@pld-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>
To: Kacper Kornet <draenog@pld-linux.org>
X-From: git-owner@vger.kernel.org Wed Nov 28 07:56:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdbZp-0001Kz-3i
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 07:56:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076Ab2K1G4d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 01:56:33 -0500
Received: from so.liwest.at ([212.33.55.13]:57135 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751972Ab2K1G4d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 01:56:33 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TdbZK-0003Ok-Eg; Wed, 28 Nov 2012 07:56:26 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 142431660F;
	Wed, 28 Nov 2012 07:56:25 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <1354057217-65886-4-git-send-email-draenog@pld-linux.org>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210708>

Am 11/28/2012 0:00, schrieb Kacper Kornet:
> When the changes are pushed upstream, and in the meantime someone else
> updated upstream branch git advises to use git pull. This results in
> history:
> 
>      ---A---B---C--
>          \     /
>           D---E

The commit message will say:

  Merge branch 'master' of /that/remote

  * 'master' of /that/remote:
    E
    D

> where B is the local commit. D, E are commits pushed by someone else
> when the developer was working on B. However sometimes the following
> history is preferable:
> 
>     ---A---D---C'--
>         \     /
>          '-B-'

Better:

     ---A--D--E--C'
         \      /
          `----B

In this case, the commit message should say... what? Certainly not the
same thing. But I do not see that you changed anything in this regard.

-- Hannes
