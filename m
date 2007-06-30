From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: Re: Applying patches in a directory that isn't a repository
Date: Sat, 30 Jun 2007 13:48:11 +0930
Message-ID: <93c3eada0706292118u2058553bj103ba707aa144d16@mail.gmail.com>
References: <93c3eada0706280153w1898be80u7785ef2b2b1dd188@mail.gmail.com>
	 <93c3eada0706282307i7a22bd27w6ca10839d36ea4eb@mail.gmail.com>
	 <7v3b0bi88r.fsf@assigned-by-dhcp.pobox.com>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 30 06:18:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4UPj-0006xl-Ff
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 06:18:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbXF3ESO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 00:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbXF3ESO
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 00:18:14 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:13329 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046AbXF3ESM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 00:18:12 -0400
Received: by nf-out-0910.google.com with SMTP id g13so38553nfb
        for <git@vger.kernel.org>; Fri, 29 Jun 2007 21:18:11 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KG9jisawhDwzPyIZKkk4eBXMKfR1ACTsFxOE3Tf59OG9LglhKpuUJqOilI+5ngjh/ZWWmqs5B7apusmA1GjOHMlq7Djv5DIhMkm6e89YMBC7apDi82jxa6cq2ua2l9GmlBkSpJORYv1zmneQ1F7epc0cYhsUeDSZuXz+gWiHJQs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QmsETw8BWE2TUG95ojiFhAizz6P8W0AhNx38O/6p9DqUt4lcBiibNiuUq2zlD/9I+RxdA95uoCrDtAQbSza5boC8if7yHVocOGLhc/vuDMfqev/Z2dcmgpe29N/RIwlGGn6MsKziM4JvF+YWJ3tDLIPH6C3BynlH+VY9tlGhoHo=
Received: by 10.82.170.2 with SMTP id s2mr7761504bue.1183177091032;
        Fri, 29 Jun 2007 21:18:11 -0700 (PDT)
Received: by 10.82.141.14 with HTTP; Fri, 29 Jun 2007 21:18:11 -0700 (PDT)
In-Reply-To: <7v3b0bi88r.fsf@assigned-by-dhcp.pobox.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51190>

On 6/29/07, Junio C Hamano <gitster@pobox.com> wrote:
> "Geoff Russell" <geoffrey.russell@gmail.com> writes:
>
> > But "git am" needs (AFAIK) a full repository. Is there a way to apply
> > a patch without
> > .git being present?
>
> If the recipient does not have a git repository, there is no
> point using "git am", as it is about making commits out of
> e-mails.
>
> git-apply acts as a plain "patch applicator".

For some reason I thought git-apply also needed a repository --- but it doesn't
and I've just tested it and, bingo, it is perfect for my needs. Many thanks.

Cheers,
Geoff
