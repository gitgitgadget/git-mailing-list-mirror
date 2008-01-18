From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] git-commit: add a prepare-commit-msg hook
Date: Fri, 18 Jan 2008 16:51:19 +0100
Message-ID: <4790CAF7.5010908@gnu.org>
References: <4790BCED.4050207@gnu.org> <alpine.LSU.1.00.0801181545530.5731@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 18 16:51:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFtVX-0004zP-6l
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 16:51:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762174AbYARPvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 10:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762104AbYARPvV
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 10:51:21 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:50627 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761813AbYARPvU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 10:51:20 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1073713fga.17
        for <git@vger.kernel.org>; Fri, 18 Jan 2008 07:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        bh=qOQBzuHjupCkwsM51q0/4+tDA/kQAqkL51LWPV5bI10=;
        b=oXxcwVcF1RfIQGsaWEpsqeBvOI6FqjqGR+uAedlKdyaSHYMYKLRAO4bJDU32c8JsA4DCNSnbyI1yASVIWuPU84xkaJ12SlWkCD4I1Yp2n8IfxUMOTqkcCyTzHjIONJM2jcUiVU2Qs9DSw69Up5eH2EeqFlq2TaeW+LdPVvQAtEg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=hmdQIA5fvLk33w2wJDwe2+nvFEB061PJEJKijHcNhPb4T5FtZvpDfCKEipssv8vx6ZFnDiNmh0pdByUgb0YpL3w7R21AcgM67QENdyuTcNYmm8os9YpGkCw/uAE8DSM+FXAA9zHllQQC60AfN8o9pRkDA6yACYWPZtEr9cmT97Y=
Received: by 10.86.78.4 with SMTP id a4mr3219853fgb.3.1200671479023;
        Fri, 18 Jan 2008 07:51:19 -0800 (PST)
Received: from scientist-2.mobile.usilu.net ( [195.176.176.226])
        by mx.google.com with ESMTPS id d6sm5942365fga.0.2008.01.18.07.51.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Jan 2008 07:51:18 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Macintosh/20071031)
In-Reply-To: <alpine.LSU.1.00.0801181545530.5731@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71031>


>> The prepare-commit-msg hook is run whenever a "fresh" commit message 
>> (i.e. not one taken from another commit with -c) is shown in the editor. 
>> It can modify the commit message in-place and/or abort the commit.
>>
>> While the default hook just adds a Signed-Off-By line at the bottom of 
>> the commit messsage, the hook is more intended to build a template for 
>> the commit message following project standards.
> 
> Would it not be much better for that hook to verify that the template has 
> not been added?

I fail to parse this.

> Or would not be yet even better to use the commit.template config 
> variable, which was intended for that purpose?

The template might not necessarily be fixed, for example it could be 
preloaded with the list of modified files.  See the cover letter for an 
example.

Paolo
