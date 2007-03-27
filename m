From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: .gitlink for Summer of Code
Date: Tue, 27 Mar 2007 01:48:31 +0100
Message-ID: <200703270248.31631.jnareb@gmail.com>
References: <1174825838.12540.5.camel@localhost> <eu8vrb$r15$1@sea.gmane.org> <vpq3b3ruaqp.fsf@olympe.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Mar 27 02:45:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVzoa-0003Xw-A9
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 02:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933851AbXC0Ap3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 20:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933853AbXC0Ap3
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 20:45:29 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:38670 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933851AbXC0Ap2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 20:45:28 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1754493uga
        for <git@vger.kernel.org>; Mon, 26 Mar 2007 17:45:26 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QGWiekpJyzufeRJ7v7b4HV2AlQSBgQDLt3uvug4YMdFOn9uDsL+AM0v3tUXWoMxNkNhNDi7h0m6qKeLu+wq421XFIQ/No87gl+o+fg6rBn7nt73kLnP+3y4eYriMcC38RZ4Je4ShuZeF4FP2PliWDROTJLKEZiEIgeAH/Ee/E08=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=mceNKpwMPwPRpD0sUDHTaLyTtzd+d2SXGSgGBtJ5yAlj/+ZJNo+GtXnMUoiWdYZmUeAzquvjMhxwyqhulCWERiYaGGvER6CdOQNvKBd3JCZubUOysxr4MLJDwCtAH1UcRBzaPzrQdtqQTb0LwEQTP9Ga/BOLRjSVKkYn4SLduPs=
Received: by 10.66.243.4 with SMTP id q4mr44607ugh.1174956326897;
        Mon, 26 Mar 2007 17:45:26 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id j2sm30213247mue.2007.03.26.17.45.25;
        Mon, 26 Mar 2007 17:45:25 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <vpq3b3ruaqp.fsf@olympe.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43219>

Matthieu Moy wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Matthieu Moy wrote:
>>
>>> Stupid question: why .gitlink, and not .git/link or so? This file is
>>> not versionned, I don't think it should be in the working tree.
>>
>> It would be special-cased, as is .git directory not versioned, the
>> same way .gitlink would be not versioned (not like .gitignore).
> 
> That's how I understand it, but why 2 special cases (.git and
> .gitlink) when you need one?

Well, in the first proposal we didn't though about idea of having
lightweight checkout .git/ directory (with .git/link, or core.link 
in .git/config) to have only parts of it, perhaps overriding main
files.

-- 
Jakub Narebski
Poland
