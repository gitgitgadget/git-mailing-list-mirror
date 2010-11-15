From: Kevin Ballard <kevin@sb.org>
Subject: Re: Add colors to the prompt for status indicators
Date: Mon, 15 Nov 2010 14:52:47 -0800
Message-ID: <19363118-D147-4946-8973-B5DDA4B00985@sb.org>
References: <AANLkTi=ZdR4_reQgxL+xRaFE=SaqBYAWTrEuGEbLGynt@mail.gmail.com> <4CE04B82.1040804@pileofstuff.org>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Sebastien Douche <sdouche@gmail.com>, git@vger.kernel.org
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Mon Nov 15 23:52:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PI7v0-0005em-3e
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 23:52:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758720Ab0KOWwv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Nov 2010 17:52:51 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:45375 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755033Ab0KOWwu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 17:52:50 -0500
Received: by pzk28 with SMTP id 28so522pzk.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 14:52:50 -0800 (PST)
Received: by 10.142.170.10 with SMTP id s10mr5402789wfe.340.1289861570615;
        Mon, 15 Nov 2010 14:52:50 -0800 (PST)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id w22sm531972wfd.19.2010.11.15.14.52.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Nov 2010 14:52:49 -0800 (PST)
In-Reply-To: <4CE04B82.1040804@pileofstuff.org>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161520>

On Nov 14, 2010, at 12:50 PM, Andrew Sayers wrote:

> It's possible to work around this for a whole script:
> 
> foo() {
> echo -e "\033[;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0m"
> }
> PS1='\[$(foo)'\]>'

If $(foo) were to emit some actual printable characters, won't this make
bash ignore them when calculating line lengths?

> As a fan of colourful prompts, I'd be very happy if you found a way
> around this for parts of a script.  But as a fan of fast prompts, I'd
> prefer not to call __git_ps1 more than once :)

I don't think there is any way around this, besides patching bash to be
intelligent and determine which PS1 characters are printable itself without
relying on \[ and \].

-Kevin Ballard
