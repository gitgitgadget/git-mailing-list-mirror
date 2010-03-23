From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Tue, 23 Mar 2010 14:27:10 +0800
Message-ID: <41f08ee11003222327u3a709249r7acf176fb31aeee3@mail.gmail.com>
References: <41f08ee11003200218u59c45b6dl82a8eb56cc289256@mail.gmail.com>
	 <81b0412b1003201335g7b37c51mfa3e2280210ebb7e@mail.gmail.com>
	 <4BA544FC.7050007@gmail.com>
	 <41f08ee11003202316w2fddc5f4jebda47f325451577@mail.gmail.com>
	 <4BA61CF9.7040104@gmail.com>
	 <41f08ee11003212052p6b0a7495j2e38f24839541ffb@mail.gmail.com>
	 <alpine.DEB.1.00.1003221924110.7596@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: gitster@pobox.com, gitzilla@gmail.com,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 23 07:27:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtxaA-0007fS-7S
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 07:27:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753528Ab0CWG1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Mar 2010 02:27:13 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:7536 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824Ab0CWG1M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 02:27:12 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1448977qwh.37
        for <git@vger.kernel.org>; Mon, 22 Mar 2010 23:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=BpuKmYp07mzn22ycv45Uh3wxyLqPcF45pAtUUhpilLg=;
        b=w2JBhTueq6yksjl8EJB3/O7P6+GePbgPCrwH8DXwtGJRF0e6Aj/TJWn5N2jFCYnujp
         jT9ritrMZv6dUzu/b8DqMC0eKFKrqbiLRaDwj+5csr03Q1qIzMjItPEAgT3JDl4VnMhh
         Zy/Me0kQb9cSqu98biWIIhYR8IMmEiyv/IK6k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=NydbSAJgiTD1hQvaJsN5gIClAG47UYwWb3CegW7aBVmNTno23DAJoCZp/84DAV8e1u
         HxzCEBctREjwyes/mlFFr4dU7kxzjprxJeQOzfkcBQ8E2T3hij/3cZOODGTtCT9o1zAu
         yRoGIiVgY5vfYUvkZsDIp2DIjLEaINgJgieAY=
Received: by 10.229.212.9 with SMTP id gq9mr315034qcb.84.1269325630380; Mon, 
	22 Mar 2010 23:27:10 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1003221924110.7596@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142990>

Hi,
>> 4. Code copy of modified file in one commit.
>
> You mean code copy from somewhere in the same file?

I am sorry not. I mean, lines copied from other files that were
modified in the same commit. Just what 'blame' means with one '-C'
options.

>
>> 5. Code copy of any place in one commit tree.
>> 6. Fuzzy matching support.
>
> For fuzzy matching support, I would add some ideas, such as trying to
> match alpha-numeric characters, or matching longest words or some such.
> Also mention the possibility that this might be infeasible. In any case,
> give an example what case this is trying to help with.
>

I think fuzzy matching is used to track multiple lines of
copy/movement, even with little change of the source.
For example, one C function is moved from file1 to file2 and get
renamed. In this case, most of the origin code of function body will
remain unchanged except the function name. So, simply compare the new
added lines with original code line by line and permit some percent of
mismatch will help to find this kind of movement.


Regards!
Bo
