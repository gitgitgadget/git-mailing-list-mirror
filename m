From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: GSoC - Some questions on the idea of
Date: Sat, 31 Mar 2012 11:18:16 -0500
Message-ID: <4F772E48.3030708@gmail.com>
References: <CA+M5ThS2iS-NMNDosk2oR25N=PMJJVTi1D=zg7MnMCUiRoX4BQ@mail.gmail.com> <CACsJy8APtMsMJ=FrZjOP=DbzuFoemSLJTmkjaiK5Wkq9XtA4rg@mail.gmail.com> <loom.20120328T131530-717@post.gmane.org> <CA+M5ThTPyic=RhFL2SvuNB0xBWOHxNTaUZrYMB144UjpjCiLoQ@mail.gmail.com> <20120330203430.GB20376@sigill.intra.peff.net> <CA+M5ThR6jtxqs0-Kz-8fcRuOFRbLr-GvsJcTmrOQ7_geNspDLg@mail.gmail.com> <4F76E430.6020605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Bo Chen <chen@chenirvine.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Sergio Callegari <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 31 18:18:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SE10U-0000dX-41
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 18:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752728Ab2CaQSW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Mar 2012 12:18:22 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:64150 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268Ab2CaQSU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2012 12:18:20 -0400
Received: by obbtb18 with SMTP id tb18so299192obb.19
        for <git@vger.kernel.org>; Sat, 31 Mar 2012 09:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=RUht1+yjq13MlgYfVc8CVYinMkN5sAkxutcpfd5JWqo=;
        b=zcQINLUxjnMF8dZNeHTTH6MpPwPSr9pqgLw+swjQTk3lP73wwJh1Nly9N8c6AnLmgA
         qvuqvEmrvKuANtGzZCMqYC5c+M6tULedJwPp0vPaQZa9orlz/hnNXp9v/i0C3PE+225l
         l2SmzfoTqsCB3NPIiivDAoT6KwNAi8aqgzK+auXoPrCju/IL3gxs5rCYGOcP5DvoqiyN
         HhhFpQB2JYJ6icmiQs6hfLYFdgBrjRajEHzirMvKHR5HEWqcjvt17QqoLN3Ex1fBqF4y
         cMxzneUxQtdDmu0ACeyCTg6DP04CibZKehquN5tkrSe6SPnwkdtO1+kSt50z3CpFLcD0
         phzg==
Received: by 10.60.14.4 with SMTP id l4mr3326500oec.39.1333210700302;
        Sat, 31 Mar 2012 09:18:20 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id a8sm9902987oea.8.2012.03.31.09.18.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 31 Mar 2012 09:18:19 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.28) Gecko/20120306 Thunderbird/3.1.20
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <4F76E430.6020605@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194455>

On 3/31/2012 6:02 AM, Sergio Callegari wrote:
> I wonder if it could make sense to have some pluggable mechanism for
>  file splitting. Something under the lines of filters, so to say.
> Bupsplit can be a rather general mechanism, but large binaries that
> are containers (zip, jar, docx, tgz, pdf - seen as a collection of
> streams) may possibly be more conveniently split by their inherent
> components.
>

gitattributes or gitconfig could configure the big-file handler for 
specified files.  Known/supported filetypes like gif, png, zip, pdf, 
etc., could be auto-configured by git.  Any yet-unknown/yet-unsupported 
filetypes could be configured manually by the user, e.g.
*.zgp=bigcontainer

v/r,
neal
