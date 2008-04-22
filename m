From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: Questions on patch lifecycle
Date: Tue, 22 Apr 2008 08:30:11 +0200
Message-ID: <480D85F3.5060707@gnu.org>
References: <1208837481.26863.374.camel@goose.sun.com> <20080422044336.GA29771@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Roman V. Shaposhnik" <rvs@sun.com>, git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Apr 22 08:31:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoC28-0002LH-Sd
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 08:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754110AbYDVGaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 02:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753796AbYDVGaa
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 02:30:30 -0400
Received: from mu-out-0910.google.com ([209.85.134.186]:2922 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754065AbYDVGa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 02:30:29 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1764038mue.1
        for <git@vger.kernel.org>; Mon, 21 Apr 2008 23:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        bh=GM/pyv8kwZ0mrELG7IC6EYnPFSYB+1Xo9c7V5V0BaRA=;
        b=xhANnzC4OUgLPwLelDKcKDeuHqaWV1/Fd4j+Oylu/TAFtcvcmVulzNL/rS7gb0vSkbVuhLoQPds+6bYqGNp6DXCSdUGUoAkJmaWZ8+Rr438LF0q50hQ/B07mYJ8Pt4Y4Dh8+ksfcpLPQ8ElIOVSmL3k8rsvt4oM9mTsmcT8teDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=vcQc9ldUGTe0t1kjBQWU1Frcorc6H0nKoB6JSk6Y3PXfq0C4B5rsN3AOSr9RT/WcOWzYS0hqmC9neFtPMYRcCD0QfOM85sWS6uxxbRIj6JYMQhEm7j/So3DVDPwjMfEvzYluykTTwYI4sYe1BjewMYDy9h1w33ZDhUrG0j/CMB4=
Received: by 10.78.141.12 with SMTP id o12mr7266613hud.110.1208845827680;
        Mon, 21 Apr 2008 23:30:27 -0700 (PDT)
Received: from scientist-2.local ( [213.55.131.23])
        by mx.google.com with ESMTPS id p30sm2221950hub.42.2008.04.21.23.30.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 21 Apr 2008 23:30:26 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <20080422044336.GA29771@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80065>


> Acceptance needs to be watched for by the author by fetching Junio's
> nightly updates, and seeing if your patch made it into next, or into
> pu, or not at all.

Also, if it is not, you can use the "What's cooking" messages to 
understand if it fell through the cracks of Junio's mailboxes or if he 
just had no time to look at it.

Paolo
