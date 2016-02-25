From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv18 00/11] Expose
Date: Thu, 25 Feb 2016 15:35:13 -0800
Message-ID: <20160225233513.GV28749@google.com>
References: <xmqqoab4mnoc.fsf@gitster.mtv.corp.google.com>
 <1456441708-13512-1-git-send-email-sbeller@google.com>
 <20160225231904.GT28749@google.com>
 <CAGZ79kYUkgbHSXYmOXRKhju1QQwiw9EU+VoO-AMZL_nMCf0NNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 00:35:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ5RU-0007yl-3d
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 00:35:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505AbcBYXfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 18:35:20 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33428 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904AbcBYXfR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 18:35:17 -0500
Received: by mail-pa0-f47.google.com with SMTP id fl4so40098178pad.0
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 15:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ImNMkfLV6ps8cc61lVipG9RsWx5OPQYUg4s+G1+QaDg=;
        b=dYitoj9NpqHh1F70ml6ykk7xx9Je99lyKxdI4vYvqFhseR3U0hqOgJWquaoNk0z2Zk
         cVl3wC9LNaWRz8JCOKCT3DDAZ1dbzKA4+mqqqsZYmPOtp3/Xuqxrfy7wdE4RK68PgFQp
         bqumdoMZrdzUrl6+9RGF7ib2xhAOWb56/AZsva2XYZzZGzcU7+lxEWky5PPXL+F+yXme
         YedKcDvEaYxUhfcfMXxNNI4ItVGau3pfukkmjTRKzbKIghMjj0p63G4xCR+YNR0pUYyJ
         mt0/q7sItNeOdZb0eFdfkk4HsA7RLacKzMXj9d4+d76NwD7+fpcAtPXJ4ldeyaTrBXLb
         4iNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=ImNMkfLV6ps8cc61lVipG9RsWx5OPQYUg4s+G1+QaDg=;
        b=V1Vl8s3Edt+YZWljhb44jV6Kk4oI5te/Qad2b1FPIz5/5eCb47cyo2PdYBBdNM6GGY
         0svDA8kP07zxQEKfEXof7pky7Fp4IlFDzS6nLAFKXdWQ5KWYkz+hZ4QM0VCrxCga5M5N
         9T6qncWxU50XM4GP8qLLOTsjjbUqmMT8CIUrHBGJO/dN2FjX0DY334JVSyj8zZyFWMpS
         MRx9O0gJLTLLle+WlUz0fM23SCYPavgenznIRWhOKCmqyICHBLnyfdwLbAMavNTT+cie
         lP5BHLLWE8YgyPVAxsAXBX+FId4Pk25QqhcGjLTlTPaGCaQpjOzI5j/WpCSWCUsgzLpj
         iplQ==
X-Gm-Message-State: AG10YOSW1ktq4P/0BjrXzMYi6fCLJazqto9+k2CR/FuVj9tPuSX8A3MmEsYF5+t+AL9yLA==
X-Received: by 10.66.62.229 with SMTP id b5mr68038448pas.114.1456443317072;
        Thu, 25 Feb 2016 15:35:17 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:d4a8:9152:117:98a9])
        by smtp.gmail.com with ESMTPSA id b63sm14584648pfj.25.2016.02.25.15.35.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 25 Feb 2016 15:35:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAGZ79kYUkgbHSXYmOXRKhju1QQwiw9EU+VoO-AMZL_nMCf0NNg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287492>

Stefan Beller wrote:
> On Thu, Feb 25, 2016 at 3:19 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

> > Now that I look around more, it seems that other submodule--helper subcommands
> > have the same strange behavior of overwriting the 'prefix' var.  So I take
> > back my suggestion of using a different variable --- that can be addressed in a
> > separate patch that deals with them all at once.
[...]
> I plan to fix that up in all the submodule--helper commands once this
> long running series is in,
> but for now we want to keep it consistently awkward?

Exactly.

> I plan to replace that to be
>
>     git -C $wt_prefix submodule--helper <command>
>
> which then doesn't carry a prefix option, but can rely on the prefix from its function
> signature.

Interesting --- git sets a GIT_PREFIX environment variable (in the
same spirit as GIT_WORK_TREE) but doesn't read it.  Using -C is
probably the simplest way to go.

Thanks,
Jonathan
