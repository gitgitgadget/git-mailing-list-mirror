From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/7] gitweb: Load checking
Date: Wed, 13 Jan 2010 18:18:37 +0100
Message-ID: <201001131818.38703.jnareb@gmail.com>
References: <1263374828-15342-1-git-send-email-warthog9@eaglescrag.net> <1263374828-15342-2-git-send-email-warthog9@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 13 18:18:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV6rv-0001Vo-78
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 18:18:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147Ab0AMRSv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 12:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754347Ab0AMRSv
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 12:18:51 -0500
Received: from mail-fx0-f225.google.com ([209.85.220.225]:49394 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756058Ab0AMRSu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 12:18:50 -0500
Received: by fxm25 with SMTP id 25so401497fxm.21
        for <git@vger.kernel.org>; Wed, 13 Jan 2010 09:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:user-agent:cc
         :references:in-reply-to:mime-version:content-disposition:date
         :content-type:content-transfer-encoding:message-id;
        bh=nzykdJieskpfvH2/EM61NuuH5mOql3wODQWWZYMJcpU=;
        b=QUl3+RAVFdOESwecCMEPoC2IzX+ACripnb8yb7mZVV8W/URLmUo+51EnGWNQhprsU2
         GcfGuaLILAgR/09RXOB790kSbsmEJz9/sNIXwg/4+PFrs/OEZbhwrnYMpn8VkMOIOm3E
         2FYQz+9W8clgEGR4ywB33ml95aazNTVqcR/EQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:user-agent:cc:references:in-reply-to:mime-version
         :content-disposition:date:content-type:content-transfer-encoding
         :message-id;
        b=ibGC2L8/UCnxthGa2gs58XQMJmBfbcfIMTJrxlpifS6dNnUyUeayd8/sckhKD+Lvfk
         5FLSiaqUWNINIOmeFSkHOzTEGENQ/lvAfGLSugbX8g3K1UwDfQfoMdXrpCgll1f4e4Wv
         qpG1DqJcWvSVRuFeCjknFll/zQczOZR+wsPds=
Received: by 10.223.29.24 with SMTP id o24mr1138247fac.49.1263403128935;
        Wed, 13 Jan 2010 09:18:48 -0800 (PST)
Received: from ?192.168.1.13? (abwq222.neoplus.adsl.tpnet.pl [83.8.240.222])
        by mx.google.com with ESMTPS id 15sm1003029fxm.2.2010.01.13.09.18.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 Jan 2010 09:18:45 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1263374828-15342-2-git-send-email-warthog9@eaglescrag.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136842>

On Wed, 13 Jan 2010, John 'Warthog9' Hawley wrote:
> 
> v3 - warthog9: small additional adjustment to indicate where new load
>      checking should be added for future improvements
> v2 - Jakub: switching to using

"switching to using" what?

> v1 - warthog9: Initial creation
> 
> Signed-off-by: John 'Warthog9' Hawley <warthog9@kernel.org>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---

Also, such comments should be put in the comment section, here i.e. between
"---\n" separator and the diffstat, and not in the commit message.

>  gitweb/README      |    7 ++++++-
>  gitweb/gitweb.perl |   45 +++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 47 insertions(+), 5 deletions(-)

Other that this minor nick (which I guess could be fixed by Junio when
applying), this one looks good.

-- 
Jakub Narebski
Poland
