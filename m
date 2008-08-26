From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Mon, 25 Aug 2008 23:00:16 -0400
Message-ID: <48B371C0.6020203@gmail.com>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org> <1219664940.9583.42.camel@pmac.infradead.org> <20080825124341.GD26610@one.firstfloor.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Woodhouse <dwmw2@infradead.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	users@kernel.org
To: Andi Kleen <andi@firstfloor.org>
X-From: git-owner@vger.kernel.org Tue Aug 26 05:01:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXoo9-0006MF-HK
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 05:01:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753721AbYHZDAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 23:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753837AbYHZDAU
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 23:00:20 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:2647 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753577AbYHZDAT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 23:00:19 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1036604yxm.1
        for <git@vger.kernel.org>; Mon, 25 Aug 2008 20:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=PUZx1ExX8aEo67EBpMuZWApO0OwzohO7hNOGxMZL04o=;
        b=Kte2pc0ikZLYAZq1FH9BdWWKPKpd37dRyQQZnjgvJuGZw1GbZ+4RLlQmHAZNA812cm
         tWKpfYOQ/AP2+ddE+MRZa2qfDAJis2RlGIGGJrQZYp37oozlv/8MRO5L88aHX/mB+sb+
         2ukVPWQADeMvp3ndMlv1odZcdRLc107uMC5zw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=WZsJuXgvMDsjYByzhfovNKq/Aqd5XgAuL3auNZOwBQi3hqKxlfqu154mzl3kRUjvfM
         9LVcYbUGXqKUea/72VFNz6h5+K1W9S3tgO2ik8LpkOg82/JHGlB5SWuJGWa4wU/xROPJ
         A3H6BgKiLLmZoeq+VCCh9DIdT9Kr6qx5oKLpM=
Received: by 10.150.12.3 with SMTP id 3mr8356607ybl.18.1219719618592;
        Mon, 25 Aug 2008 20:00:18 -0700 (PDT)
Received: from ?10.0.0.6? ( [66.177.19.100])
        by mx.google.com with ESMTPS id v26sm6219985ele.2.2008.08.25.20.00.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 Aug 2008 20:00:18 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <20080825124341.GD26610@one.firstfloor.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andi Kleen wrote:
>>   (C) Just don't do it. Leave the git-foo commands as they were. They
>>       weren't actually hurting anyone, and you don't actually _gain_
>>       anything by removing them. For those occasional nutters who
>>       _really_ care about the size of /usr/bin, give them the _option_
>>       of a 'make install' without installing the aliases.
> 
> (Ca) Only leave the widely used commands in $PATH and remove the ones
> which are mostly used by internal scripts only.

Please define what you mean by "widely used". I define it as "any git 
command I care use".
