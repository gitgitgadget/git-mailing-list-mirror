From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [Opinion gathering] Git remote whitelist/blacklist
Date: Tue, 24 May 2016 15:25:12 -0400
Message-ID: <166C4E9F-6231-47ED-88F3-EAD95DEE7DF2@gmail.com>
References: <1040142021.5607762.1463753271105.JavaMail.zimbra@ensimag.grenoble-inp.fr> <584027154.5608416.1463754104066.JavaMail.zimbra@ensimag.grenoble-inp.fr> <001001d1b2a3$06d7bbb0$14873310$@nexbridge.com> <1929221963.5686879.1464007899902.JavaMail.zimbra@ensimag.grenoble-inp.fr> <1884904685.12056.1464084750628.JavaMail.zimbra@ensimag.grenoble-inp.fr> <84BDC4A4-FBE1-4542-868C-FA77A25469F3@gmail.com> <vpq37p74nu1.fsf@anie.imag.fr> <CAPc5daURo8SkbeGf0MEsp0sLzdzFfUOxptgusFr58UG9SKmDAA@mail.gmail.com> <002b01d1b5d7$aefd0a70$0cf71f50$@nexbridge.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Francois Beutin <beutinf@ensimag.grenoble-inp.fr>,
	Git Mailing List <git@vger.kernel.org>,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	wiliam duclot <wiliam.duclot@ensimag.grenoble-inp.fr>,
	antoine queru <antoine.queru@ensimag.grenoble-inp.fr>
To: "Randall S. Becker" <rsbecker@nexbridge.com>
X-From: git-owner@vger.kernel.org Tue May 24 21:25:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5HxA-00022V-OI
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 21:25:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbcEXTZQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 15:25:16 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:34104 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932190AbcEXTZO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 May 2016 15:25:14 -0400
Received: by mail-qg0-f51.google.com with SMTP id 90so12131040qgz.1
        for <git@vger.kernel.org>; Tue, 24 May 2016 12:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=cMvgld1s+00shok+CSoOSWjeXhVwM5aDTubg5FjINWw=;
        b=U0EdqieLxDVXqcq9w7YJCw+YQCyqg/hbfgfd5f2kaQAi2exYr0Qb0tJ2I6kRGOHgq1
         AsZa0HunPJGUpaCKbftc4df0AHqQPKAcAiouyru1E5K9u2oKP9PJRf6LaWek95qDDW8T
         vTo6MLwXx0WMScGvtXOCfH5mx96zD7P13OxzIRoGJ8qcwicJmybOehTZmu6TZzNCNu16
         BvSNHq6cc17tRs56+BJv/CksppRhpX5FqoUnduuZkr/A9seGs0sNAWkImeTz8/NKQDLb
         PImqbaDw+gP3WZ9UdD38DPkyvQyOmz9nXhEcw9cgZPYv5UR7ehcL0uF6E9EIXuGr9bxZ
         qo3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=cMvgld1s+00shok+CSoOSWjeXhVwM5aDTubg5FjINWw=;
        b=W5ID/A2DFMSBnN0y+I0N2b9kIQbPPp/Be/ZYyFiIOh4d3iJ8H6mrAot2WDJsz/2km6
         nWCZTMyVCAmlPka4GFvtX4DkyfSz4PDxGfKsz5gt9Wjd42THsJz+sJgw1OcQmMMs/Vvk
         Fk4QolrVH0KS0RNT1CiuCu/5wh5Btnb3IgPuKQHaD1JL/rzK7A3JDGxCybmD9sjs2s99
         VtIwXCxTycg+WAnNd3Er3rZCe4+1IuYv58ltRzMMGrFSgO85JW1N2lgs9xGUhtC9DBEm
         V9mrYx/y5BYIXk6Jdg12rUlQResjaZ+DcJUDR8DwlefZIBEYKMz3yUrXpjSZbHO7lLVH
         /hcw==
X-Gm-Message-State: ALyK8tL2+AyGmXQUbXTaRcFRb9h0I0UBhcFU20h9xI0r9pq/bijs58+1wcL6FaScDSDTog==
X-Received: by 10.140.38.165 with SMTP id t34mr4884950qgt.47.1464117913510;
        Tue, 24 May 2016 12:25:13 -0700 (PDT)
Received: from rem20twn32.ads.autodesk.com ([132.188.72.187])
        by smtp.gmail.com with ESMTPSA id x134sm1265273qkx.12.2016.05.24.12.25.12
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 12:25:13 -0700 (PDT)
In-Reply-To: <002b01d1b5d7$aefd0a70$0cf71f50$@nexbridge.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295526>


> On 24 May 2016, at 12:16, Randall S. Becker <rsbecker@nexbridge.com> wrote:
> 
> On May 24, 2016 12:08 PM, Matthieu Moy wrote:
>>> So, when trying a forbidden push, Git would deny it and the only way
>>> to force the push would be to remove the blacklist from the config, right?
>>> 
>>> Probably the sanest way to go. I thought about adding a "git push
>>> --force-even-if-in-blacklist" or so, but I don't think the feature
>>> deserves one specific option (hence add some noise in `git push -h`).
>> 
>> Yeah, I agree --even-if-in-blacklist is a road to madness, but I wonder how
>> this is different from setting pushURL to /dev/null or something illegal and
>> replace that phony configuration value when you really need to push?
> 
> May be missing the point, but isn't the original intent to provide policy-based to control the push destinations? A sufficiently knowledgeable person, being a couple of weeks into git, would easily see that the config points to a black-listed destination and easily bypass it with a config update, rendering all this pointless? This seems to me to be a lot of effort to go to for limited value - unless immutable attributes are going to be obtained from the upstream repository - which also seems to run counter to the whole point.

An actor with a bad intent will *always* be able to bypass this. However, I see two use cases:

(1) Accidental pushes. 
An inexpierenced developer clones a repo from github.com, commits for whatever reason company code and pushes. At this point the code leaked. The blacklist feature could have warned/stopped the developer.

(2) Intentional open source pushes.
At my day job we encourage people to contribute to open source. However, we want them to follow our open source contribution process. If they run "git push" on a new github.com repo then I want to interrupt the push and tell them to look at our contribution guidelines. Afterwards they could whitelist the repo on their local machine and push without trouble.

In summary I think the feature could be a safety net for the developer to not leak company code.

Cheers,
Lars