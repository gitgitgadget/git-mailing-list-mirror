From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v1] config: add '--sources' option to print the source of a config value
Date: Sun, 7 Feb 2016 20:28:26 +0100
Message-ID: <DF57DD4F-630F-421D-A379-0A451F6509DF@gmail.com>
References: <1454661750-85703-1-git-send-email-larsxschneider@gmail.com> <56B483C0.6070906@gmail.com> <20160205112240.GA18581@sigill.intra.peff.net>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 07 20:28:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSV0c-0005nM-BF
	for gcvg-git-2@plane.gmane.org; Sun, 07 Feb 2016 20:28:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754506AbcBGT2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2016 14:28:31 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35514 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbcBGT2a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Feb 2016 14:28:30 -0500
Received: by mail-wm0-f48.google.com with SMTP id r129so88542630wmr.0
        for <git@vger.kernel.org>; Sun, 07 Feb 2016 11:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6jZtrsaF737GESRJNWfkrcagqCOv6LVrafsL9jTUUBc=;
        b=od1UEHJOxI7ZwkkMh/5R16tZ9gKWH20U1gFJhnpTEQGLbb+QC1fJ1h+Nivved5nV/p
         ED8SAivOEOnccb8UYhe5F904UnU6G2VvAoPB9yVbGWqsrUXa/IofhL293AfTS73JqD1O
         w3op0udHI22Yq5PEg6fDIwUHBH92U4xFhy3LEnwfO15nKoRPU+lzTabZY9TUHmqUtiuI
         wnHOl0XbvBgvOzi2Z9N4HZOKdj3YpO+EQxk0xd1/q8UUBtIngt2J2P4/eG0ajVCw6/W+
         cJfr7a9thQZW99Z6VUKLG1pbXq5sQM3oC2XHXDhv1AkwBxbix+OCW/YJVmADA3Hy2mLM
         usZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=6jZtrsaF737GESRJNWfkrcagqCOv6LVrafsL9jTUUBc=;
        b=F14zNo3G5QIft1KwH/rFZQak9j1TmZrN/YYAtZvc7FolmXyC2AXFJoVakQCNBAaAyI
         ueBEEw2toEjc8cg999it5fyY0YA7uylDgDxmBsofvEY47I1WLgHypTF8GVPYSNfaElyp
         liqntRPk2/r5/sK2pA9iNkCZuKWs7uzWUp/WizE51BGKaYBNFwHZfGxlqdFg5f17Gg9Y
         JrVLgDmoERNMrl+N3/KuPgqoHQJALF8nByXZWqaMeN5YYBcvEPoTCBUVxxDk4uUYYo5C
         t8BIq9QinrEMZ/g0rhbOhRX+L0awwbdXcUo79G8UdIdCZFcGRDlRUsGpbwMZKtYTysYR
         GPRg==
X-Gm-Message-State: AG10YOQIbsC/AadkfjmCGAUOflXTsG/lYL14Cmq/jZ6z0OArmbbhxG07M9qMgvphBUEueg==
X-Received: by 10.194.84.34 with SMTP id v2mr16929670wjy.175.1454873309062;
        Sun, 07 Feb 2016 11:28:29 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB606F.dip0.t-ipconnect.de. [93.219.96.111])
        by smtp.gmail.com with ESMTPSA id i12sm9088254wmf.10.2016.02.07.11.28.27
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Feb 2016 11:28:28 -0800 (PST)
In-Reply-To: <20160205112240.GA18581@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285737>


On 05 Feb 2016, at 12:22, Jeff King <peff@peff.net> wrote:

> On Fri, Feb 05, 2016 at 12:13:04PM +0100, Sebastian Schuberth wrote:
> 
>> On 2/5/2016 9:42, larsxschneider@gmail.com wrote:
>> 
>>> Teach 'git config' the '--sources' option to print the source
>>> configuration file for every printed value.
>> 
>> Yay, not being able to see where a config setting originates from has
>> bothered me in the past, too. So thanks for working on this.
>> 
>> However, the naming of the '--sources' option sounds a bit misleading to me.
>> It has nothing to do with source code. So maybe better name it '--origin',
>> or even more verbose '--show-origin' or '--show-filename'?
> 
> I think he inherited the "--sources" name from me. :) I agree it could
> be better. I think "--show-filename" is not right as there are
> non-filename cases.  Just "--origin" sounds funny to me, perhaps because
> of git's normal use of the word "origin".
> 
> I like "--show-origin" the best of the ones suggested.

I understand your reasoning and I agree that "--show-origin" is better than
"--sources". However, I think just the word "origin" could be misleading in 
this context because people associate it with Git remotes. How about
"--show-config-origin" then? Or would that be too verbose?

Thanks,
Lars
