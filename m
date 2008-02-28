From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 37/40] Windows: Make 'git help -a' work.
Date: Thu, 28 Feb 2008 10:52:03 +0100
Message-ID: <47C68443.5090409@gnu.org>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-38-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Thu Feb 28 10:52:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUfRd-0003zF-I1
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 10:52:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755310AbYB1JwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 04:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755286AbYB1JwM
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 04:52:12 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:55115 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755153AbYB1JwK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 04:52:10 -0500
Received: by fg-out-1718.google.com with SMTP id e21so2641386fga.17
        for <git@vger.kernel.org>; Thu, 28 Feb 2008 01:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        bh=sUGCCGjGbIbzp263ZQkLx2g45T1seMR7k4z5C1tWlv0=;
        b=YpgyBQt69mIVlwADhJnrbf73uATL11Ly/iDlWOz2+vAUs79X27K9q5uCSxC2ZzPw9V+uXyFHxI2SU4SPjc3V0SURL65izOA+WoQOTY5Z/gI9XTgzJT32td0tmpp0wMIjclS7IqhJMYjUme/TMm6xfqkfl4yI85REJNq682V9oO0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=Yk62YhdMRG4bkiq/lKh09lpHy8fviiV/ajvOJ2GL4bJ91i3vqCUKSrr+QDzspuFk2vl+/ahnIahTkb4WkBhmqdA6dnnsni70u6HC8AGQ1AuMKC4NaPU+jEVwP/4C5Pu1rxn28Ltkd9tWqK9resFKnlfd3m3F0wHMGvC40/c/meQ=
Received: by 10.86.61.13 with SMTP id j13mr7839290fga.48.1204192326944;
        Thu, 28 Feb 2008 01:52:06 -0800 (PST)
Received: from scientist-2.local ( [195.176.178.209])
        by mx.google.com with ESMTPS id e9sm16932953muf.0.2008.02.28.01.52.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Feb 2008 01:52:06 -0800 (PST)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <1204138503-6126-38-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75376>

> +#ifdef __MINGW32__
> +	char sep = ';';
> +#else
> +	char sep = ':';
> +#endif

Aha! When I replied to patch 4/40 I knew there would be one more. :-)

Paolo
