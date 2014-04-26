From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2014, #08; Fri, 25)
Date: Sat, 26 Apr 2014 01:04:10 -0500
Message-ID: <535b4c5a3c91c_3d63109d2f00@nysa.notmuch>
References: <xmqqoazpt45p.fsf@gitster.dls.corp.google.com>
 <20140425231953.GB3855@sigill.intra.peff.net>
 <535b0db7e5e31_ba2148d310f4@nysa.notmuch>
 <BLU0-SMTP3741FBD4980A29338AC8BA8D1450@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
To: Alex Davidson <descenterace@hotmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 26 08:14:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wdvss-0005z3-UZ
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 08:14:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbaDZGOm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2014 02:14:42 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:53777 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbaDZGOl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2014 02:14:41 -0400
Received: by mail-ob0-f173.google.com with SMTP id wn1so5239576obc.18
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 23:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-type:content-transfer-encoding;
        bh=dW97XG6gdAUoKGleyLtj2SwkgnAmOQ4ZThpLXGKQ8uc=;
        b=E7afxQP/2tyLAXpEgQZEQEXmO2MvhFRBX9zIwKtWBnKzbkzQ4Mi/keijU0s5HRi9Wg
         5lqL8P9kVzIVrC8E/EDdRGvrpwGLh7vIV2GsrLYVCBnjTUSJLGmblm7CHoUXb8NktZnJ
         b1vIwrxwe1v2eSRf1zKTZ/lRsDsfDIkAJaUea6vw7vxnTq320+Ll2PzYUiKIiAxnVAqG
         bChwNwMQkkCFESpju7tVN5r5z3jJza/ls5OFeqUSWeVENMLlDzCKLXVIojFmC+/iyqEM
         sGJFJhVQksSk6yh3DtaskMv4eJ9AI/JoTJRd+wwFSp+msm8r3K+uKahbYF0c5F3XrFqk
         bBJA==
X-Received: by 10.60.125.72 with SMTP id mo8mr10848032oeb.36.1398492881172;
        Fri, 25 Apr 2014 23:14:41 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id c7sm41686212oek.12.2014.04.25.23.14.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Apr 2014 23:14:38 -0700 (PDT)
In-Reply-To: <BLU0-SMTP3741FBD4980A29338AC8BA8D1450@phx.gbl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247145>

Alex Davidson wrote:
> On Fri, 2014-04-25 at 20:36 -0500, Felipe Contreras wrote:
> > Jeff King wrote:
> > > If you are waiting on me, I do not have much else to say on this topic.
> > > @{publish} as specified by Felipe is not useful to me, and I would
> > > continue to pursue @{push} separately as "the remote-tracking branch of
> > > where you would push to". I think there is room for both concepts.
> > > 
> > > As for the patches themselves, I have not reviewed them carefully, and
> > > would prefer not to. As I mentioned before, though, I would prefer the
> > > short "@{p}" not be taken for @{publish} until it has proven itself.
> > 
> > Presumably you want to save it for @{push}. While I'm not against to having
> > just @{publish} for now, I'm farily certain most people would be using
> > @{publish} and not @{push}, as that's what `git branch -v` would show, and it
> > would be closely similar to @{upstream}. Therefore it would make sense to use
> > @{p} for @{publish}
> 
> TL;DR: Presumably you want to grab it for @{publish} without evidence to
> support a decision either way. 

The reasons why @{publish} will be useful have been documented and explained
already multiple times.

> The thing with shortened forms and abbreviations is that they assume a
> mode of thought. Human communication assumes a lot of shared context,
> hence the disconnect between code (explicit) and intent (often dependent
> on context of conversation). Abbreviation is a form of compression using
> context as an implied key.
> 
> Users who do not share your context will not find your abbreviation
> intuitive. If a consensus context cannot be identified, abbreviation may
> be interpreted as an attempt to impose a context. In other words, 'of
> the many valid workflows enabled by git we obviously prefer this one
> because we have provided more shortcuts for it'.
> 
> Attempts to impose context are not unreasonably perceived as political.
> 
> Saying that you are 'fairly certain' that most people would be using A
> over B 'and therefore' we should support A smacks of political
> manoeuvring rather than scientific experimentation.

That is not political. Political would be if I gathered support from other
developers and said "more of us prefer this". This is not what I'm doing.

My conclusion is based on logic and reason, which are the bedstone of science.
You can make sensible decisions based on that alone, and in fact that's how
most good decisions are made.

-- 
Felipe Contreras
