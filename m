From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: Reverting to old commit
Date: Tue, 27 May 2008 22:17:08 +0200
Message-ID: <483C6C44.1010304@gnu.org>
References: <8345bd80805271050q7412917bt292a276fbbe6aed3@mail.gmail.com> <483C68E5.1040408@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Marcus <prima@wordit.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Tue May 27 22:25:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K15jV-0003s1-QG
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 22:25:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757149AbYE0UY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 16:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757553AbYE0UY2
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 16:24:28 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:61784 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756309AbYE0UY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 16:24:28 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1603462fgg.17
        for <git@vger.kernel.org>; Tue, 27 May 2008 13:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        bh=1Z/iN9RE/qa6p0LfgIRo5FTVurEnHDRPwCLf1AP2J5o=;
        b=SE3FlLcFcOErCNdiuQ29ysU3CP8MbOF7vAPkp4F7FFIY0m3ba+kZXfKUx6e7iOrPzx1rzwahInl5SGSfkXdLwwnoiFdghX7U4Z2T3tW+yjk5ArSZKnK+mtKxzWjlSttS0wCZN/ctIpUcg7Na0ZWz5tq9lOSBUPVtP2Itqmb4eK8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=htAzf38pZv2ZCP1p5EFkPujhyjw9bSwWtAXk8VVPQHQNSoxoyRSJvURvSg6lgmj8LPEt65a0RCp3ByXH6Sojf9aYhYXdxbj+rBMxdDBZcF8wu71PpIIUm8OMDomxbsUtP3fEBh8B08MM4nlLVpQVUHj/TMeXl+bSh1yOfYy16Kw=
Received: by 10.86.70.8 with SMTP id s8mr5570633fga.79.1211919427588;
        Tue, 27 May 2008 13:17:07 -0700 (PDT)
Received: from scientist-2.lan ( [213.140.22.65])
        by mx.google.com with ESMTPS id l19sm15915965fgb.9.2008.05.27.13.17.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 May 2008 13:17:06 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Macintosh/20080421)
In-Reply-To: <483C68E5.1040408@dirk.my1.cc>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83041>


> Then gitk's "reset ... branch to here" could help you. Right-click
> the desired commit and reset the branch.

DON'T do this though if you have published the branch somewhere.

Do "git-revert -n" on all the commits after the buggy one in that case, 
starting from the last, then "git commit".

Paolo
