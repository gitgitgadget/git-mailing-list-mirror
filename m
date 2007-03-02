From: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: Re: [PATCH] defaults for where to merge from (take 3, inline)
Date: Fri, 02 Mar 2007 09:10:44 +0100
Message-ID: <45E7DC04.5010701@lu.unisi.ch>
References: <es450f$d58$1@sea.gmane.org> <Pine.LNX.4.63.0703010221000.22628@wbgn013.biozentrum.uni-wuerzburg.de> <81b0412b0702282355i176ad7e5t7b9e417b27e524fb@mail.gmail.com> <45E68897.8000607@lu.unisi.ch> <81b0412b0703010010o24513f60x937b5af52362e0c8@mail.gmail.com> <45E68EDE.2090405@lu.unisi.ch> <81b0412b0703010033w2e1079a3l6ac6e38c59bdefd5@mail.gmail.com> <45E69297.8070001@lu.unisi.ch> <81b0412b0703010059w52a33b54n4d3c25ada6b96369@mail.gmail.com> <45E69EEE.8070905@lu.unisi.ch> <81b0412b0703010212w5367c8cek51f22e9098f8e22f@mail.gmail.com> <7vvehls1h9.fsf@assigned-by-dhcp.cox.net> <45E70041.1030705@lu.unisi.ch> <Pine.LNX.4.63.0703012240210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 02 09:10:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN2qt-0004RT-JM
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 09:10:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932770AbXCBIKw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 03:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932776AbXCBIKw
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 03:10:52 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:58946 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932770AbXCBIKv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 03:10:51 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1199689nfa
        for <git@vger.kernel.org>; Fri, 02 Mar 2007 00:10:49 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=FlOYVcEax8oMAGmWlTVTF1pUCq5Sh9EfVz3ZtQFo7SxEhAKjjC4d9lmdPvgIV16DC86xx2b5XCXDz8JxVq4C7UkGaPAcReRiy3i69F9c15fEAWjK0fAYjv+bEqRHKP/wVvcEX/ecJRvykEAA/NyGDvplZLSio6dufdTTm1a5AY0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=AlqWVlts/7rJiBgXQ2WDKVbtJ3zHVJ3kXXS73j92e2kZi5sIUBAHnmez9rqvddKBVc/dC0Sx18+gLaKQvNCEmlpuRXZeWRU2XAJ+5hfMGhrQD9YeMh2NG0p5zCqlcwL1xsZruGjQhByXrdVH001WQ0U/AVnCmxB7ljHHak1jkiw=
Received: by 10.49.27.11 with SMTP id e11mr7165506nfj.1172823049710;
        Fri, 02 Mar 2007 00:10:49 -0800 (PST)
Received: from ?192.168.68.211? ( [195.176.178.209])
        by mx.google.com with ESMTP id y6sm4081036mug.2007.03.02.00.10.47;
        Fri, 02 Mar 2007 00:10:48 -0800 (PST)
User-Agent: Thunderbird 1.5.0.9 (Macintosh/20061207)
In-Reply-To: <Pine.LNX.4.63.0703012240210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41163>


> please don't take my comments as insults or even strict rules. It is 
> purely for your consideration. (I say this because I haven't seen you so 
> often on this list, so you might not know that discussions about patches 
> are sometimes, erm, lively...)

I absolutely haven't taken any of these comments in the thread as insults (the only thing I found a little dubious, was some usage of uppercase), and I got a lot of constructive criticism that outweighed the "lively" tone.  And as a mistake on my part, I probably should have lurked a bit longer than I did.

>> +static void register_branch_pull (const char *name, const char *remote_name)
> 
> It is not yet remote_name, right? it is branch_name. You extract the 
> remote_name by finding the first slash.

Yeah, it's a remote_branch_name in fact.

> I'd use "char key[1024], value[1024]" instead, erroring out if one of the 
> buffers are too small. It's not like you have to be memory efficient, and 
> it is easier to read.

Ok.

>> +	remote_value[slash - remote_name] = 0;
> 
> You should check if slash == NULL and error out before using it.

remote_name is of the form "REMOTE/BRANCH", because it comes from dwim_ref's output after stripping "refs/remotes/" from the beginning.

> Yes, that is how I imagined it. The rest of your patch looks perfect to 
> me.

I will submit again with the requested changes.  I guess the body of this message is too long to become a "cover letter".

Paolo
