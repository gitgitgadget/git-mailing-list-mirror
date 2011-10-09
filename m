From: Jon Forrest <nobozo@gmail.com>
Subject: Re: A Basic Git Question About File Tracking
Date: Sat, 08 Oct 2011 17:08:44 -0700
Message-ID: <4E90E60C.7060105@gmail.com>
References: <j6dlhf$dp3$1@dough.gmane.org> <20111004011035.GA13836@elie> <4E8A5DF0.6040003@gmail.com> <20111004012244.GB13836@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 09 02:11:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCgyt-0006V3-VS
	for gcvg-git-2@lo.gmane.org; Sun, 09 Oct 2011 02:11:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112Ab1JIAK6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Oct 2011 20:10:58 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36708 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840Ab1JIAK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Oct 2011 20:10:58 -0400
Received: by iakk32 with SMTP id k32so5783381iak.19
        for <git@vger.kernel.org>; Sat, 08 Oct 2011 17:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=XCOmHmtUkHGSeEGGAigRa0GQgQ9gfd5EVDQ6y3fvjV4=;
        b=o2gbPVfnTYXP2HCFg+aGjtPkqBtxz0g17UzwsbZwfwlJ02oitJWPkZhDo/EHYM3cPu
         gL1ThGfBdqGGEEZ1EDKkEu7o+0ZiwFQaLN/xLVxQVRhu5Z3wHatY/cL6Tn68lsqusxDX
         egy+eJd+v0DvPJOW8bafHB+igibbEFVDDv4bY=
Received: by 10.68.36.106 with SMTP id p10mr25130662pbj.66.1318119057266;
        Sat, 08 Oct 2011 17:10:57 -0700 (PDT)
Received: from [192.168.0.107] (c-98-248-228-38.hsd1.ca.comcast.net. [98.248.228.38])
        by mx.google.com with ESMTPS id ji3sm48743210pbc.2.2011.10.08.17.10.55
        (version=SSLv3 cipher=OTHER);
        Sat, 08 Oct 2011 17:10:56 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20111004012244.GB13836@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183179>

On 10/3/2011 6:22 PM, Jonathan Nieder wrote:

[I'm just getting back to this question. I had accidentally
sent this follow up directly to Jonathan but I want to
continue this on the email list.]

> Yes, "x" is tracked.  Moreover, "x" is in the index.  You can
> list files in the index with the "git ls-files -s" command.

This spoils my understanding of what the index
is. I had been thinking that after you add files
to the index, and then commit, the index is then
empty. In other words, whatever's in the index
gets committed, and then the index is cleaned.

On the other hand, if the definition of a tracked
file is a file that's in the index, then this definitely
clears up my understanding of tracked files.

If every file that's 'git add'ed stays in the
index, how does git know which files to commit?

I can't prove it but I suspect that many git beginners
also are confused by this.

Thanks for your replies.

Jon Forrest
