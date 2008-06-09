From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: squashing patches
Date: Mon, 09 Jun 2008 09:37:47 -0700
Message-ID: <484D5C5B.9090804@gnu.org>
References: <20080607220101.GM31040@leksak.fem-net> <20080609114550.GA8079@leksak.fem-net> <484D47C9.9050509@gnu.org> <20080609162909.GC8079@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Joerg Sommer <joerg@alea.gnuu.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Mon Jun 09 18:38:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5kOO-000476-6l
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 18:38:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752584AbYFIQhw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 12:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752588AbYFIQhw
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 12:37:52 -0400
Received: from ag-out-0708.google.com ([72.14.246.249]:53191 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752246AbYFIQhv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 12:37:51 -0400
Received: by ag-out-0708.google.com with SMTP id 31so5116369agc.10
        for <git@vger.kernel.org>; Mon, 09 Jun 2008 09:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=pauslaUj+BcXsyTp8zCSUgD4Ydnw+IuHjDp8aZK5fFQ=;
        b=HwB+P0/uWF0gx7oLiLgdfUHNKc/maNeC+3aMC2c64Xn5QAwUBbsPJbrWn+27o4/1iV
         vQNRgqwfC1zuL9OG7uhZeRJ4ys3wyzMkZ8wUL3vgBH+iCgiq9w+NGXu61zaE0fAAtBji
         3r5iJfvYhK1FlzAr9YZISZXQHrzGEaMmkq8Ho=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=OqMNyGY6m53V87YbBE+1q4bleJoNJKNumLye7w2px3+c05NLLcWra5s43qIbKiy6z8
         Scx2WGpDqM1r9til0cUEV3EqYCcLBqE8TiBwAF0b7WmEKFJGpDGSYKt1Qi9GmOSBmget
         9HbmVKT7Hf6XeiYuVFmt2G99A7K9FBw/x1oYU=
Received: by 10.150.217.14 with SMTP id p14mr6634586ybg.53.1213029470974;
        Mon, 09 Jun 2008 09:37:50 -0700 (PDT)
Received: from scientist-2.local ( [66.78.193.51])
        by mx.google.com with ESMTPS id p77sm14148369pyb.12.2008.06.09.09.37.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Jun 2008 09:37:50 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Macintosh/20080421)
In-Reply-To: <20080609162909.GC8079@leksak.fem-net>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84401>


>> (the user could choose whether to not edit the editor,
>> or whether to use a no-op for GIT_EDITOR).

Right now, doing

pick a
squash b

will always invoke the editor.  It could be possible to have two 
operation modes.  One in which the sanity check fails, one in which the 
automatic concatenation of two commit messages is used.

> Do you think it's useful to add something like --reference (or -C,
> or however it is called) to git-merge?

Maybe it's not useful, but I think it's cleaner than adding the option 
only to git-sequencer.

Paolo

ps: sure you should ask "the others" (who are more knowledgeable than me 
BTW) for opinions about what I proposed.
