From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2] t7610 (mergetool): more nitpicks
Date: Wed, 25 Aug 2010 00:40:38 -0700
Message-ID: <20100825074034.GA4058@gmail.com>
References: <1282617444-641-1-git-send-email-brian@gernhardtsoftware.com>
 <20100824030524.GF17406@burratino>
 <20100825002552.GI2376@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Charles Bailey <charles@hashpling.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 09:40:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoAaw-0001Wt-Ia
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 09:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826Ab0HYHkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 03:40:21 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:61717 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549Ab0HYHkT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 03:40:19 -0400
Received: by pzk9 with SMTP id 9so77211pzk.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 00:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=JIzS/BHpfO6HdnDWgSc1o7Mw0MW2qzKeWb8QHSN7Jv4=;
        b=g4FR2gg2yhPrP6XTnfVE1/FAh+75PXxy0j4UTCE9WUJ8ao6xzv/2I2WWyZFpo5xW9S
         cJA7sA0iwWlZUCOd8Y8Lgz8ipGT6CS60Enhx97EAzXog/GWQg1bFJfpeXUrEhnMfr6i3
         gSbVjWhbu09NwXXXlhKwbrsp//aTuuobrykvs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=iBEoLarShtmS0hRBWOaxziJE8AVlwY2ccVLsyQNHTdlqs0vyDGxUSXZHWzxvOst+Sk
         FgY/3ip6LFq7mCSAy0sHp8KyQDXHIW9HN9g+puDM8Lucrs6OgEUtiG1ADKZeenEw7zz7
         L9LsXAR8FKbI45eY/L60PbbTOg80ibnoN8fMQ=
Received: by 10.114.133.14 with SMTP id g14mr9010200wad.192.1282722019018;
        Wed, 25 Aug 2010 00:40:19 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id d35sm1736112waa.21.2010.08.25.00.40.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Aug 2010 00:40:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100825002552.GI2376@burratino>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154432>

On Tue, Aug 24, 2010 at 07:25:52PM -0500, Jonathan Nieder wrote:
>  - use tabs to indent
> [...]

Cool.  I'd like to do the same to git-mergetool.sh too.
Until now I've stuck to the existing style.
My editor is setup to display tabs visually which makes it easy
for me to emulate existing code but not everyone does that.

Any objections to a patch that replaces the mixed 4-space+tab
indents with pure tabs?

It would make the git-mergetool consistent with
git-mergetool--lib, git-difftool--helper, and their tests.

I don't know if pure-tabs is the preferred style for *.sh
scripts.  It's not explicitly mentioned in CodingGuidelines'
shell script section.  Updating all of the *.sh scripts, though,
seems like code churn so I wouldn't recommend that unless we
were going to be changing the scripts anyways.

-- 

	David
