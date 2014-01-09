From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: Verifiable git archives?
Date: Thu, 09 Jan 2014 20:26:32 +0100
Message-ID: <52CEF7E8.3060100@googlemail.com>
References: <CALCETrU88evB6VQrE8=8vrc+HYXAX8_Zx7TsYZp6YXeE4dZdvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Andy Lutomirski <luto@amacapital.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 09 20:26:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1LFa-0004uS-Uk
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 20:26:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754878AbaAIT0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jan 2014 14:26:40 -0500
Received: from mail-ea0-f173.google.com ([209.85.215.173]:46720 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbaAIT0i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jan 2014 14:26:38 -0500
Received: by mail-ea0-f173.google.com with SMTP id o10so1673726eaj.4
        for <git@vger.kernel.org>; Thu, 09 Jan 2014 11:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=HtBr/PDVKWQNYYNfqzhOl57AeBx5LeL32elZWtUx3h0=;
        b=AnsFUxSyKxoh9BQwhVOgNm2lMxxTFv2bQtPMyOZAuBBzHW8ClgjwoQaY0aXJmAw9PC
         /YBKFwLPpK69Kcq+HDW0a3MoohZPdJBaxBNSPNoXGc+0MQu+JbxZRp3CBwLyNWz61s6A
         uqUNDKwP2N/buk646OwC20PTkLMAyOmT+Zar4cI5D/bv1h6Z5mSxgXB9UVJIgd4vLbIM
         Ae5KXwrPmlAmIx0cKamuvt1fTk8iRzYUmZRAzltivKcHmvDIPu2w1CngeQAL/c9YCxv4
         t60FswwPf5Vf43P0/q0vKjqjv4suLzc3FGZweGLjQ4jA9/IbXrsWX7wtNcb8K3zjBrhp
         DJ2g==
X-Received: by 10.14.149.139 with SMTP id x11mr4927055eej.35.1389295594646;
        Thu, 09 Jan 2014 11:26:34 -0800 (PST)
Received: from [192.168.1.7] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id m1sm8215208eeg.0.2014.01.09.11.26.33
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 09 Jan 2014 11:26:33 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <CALCETrU88evB6VQrE8=8vrc+HYXAX8_Zx7TsYZp6YXeE4dZdvg@mail.gmail.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240267>

On 09.01.2014 04:10, Andy Lutomirski wrote:
> It's possible, in principle, to shove enough metadata into the output
> of 'git archive' to allow anyone to verify (without cloning the repo)
> to verify that the archive is a correct copy of a given commit.  Would
> this be considered a useful feature?
> 

Do you know git bundles?


> Presumably there would be a 'git untar' command that would report
> failure if it fails to verify the archive contents.
> 
> This could be as simple as including copies of the commit object and
> all relevant tree objects and checking all of the hashes when
> untarring.
> 

I thought the git archive rather had the purpose of creating plain
archives not polluted with any gitish stuff.

> (Even better: allow subsets of the repository to be archived and
> verified as well.)

Stefan
