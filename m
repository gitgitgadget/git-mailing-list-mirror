From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] Add a remote.<foo>.mirror configuration option
Date: Sat, 19 Apr 2008 19:53:43 +0200
Message-ID: <480A31A7.10000@gnu.org>
References: <S1755276AbYDQLcT/20080417113219Z+797@vger.kernel.org> <alpine.DEB.1.00.0804191832080.20708@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Apr 19 20:27:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnHGj-00009C-In
	for gcvg-git-2@gmane.org; Sat, 19 Apr 2008 19:54:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755333AbYDSRxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2008 13:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755435AbYDSRxr
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 13:53:47 -0400
Received: from hu-out-0506.google.com ([72.14.214.225]:16486 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755054AbYDSRxr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2008 13:53:47 -0400
Received: by hu-out-0506.google.com with SMTP id 19so376954hue.21
        for <git@vger.kernel.org>; Sat, 19 Apr 2008 10:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=+FSIOmmBQLEJsTE2Njy5d1oJHN8mwRnucscJ+DOdcl0=;
        b=AznCJWzbrgaNAetSL4j8zcfy+vMEcIU4UFhkEmfzr17MkP4whsEcHaxvb6cHAws3LPYQxMwGMS4t8oysjLnRQCIaEw4gIPevYps3nt7V5bQWlP/gs8OZOU/kCV3lB5/vqoYMLa7zIhVT7KuWuZNO6opbILIHCwGzfGwha52JPGc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        b=GeBDL01So3vJl1H2NRFlUSp57yitzwEwfyJKDxVQIWf/Qjz2cwfK7pL2Krm2Dluspq3cI2vEgiJX83YTYfjtVt05dLM5RvcLXdetMe9TlITB4or3Y2V2sDkR5fvFXgrTZey9PbHadX2tTYolk2FYvmhVo76xOc1NOrOZQFRFhUU=
Received: by 10.86.60.15 with SMTP id i15mr8441781fga.36.1208627623232;
        Sat, 19 Apr 2008 10:53:43 -0700 (PDT)
Received: from scientist-2.lan ( [213.140.22.65])
        by mx.google.com with ESMTPS id e11sm1096531fga.5.2008.04.19.10.53.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 19 Apr 2008 10:53:42 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <alpine.DEB.1.00.0804191832080.20708@eeepc-johanness>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79910>

Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 17 Apr 2008, Paolo Bonzini wrote:
> 
>> This patch adds a remote.<foo>.mirror configuration option that,
>> when set, automatically puts git-push in --mirror mode for that
>> remote.
> 
> Would it not be more logical to have remote.<nick>.pushOptions? (This 
> would be in line with the branch.<name>.mergeOptions config setting...

Maybe, but I wanted to have (later) "git push" push also to all mirror 
branches, so it made sense to "special case" --mirror.  --force can 
already be specified with +, and there are not many other options, so 
remote.<nick>.mirror was the easiest to design and implement.

Paolo
