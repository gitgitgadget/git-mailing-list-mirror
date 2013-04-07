From: Andreas Ericsson <ae@op5.se>
Subject: Re: Git/Mac refuses to install on OS X 10.8 (Mountain Lion)
Date: Sun, 07 Apr 2013 16:56:14 +0200
Message-ID: <5161890E.701@op5.se>
References: <5160D223.3090203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Foster <davidfstr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 07 16:56:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOr15-00037a-Jp
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 16:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933873Ab3DGO4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 10:56:19 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:38562 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933866Ab3DGO4S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 10:56:18 -0400
Received: by mail-la0-f45.google.com with SMTP id fn20so1215607lab.18
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 07:56:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=5ID4jBaczl/CHfssktwDolROo41Hm+Prmbw/tzQWkdI=;
        b=L83fZ0MvT0OLx3hMvYEGsERoWSUkSeJAQWZdYPbnxY4ZnNAeJ5QiF15LWL237DQRvo
         58kEtWao0x0ZVepNl370zr7HIb5SJEy2r79FTZ6a6rXRenoSBkkAJXedmMyhyrBf5JdW
         DZC0eGO4HABZoMEKxMr/k21ILOmEO7kqw91lbXAOiA45cyPlq7vLrYL5nQvC7qRmwsut
         fcVMknk6JVUXafkU94Cpi1dZReVXajXiI9kAh9aaLoCftN9d0Pd3imEQicLHXF7Dr4T4
         +8mIOGL3YiglDoLHZwsCBwM5O/3Xk/fZCm5JJb1sT0Mt3RRRw5PbgsCWb9zSNTModaP4
         6qNg==
X-Received: by 10.112.68.34 with SMTP id s2mr9707488lbt.111.1365346577222;
        Sun, 07 Apr 2013 07:56:17 -0700 (PDT)
Received: from [192.168.1.170] (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPS id pk1sm9446717lab.0.2013.04.07.07.56.15
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 07 Apr 2013 07:56:15 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
In-Reply-To: <5160D223.3090203@gmail.com>
X-Gm-Message-State: ALoCoQnVkVpL80GPUPGh4HkOmafU36W+iKD56Y79akfk3o1AezedMTsGiu9pyIPcf/g5z83eiF45
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220311>

On 04/07/2013 03:55 AM, David Foster wrote:
> The default security settings on OS X 10.8 (Mountain Lion) disallow the
> installation of unsigned packages, with no override.
>
> Git/Mac 1.8.2 is not signed and therefore will not install without changing
> the OS default security settings.
>

Sounds like an OSX lockin bugture to me. If anyone can sign the package
with any random key, then it wouldn't provide much in the way of
security, so I guess that means one has to get a signing key form Apple,
which I doubt they just hand out to anyone (usually it means paying
$100 to get an "apple developer certificate). That's nonsense, ofcourse,
but it's how they've chosen to do business.

That aside; Does the package work if you reduce the security settings,
install it and then reset the security settings to their default
settings later? If so, I'd call that a reasonable workaround, and we
probably won't even have to document it since google should provide it
for git and a plethora of other useful packages.

Otoh, if enough osx folks want git on the latest pussycat, I'm sure
they'll provide a package themselves sooner or later, in which case
you just have to wait for that to happen.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
