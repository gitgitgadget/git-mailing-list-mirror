From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Pull is Mostly Evil
Date: Sat, 03 May 2014 06:30:26 -0500
Message-ID: <5364d3528eb93_14419272f03@nysa.notmuch>
References: <5363BB9F.40102@xiplink.com>
 <87k3a4xjzg.fsf@fencepost.gnu.org>
 <C439C0C76DA44AB5AAC91E7C0D2991BA@PhilipOakley>
 <5363ec734572a_70ef0f30cdc@nysa.notmuch>
 <2F8B2EEED0594446A6FCF771BBEDFB56@PhilipOakley>
 <536428f7796e0_200c12912f03@nysa.notmuch>
 <8F49068316F64566954C5D037C512704@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: Philip Oakley <philipoakley@iee.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org, David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat May 03 13:41:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgYJd-0002c6-QG
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 13:41:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbaECLlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2014 07:41:09 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:52334 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050AbaECLlI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2014 07:41:08 -0400
Received: by mail-ob0-f174.google.com with SMTP id gq1so6412612obb.5
        for <git@vger.kernel.org>; Sat, 03 May 2014 04:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=gYit//JsOCFrAMMRlOUbeIfOvMo6caag/UBnOJjeJqI=;
        b=VXMwTQlE/OTv+gsJrcTGnVk6EBTZKQvqrK48KprEK1vcfNlCpDRT1VvgtqI3/weQ1L
         L7nEKkX67Zdf4oWaFJ5Soi8mlDmSMxbpSWKKEfZ0OB5xC4uapDvqNg/K2TnAmnE5E0/T
         CDnpiHL9IKt9bkJjulM6MeT2wid1etkJvwIdcW5KHmqb/0TP7xuq8G//hh6DVV3qGGiv
         wcKAfGPnaRNk9XpFDD29921gaZfMoYDNorNuqWTrmquO0p+niXOFe1GWPKHZAhDaPXjz
         qiAAB8pwqjtfq413fhAIZ/2urznjdn+g8TSIQUtSpFvCQigpOj/OuUjpRQEahOsxYlD0
         1sdA==
X-Received: by 10.60.33.229 with SMTP id u5mr1415244oei.73.1399117267049;
        Sat, 03 May 2014 04:41:07 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id pt8sm4622561obb.5.2014.05.03.04.41.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 May 2014 04:41:05 -0700 (PDT)
In-Reply-To: <8F49068316F64566954C5D037C512704@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248036>

Philip Oakley wrote:
> From: "Felipe Contreras" <felipe.contreras@gmail.com>
> > When doing something is better for the vast majority of people, that's
> > what should be done by default, unless the results are catastrophic 
> > for
> > the minority.
> >
> > Since doing something is not catastrophic to the minority, it follows
> > that the default should be to do something.

> > It's a simple as that.
> 
> ... which makes it not quite as simple as that ;-) [evidence: the 
> ongoing dialog among all and sundry]

The dialog is not simple becuase it's not easy to make `git pull` do the
sensible thing. That doesn't mean `git pull` should do *nothing*, that
doesn't follow from the argument above.

-- 
Felipe Contreras
