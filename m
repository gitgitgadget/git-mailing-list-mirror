From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] gitweb: ref markers link to named shortlogs
Date: Wed, 27 Aug 2008 20:36:30 +0200
Message-ID: <cb7bb73a0808271136k4b420a82kd5d058c4662bbb51@mail.gmail.com>
References: <1219341860-4913-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200808261015.37023.jnareb@gmail.com>
	 <cb7bb73a0808260358o41a04a9ara701e6c726cf2298@mail.gmail.com>
	 <200808261349.28771.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Lea Wiemann" <lewiemann@gmail.com>, git@vger.kernel.org,
	"Petr Baudis" <pasky@ucw.cz>, "Junio C Hamano" <gitster@pobox.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 20:37:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYPth-0003s8-4D
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 20:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752333AbYH0Sgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 14:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751844AbYH0Sgc
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 14:36:32 -0400
Received: from mail-gx0-f29.google.com ([209.85.217.29]:47916 "EHLO
	mail-gx0-f29.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786AbYH0Sgb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 14:36:31 -0400
Received: by gxk10 with SMTP id 10so4513087gxk.13
        for <git@vger.kernel.org>; Wed, 27 Aug 2008 11:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=P2koC0ox0r9JIMCbjOwM61vb+0OQKfNYVlG5SBhFPzE=;
        b=nJGNQMa9mnvSXZA1fwJ4I8BEj9jcmdP7u+TsIWu7JvMORZz8sXe8AMqXhB7+iutkPB
         xR8oLDibLreLd6o+mU5B8LIw9DJUTOzP6hSK1MiXwXYqib4yedEa4z9nDC06e+S0MJdy
         KOTHVcYvRWwR+2P2Vu/GyJiR1ky9duwBlhQZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=hwrdZktD66YNrfd3Z1UkXq96HeXLrmyTW1nHOOQSO7GazKVIvsF74T9/ELqUjXHLgJ
         J2upSck+vv31yX5BtagFfHlnpRwKv/hEO0Iaxtp8GmJVep0iIcWO35gMp0+7mIs5p+1L
         1QBGziBI6rUvR3gK8DYZFOSx3B1RlJ1LV2NTs=
Received: by 10.151.143.14 with SMTP id v14mr603522ybn.69.1219862190158;
        Wed, 27 Aug 2008 11:36:30 -0700 (PDT)
Received: by 10.150.145.2 with HTTP; Wed, 27 Aug 2008 11:36:30 -0700 (PDT)
In-Reply-To: <200808261349.28771.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93915>

On Tue, Aug 26, 2008 at 1:49 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Tue, 26 Aug 2008 12:58, Giuseppe Bilotta wrote:
>> Ah, but the problem is that guessing the action based on the object
>> sometimes depends on the context: for some cases the 'commit' action
>> is the correct one for commits, in other cases shortlog is preferred.
>> This is why I introduced the %views hash in some of my patches.
>
> By the way, this is argument *for* selecting action when generating
> link, if it is possible without incurring unnecessary (if you don't
> follow the link) performance penalty.  For example in the case of
> ref markers links, you can link to 'log' in log view, 'shortlog'
> in 'shortlog' view, perhaps even 'history' in 'history' and 'tree'/'blob'
> views; or just 'shortlog' in all other views (for "commit subject"
> line heading).

So, I managed to get this feature into the latest version of the
refmark patch (v7). Hope it's really the final form 8-)

-- 
Giuseppe "Oblomov" Bilotta
