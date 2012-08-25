From: Andreas Ericsson <ae@op5.se>
Subject: Re: libgit2 status
Date: Sat, 25 Aug 2012 11:56:24 +0200
Message-ID: <5038A148.4020003@op5.se>
References: <87a9xkqtfg.fsf@waller.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: greened@obbligato.org
X-From: git-owner@vger.kernel.org Sat Aug 25 11:56:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5D6e-0000dH-Kq
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 11:56:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752641Ab2HYJ4c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Aug 2012 05:56:32 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:58119 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752110Ab2HYJ4a (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Aug 2012 05:56:30 -0400
Received: by lagy9 with SMTP id y9so1648593lag.19
        for <git@vger.kernel.org>; Sat, 25 Aug 2012 02:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=W5FYVg1lzT4siiMa4ECo7L6fa0O5K7RxxMc/KaAWx6g=;
        b=Xt9XeR87dik0vTP7akK6IqNadqSV1Ok/6AYX79hRKh1jmCLbs6z3Zr9gWfJme9dN9p
         SbXwXK0IuNO+SSPC5W1LZ/L2yc/PwYNCLpruy43wmFWtJaztEwMMbrglct+XeHDHqyOq
         2K49FEv949RmbnrYgoRF2x+uZM1x+XyMtSbNcsI8xrNZNXnooRl+4cpgVkk5h+pdOvW6
         JeNefefl9hAit+fuJemBSISXMJ2869D7cqCOcxg4/sngeJI9rXHpnUl7DaTBW+LK6LGW
         O8ibpWwgwNGO3Utl4ELv1o495XtDDdfryHErAXEXEnrtMnsnHJ6787Qe0OHm/qwT8E/u
         PZ7A==
Received: by 10.112.24.196 with SMTP id w4mr3839078lbf.37.1345888588894;
        Sat, 25 Aug 2012 02:56:28 -0700 (PDT)
Received: from vix.int.op5.se (c80-217-218-226.bredband.comhem.se. [80.217.218.226])
        by mx.google.com with ESMTPS id d1sm3099658lbk.16.2012.08.25.02.56.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 25 Aug 2012 02:56:27 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120717 Thunderbird/14.0
In-Reply-To: <87a9xkqtfg.fsf@waller.obbligato.org>
X-Gm-Message-State: ALoCoQkfj1HOQ6yepqMbP4hl7iDYtmr00vE7k1RaytOCbVoFB6JrzslHhAoOzFcqy/hVuves4FDU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204270>

On 08/24/2012 04:02 PM, greened@obbligato.org wrote:
> What is the status of libgit2 WRT the overall git project?  I recall
> that there was some discussion of basing bits of git on libgit2 once it
> matures.
> 
> I ask because I'm starting a project to improve the abysmal speed of
> git-subtree split.  It's unbearably slow at the moment and as far as I
> can puzzle out it's due almost entirely to repeated subshell invocations
> to run git commands.
> 
> I was planning on doing some experiments rewriting bits of git-subtree
> using libgit2 but I want to make sure that that isn't wasted work.  It
> appears to be exactly what I need to code bits of git-subtree natively.
> 
> Thoughts?
> 

libgit2 is now maintained by Vicent Marti, who was once a gsoc student.
He's employed by github and seems to spend most of his time working on
libgit2.

Politically, I'm not sure how keen the git community is on handing
over control to the core stuff of git to a commercial entity, but it
doesn't seem to be a dying project, so I'd say go ahead and do it.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
