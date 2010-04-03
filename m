From: Michael Witten <mfwitten@gmail.com>
Subject: Re: 'git gc --aggressive' effectively unusable
Date: Sat, 3 Apr 2010 15:33:20 -0600
Message-ID: <p2gb4087cc51004031433xc57e52bbq733d1d3c5f37f238@mail.gmail.com>
References: <201004030005.35737.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
X-From: git-owner@vger.kernel.org Sat Apr 03 23:33:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyAyW-0006Dn-8J
	for gcvg-git-2@lo.gmane.org; Sat, 03 Apr 2010 23:33:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756026Ab0DCVdo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Apr 2010 17:33:44 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:63331 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755944Ab0DCVdm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Apr 2010 17:33:42 -0400
Received: by fg-out-1718.google.com with SMTP id d23so12953fga.1
        for <git@vger.kernel.org>; Sat, 03 Apr 2010 14:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=BeCCZWbwHvVGHjBWCLjmgLtypZ7G6RyVWrFmxO6XEik=;
        b=iIxsg65IMSOIX/jhcbXPY+3LqYGyU46y1kPZvFLnaTv5FwGYI4P+GMaUxCr3uYwH6f
         cMV/fUUgJlhMX36bFgux2xzgpx0aw1w9Ws0hMx3+KFYPHxW6QeqpvCsNfLMGE8jBQH8m
         1N2uWEhvgYl2BSdUSZ1BYWp+G7t+mLZSdQhQs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=MJcGpe4SBov6hNG983PqMoOqH3tKOwUpAhMCQgYKH9vHTMFv1NfU8dEx6+P4wVDDlx
         uzKTdeAF8CxjmlhT6uSPEURNeaEXGfjMRKMZ6xh/acWj8Oe91BNmW5xRh3KJ6nOQWD1y
         qAPAZhuDtAvAyE3EGeqKbFm/rLT//fsegwPiQ=
Received: by 10.239.133.140 with HTTP; Sat, 3 Apr 2010 14:33:20 -0700 (PDT)
In-Reply-To: <201004030005.35737.elendil@planet.nl>
Received: by 10.239.137.197 with SMTP id m5mr329491hbm.62.1270330420122; Sat, 
	03 Apr 2010 14:33:40 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143904>

On Fri, Apr 2, 2010 at 16:05, Frans Pop <elendil@planet.nl> wrote:
> I haven't had the patience to let it finish

There's your problem.

$ git help gc | sed -n /--aggressive$/,+3p
       --aggressive
           Usually git gc runs very quickly while
           providing good disk space utilization
           and performance. This option will
           cause git gc to more aggressively
           optimize the repository at the expense
           of taking much more time. The effects
           of this optimization are persistent, so
           this option only needs to be used
           occasionally; every few hundred
           changesets or so.

Last time I used this option (on Linus's Linux repo), I let the
algorithm do its thing for a couple of hours. Maybe the efficiency
could be vastly improved, but it does finish if you let it.

SIncerely,
Michael Witten
