From: Josef Wolf <jw@raven.inka.de>
Subject: Re: error: src refspec refs/heads/master matches more than one.
Date: Fri, 14 Feb 2014 23:53:48 +0100
Message-ID: <20140214225348.GD17817@raven.inka.de>
References: <20140214113136.GA17817@raven.inka.de>
 <87a9dt981o.fsf@igel.home>
 <CACsJy8BevKQaRLYMMv7bTjf_ZAOnkrimws519OyhGZz6_Vr_-A@mail.gmail.com>
 <xmqqy51dirjs.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 15 00:00:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WERk2-0004A2-TQ
	for gcvg-git-2@plane.gmane.org; Sat, 15 Feb 2014 00:00:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752831AbaBNXAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 18:00:11 -0500
Received: from quechua.inka.de ([193.197.184.2]:37848 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752470AbaBNXAL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 18:00:11 -0500
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1WERjt-0005vJ-LP; Sat, 15 Feb 2014 00:00:09 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id 9C0EA7629A; Fri, 14 Feb 2014 23:53:48 +0100 (CET)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <xmqqy51dirjs.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242155>

On Fri, Feb 14, 2014 at 08:32:07AM -0800, Junio C Hamano wrote:
>  A. You are not allowed to call your branch with a string that begins with
>     'refs/heads/'.
>  B. Why?
>  A. Because it will confuse you.
>  B. I know what I am doing.
>  A. ???

Your reply in
http://git.661346.n2.nabble.com/1-8-0-git-checkout-refs-heads-foo-checks-out-branch-foo-td5999936.html
suggests that one should explicitly use the refs/heads prefix to to work
around ambiguities in some situations.

Are there any best-practices sugestions out there about when to use the
refs/heads prefix and when not? It looks like git delibaretly cuts off this
prefix in some situations.

I don't think my problem stems from something like "git branch refs/heads/master"
Anyway, some clarifications about the usage of this prefix would be great!

-- 
Josef Wolf
jw@raven.inka.de
