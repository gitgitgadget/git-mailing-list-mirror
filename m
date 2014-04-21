From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What is missing from Git v2.0
Date: Mon, 21 Apr 2014 14:34:15 -0500
Message-ID: <535572b73183b_414c80b30863@nysa.notmuch>
References: <CAMP44s17h4Tjg+VaMF0atLep8t-0HVp4UDr1WE2wYnEuZ07eaQ@mail.gmail.com>
 <53557071.5040500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: Sebastian Schuberth <sschuberth@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 21 21:44:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcK8y-0005ph-Iq
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 21:44:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754151AbaDUTok (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 15:44:40 -0400
Received: from mail-yh0-f49.google.com ([209.85.213.49]:53024 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753499AbaDUToj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 15:44:39 -0400
Received: by mail-yh0-f49.google.com with SMTP id z6so3870246yhz.22
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 12:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=YT9ywonzlAm2xqoxxnms8JGxhkRxLoyI/7vE55Bexdo=;
        b=mXrF3QoUpfTWVG1Tw+h32F4KRf0XeNRPKf+qC0MWo3oqwAI0W6SQNmLmzlI4AicYXO
         SaoTRD5/Ik9PsVtD9+uEWZ5FyyRtJ18i2YqNNq0j7jTN3ZvsML9i7UCPkm0Pp4xgsmQW
         MOZLFm1HCqBIZkadis5eJTFtRxYqOFCbwe4tMcFr2lT22eeTqT+1WWdu7oL9sXwJQf5n
         o3nr5W91QyWHyF1DouHfRadjGWiuSOLGnn5sMolBakDcJ0jglzYiIk0uCrpFYnB/+V7a
         JAaIVYyWLkCebKYJPRZyd3U3cz/yZTUR0J0RwwkGjvZDr78Jnvat0yI4m5wkr4aShGsv
         H/7Q==
X-Received: by 10.236.44.132 with SMTP id n4mr262817yhb.161.1398109478869;
        Mon, 21 Apr 2014 12:44:38 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id l4sm71742233yhj.24.2014.04.21.12.44.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Apr 2014 12:44:37 -0700 (PDT)
In-Reply-To: <53557071.5040500@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246627>

Sebastian Schuberth wrote:
> On 21.04.2014 00:41, Felipe Contreras wrote:
> 
> > = Default aliases =
> >
> > Every single version control tool out there has default aliases (e.g.
> > co = checkout) except Git.
> >
> > Every argument against default aliases was basically refuted, yet my
> > patches went nowhere. And the users still expect these aliases.
> 
> +1 about having default aliases in general, and I'd also add these:
> 
> br = branch
> cp = cherry-pick
> dt = difftool
> mt = mergetool

I have these aliases as well, except br => b, and cp => pi. 'br' is probably
better, but not sure as 'cp' which can be confusing.

> BTW, in my experience people tend to stick to predefined aliases instead 
> of redefining them to something (completely) different. This means that 
> having default aliases will very likely enable one to use the same short 
> commands on one's colleague's PC (instead of you running into issues 
> because the same alias was defined to a different command).
> 
> If we don't standardize this now people will come up with their own 
> definitions [1] [2] (and many others if you just search GitHub) which 
> are again likely to differ (slightly), hindering interoperability.
> 
> [1] https://github.com/github/msysgit/pull/27
> [2] https://github.com/sschuberth/dev-scripts/blob/master/git/.gitconfig

FTR color.ui = true is not needed any more, also hopefully mergetool.prompt =
false wouldn't be either [1].

[1] http://article.gmane.org/gmane.comp.version-control.git/246601

-- 
Felipe Contreras
