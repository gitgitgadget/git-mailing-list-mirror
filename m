From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Performance issue exposed by git-filter-branch
Date: Thu, 16 Dec 2010 21:22:32 -0600
Message-ID: <20101217032232.GC7003@burratino>
References: <41C1B4AC-8427-4D62-BEB6-689A4BE4EE5B@irridia.com>
 <20101217014539.GA6775@burratino>
 <1FBB24BF-6517-4906-99D5-A5DDBEA14D6D@irridia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Barr <david.barr@cordelta.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Jakub Narebski <jnareb@gmail.com>
To: Ken Brownfield <krb@irridia.com>
X-From: git-owner@vger.kernel.org Fri Dec 17 04:22:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTQuG-0004xz-FH
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 04:22:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573Ab0LQDWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 22:22:51 -0500
Received: from mail-gx0-f180.google.com ([209.85.161.180]:33720 "EHLO
	mail-gx0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690Ab0LQDWu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Dec 2010 22:22:50 -0500
Received: by gxk19 with SMTP id 19so141439gxk.11
        for <git@vger.kernel.org>; Thu, 16 Dec 2010 19:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=X3w+CuorX51rs0qDuWSg1Ot6OBEedEk7xpaHoQKuYQU=;
        b=DigMbGqbkf6FWo3Wng7HrhIzs2DlLJJcPTRENAewzpw2LlR5ITi4kp8jsNDhO+ym4Y
         i09e5/yYh8phSW0U0i2HzjAdWGU3mjDRayqajTaCKzB4C0oq33gPcSbBbdg8dP4NmWsC
         mcqycphEW6+jUZXWL6YQGjPcNgklPR5TkirdE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=AbXL+Tn2TrYCa7iTxxsPqfBZUiuyl9YOTb97rYq5/hT/XztobediCdoEh6qJGpYX6b
         A5U6eD7cfo2KnbSKpAQN7/hJulBJvtryJFLjgSVrOc8VtjBJyg/VchGEs3Okd/xUYAtP
         WKhdPLjHZ50Hi0BDn3RI2fAdv4Du93rtGpVTU=
Received: by 10.100.143.4 with SMTP id q4mr310903and.21.1292556169622;
        Thu, 16 Dec 2010 19:22:49 -0800 (PST)
Received: from burratino (adsl-69-209-48-248.dsl.chcgil.sbcglobal.net [69.209.48.248])
        by mx.google.com with ESMTPS id b26sm3663451anb.13.2010.12.16.19.22.47
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 16 Dec 2010 19:22:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1FBB24BF-6517-4906-99D5-A5DDBEA14D6D@irridia.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163856>

Ken Brownfield wrote:

> The thread titled "git and larger trees, not so fast?".

Here it is[1].  Sorry to say, the improvements discussed there
were made right away and indeed had a dramatic effect.

Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/55458/focus=55643
