From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] gitweb: ref markers link to named shortlogs
Date: Tue, 26 Aug 2008 14:29:31 +0200
Message-ID: <cb7bb73a0808260529t2dc7c031q7f26e4c33aacc112@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Tue Aug 26 14:30:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXxgz-0007lI-I0
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 14:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753998AbYHZM3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 08:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753953AbYHZM3d
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 08:29:33 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:61479 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753844AbYHZM3c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 08:29:32 -0400
Received: by gxk9 with SMTP id 9so2988990gxk.13
        for <git@vger.kernel.org>; Tue, 26 Aug 2008 05:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=jxvlw5lFA5b+aCZmB/9rv1YuNafWyKz9EQydE2RlSpg=;
        b=YClu2OfHdVDkJomquyp6hntxpudamCyVoGOTD7+Ob2NwUHQxdSlM/PvV5ufY09hN96
         nRbaPsY9Bvf/GL73C/fTPTY3Q7Nc6Jn7P1ncyKSw22ibT6jomXjRRXUFc7fTudgHPLxA
         NI+h2kXvx8UnHii1GlSE+mINygR0caruy8SZo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=bJnU2NyBPihg/Kj/EF6NjxBj+DFH7qiMnII6w+AufrF/HbyCLo4svQn8I011jzRozM
         H02opkUhTMRS1qMdMAJ3FzrriwGZHuM1CqyvNPyMa0SaJHYY5TbR6OvSr51QM0qiXf5o
         7I0abGLHqvvK9upCXOz2A5X8O5UL2/6wN7rXc=
Received: by 10.151.108.21 with SMTP id k21mr9124124ybm.151.1219753771459;
        Tue, 26 Aug 2008 05:29:31 -0700 (PDT)
Received: by 10.150.145.2 with HTTP; Tue, 26 Aug 2008 05:29:31 -0700 (PDT)
In-Reply-To: <200808261349.28771.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93743>

On Tue, Aug 26, 2008 at 1:49 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> By the way, this is argument *for* selecting action when generating
> link, if it is possible without incurring unnecessary (if you don't
> follow the link) performance penalty.  For example in the case of
> ref markers links, you can link to 'log' in log view, 'shortlog'
> in 'shortlog' view, perhaps even 'history' in 'history' and 'tree'/'blob'
> views; or just 'shortlog' in all other views (for "commit subject"
> line heading).

An interesting idea. I'll start experimenting with this
context-sensitive action selection for ref-markers. (In the mean time,
I've sent v6 with the simpler 'shortlog or tags' view. I guess an
eventual context-sensitive action can be applied as a subsequent
patch).

-- 
Giuseppe "Oblomov" Bilotta
