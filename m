From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Add git-config --remove-section, document --rename-section
Date: Thu, 1 Mar 2007 22:51:32 +0100
Message-ID: <81b0412b0703011351ldd903a8od2e4f76aded31519@mail.gmail.com>
References: <es66vt$jej$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Paolo Bonzini" <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Thu Mar 01 22:51:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMtBY-0003VW-8M
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 22:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030351AbXCAVvf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 16:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030352AbXCAVvf
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 16:51:35 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:24974 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030351AbXCAVve (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 16:51:34 -0500
Received: by ug-out-1314.google.com with SMTP id 44so489682uga
        for <git@vger.kernel.org>; Thu, 01 Mar 2007 13:51:33 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qNlWavzJ2HAwWdr5HxHhxgMbYDFioXAWfolu61APxAo7y2m1JtduXLCdqnrfdMl+tAZ+RnZmlkMUaif5y3Btgny1DckCk4KhhdmtQ1uSK3MhSmhTEWBKd3SD0MW6N3te5pACvWSIxsM/NmZsbAd25//4as1UPYHUae5UBxGQlDc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YBHfwZjyr+yubjBkuEQbcuZ+CAyC5ahJg+YFH+I0IoBRCQDiPdZl2h+cQM35murhAM8cZoJq/oJSFP65uky4dSwTGzBK+CWk2QlB99zGTvtCe2P+OuUGhBz+8NfQvgeXtRSn20X/EvSUS7r8ga8VVJiCGBg6FeNXJmranzdOkbk=
Received: by 10.78.149.15 with SMTP id w15mr204716hud.1172785892978;
        Thu, 01 Mar 2007 13:51:32 -0800 (PST)
Received: by 10.78.139.9 with HTTP; Thu, 1 Mar 2007 13:51:32 -0800 (PST)
In-Reply-To: <es66vt$jej$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41133>

On 3/1/07, Paolo Bonzini <bonzini@gnu.org> wrote:
> As per the subject.  The existing --rename-section option is
> undocumented, while --remove-section is added by this patch based on the
> code I had written for the "git branch" patch.

You desperately need tests for this code.
