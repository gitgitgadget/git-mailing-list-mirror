From: Douglas Stockwell <doug@11011.net>
Subject: Re: gmail smtp server and git-send-mail. Is this combination working?
Date: Sat, 12 Jan 2008 01:36:03 +0900
Message-ID: <fm85u3$mbd$1@ger.gmane.org>
References: <4d8e3fd30801080858h5f109b47v87abc6b315fcfa08@mail.gmail.com>	 <fm1h7t$nnr$1@ger.gmane.org>	 <4d8e3fd30801091509q49c02e1dua4ca42805ba891d6@mail.gmail.com>	 <fm44ck$299$1@ger.gmane.org>	 <4d8e3fd30801101449u11aabd73mba233301df157160@mail.gmail.com> <2faad3050801110419h20acbda8me1cbdb4c6e06a086@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 11 17:37:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDMsO-0007nH-Bv
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 17:37:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752184AbYAKQgd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 11:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751575AbYAKQgd
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 11:36:33 -0500
Received: from main.gmane.org ([80.91.229.2]:47463 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750794AbYAKQgc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 11:36:32 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JDMrs-0000pW-3i
	for git@vger.kernel.org; Fri, 11 Jan 2008 16:36:28 +0000
Received: from ie186.opt2.point.ne.jp ([222.225.39.186])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 11 Jan 2008 16:36:28 +0000
Received: from doug by ie186.opt2.point.ne.jp with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 11 Jan 2008 16:36:28 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: ie186.opt2.point.ne.jp
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <2faad3050801110419h20acbda8me1cbdb4c6e06a086@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70174>

Baz wrote:
> On Jan 10, 2008 10:49 PM, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
> With Authen::SASL and Net::SMTP::SSL, you can get 1 patch at a time in
> via gmail. The alternative connection mode which git-send-email
> doesn't support yet is to connect over smtp then negotiate TLS using
> 'STARTTLS'. If you do this then you can send multiple patches via
> gmail with a single call to git-send-email.

I just tested this. I *was* able to send multiple patches in a single call?

Doug
