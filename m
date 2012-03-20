From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] Unification of user message strings
Date: Tue, 20 Mar 2012 05:01:05 -0700 (PDT)
Message-ID: <m339934h39.fsf@localhost.localdomain>
References: <1332179503-2992-1-git-send-email-vfr@lyx.org>
	<1332179503-2992-2-git-send-email-vfr@lyx.org>
	<20120319205300.GA3039@sigill.intra.peff.net>
	<7vaa3c9ste.fsf@alter.siamese.dyndns.org> <4F683622.6010409@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Tue Mar 20 13:01:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9xka-0001a1-LZ
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 13:01:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759810Ab2CTMBK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Mar 2012 08:01:10 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:33551 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759801Ab2CTMBG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2012 08:01:06 -0400
Received: by wibhq7 with SMTP id hq7so5113692wib.1
        for <git@vger.kernel.org>; Tue, 20 Mar 2012 05:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=yxUHjLDCY2u6t99ueZDs2gQF2RHSy65DVXcEUJhcMW4=;
        b=PaWtW/UPgMunpzZPPfWnZbjGGwFYuLDU+bPhgvcAlkZgrXzo8I9eZRZlUVb33U/VQV
         2Rkii+kHmqP5thmPWrhq1B1u/wa3oTYfkWpTphwTLWCPB0K+UsHVvpRZW67Z15r+in37
         d2Ufxzw/ANZ4HahXyvngebTohB8UGYbsHU9JLy8Q+ud1BgondIMxouoPk5agJsZ7yxWH
         2K005pJUaJGee0dnQOConLbee1Lfw2kmq1w73ZaAZTgqC052cc5I1FqgtiFKurdERMqa
         GksG0WfvWzNBr+i+wMZtaMECKbQD5grRE0RUrkO3w7CYXt50io/4lUKXPFsY6imuS0GH
         Myfw==
Received: by 10.180.105.69 with SMTP id gk5mr32947549wib.3.1332244865632;
        Tue, 20 Mar 2012 05:01:05 -0700 (PDT)
Received: from localhost.localdomain (abvw11.neoplus.adsl.tpnet.pl. [83.8.220.11])
        by mx.google.com with ESMTPS id ex2sm5785023wib.8.2012.03.20.05.01.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 20 Mar 2012 05:01:05 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q2KC10Sb019350;
	Tue, 20 Mar 2012 13:01:01 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q2KC0xnd019347;
	Tue, 20 Mar 2012 13:00:59 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4F683622.6010409@lyx.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193497>

Vincent van Ravesteijn <vfr@lyx.org> writes:

> > I had a vague impression that plumbing messages tend to be lowercase.  If
> > it is not be too much trouble, it might be interesting to redo the numbers
> > divided into the plumbing and Porcelain messages. Perhaps these "50%"
> > folks updated both plumbing and Porcelain. Another possibility is that
> > they tried to follow the local convention when they added a new one, or
> > reworded an existing one.
> >
> > If we would be rewording, we would only be doing the Porcelain messages,
> > so I am OK with either way.
> 
> It seems that the terms "Porcelain" and "plumbing" seems to be mixed
> up somewhere.
> 
>  From 'git help status': "The porcelain format is similar to the short
> format, but is guaranteed not to change in a backwards-incompatible
> way between git versions or based on user configuration. This makes it
> ideal for parsing by scripts".

The '--porcelain' option means "intended *for* parsing by porcelain",
not that it is 'porcelain' output.
 
>  From 'http://progit.org/book/ch9-1.html': "....it has a bunch of
> verbs that do low-level work and were designed to be chained together
> UNIX style or called from scripts. These commands are generally
> referred to as 'plumbing' commands, and the more user-friendly
> commands are called 'porcelain' commands."

Mnemonics: "plumbing" are hidden 'guts' of git (the engine / backend
part).

> It feels like 'porcelain' means: "be careful, things break easily";
> and 'plumbing' means: "use all the force you want to get it into (a
> user-friendly) shape".
> 
> Second, to me it is not totally clear which strings are plumbing and
> which ones are porcelain. Is there a general rule to tell ? The
> command-list file says what the general intention of a command is, but
> often it's both plumbing as porcelain.

"Porcelain" commands are those that are facing user (as is "porcelain"
in armature), so they might be changed to make it more user friendly.
 
"Plumbing" command output is to be consumed by other commands and
scripts, so it must be 'cast in stone' and cannot be changed.  It is
meant to be easily machine-parseable, and not to be user friendly.

> Can anyone help me out here ?

HTH
-- 
Jakub Narebski
