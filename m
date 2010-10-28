From: Kevin Ballard <kevin@sb.org>
Subject: Re: Why the default action for pull is merge, but not rebase?
Date: Wed, 27 Oct 2010 20:27:12 -0700
Message-ID: <78EBA946-B3BA-458B-9528-C5F80872B3E0@sb.org>
References: <20101027173644.GB15657@burratino> <0016e645b8c87a160804939cdc5e@google.com> <20101027180541.GA20527@burratino> <4CC87DE6.9090604@nextest.com> <4CC8E5B5.7050404@workspacewhiz.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Eric Raible <raible@nextest.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Euguess@gmail.com,
	git@vger.kernel.org
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Thu Oct 28 05:29:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBJBT-0002OG-Vp
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 05:29:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932834Ab0J1D1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 23:27:17 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44507 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932714Ab0J1D1Q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Oct 2010 23:27:16 -0400
Received: by gyg4 with SMTP id 4so925201gyg.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 20:27:15 -0700 (PDT)
Received: by 10.100.106.19 with SMTP id e19mr8576318anc.78.1288236435863;
        Wed, 27 Oct 2010 20:27:15 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id d8sm563701ana.2.2010.10.27.20.27.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Oct 2010 20:27:14 -0700 (PDT)
In-Reply-To: <4CC8E5B5.7050404@workspacewhiz.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160156>

On Oct 27, 2010, at 7:53 PM, Joshua Jensen wrote:

> ----- Original Message -----
> From: Eric Raible
> Date: 10/27/2010 1:30 PM
>> One frustrating aspect of branch.<name>.rebase is that AFAIK
>> there's no way for it to preserve merges.
>> 
>> I would much prefer if branch.<name>.rebase was allowed to
>> specify the arguments to be passed to rebase:
>> 
>> 	git config branch.mybranch.rebase "-i --preserve-merges"
>> 
>> Anyone else see the value of something like this?
> When --preserve-merges actually preserves the merges (perhaps the rebase-i-p branch is on the way to finishing this feature??  I couldn't get it to apply...), I would like this facility very much.  By default, I think rebase *should* preserve merges, and the current flattening it does now should be an option.

Sure would be nice, but that sort of backwards-incompatible change would likely break a lot of people who rely on the current flattening behavior.

-Kevin Ballard