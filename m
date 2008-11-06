From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: How to rebase for git svn?
Date: Thu, 6 Nov 2008 11:15:21 +0100
Message-ID: <bd6139dc0811060215j1ad7ee0ahd0b568283da06cb@mail.gmail.com>
References: <4911EF4C.8030703@gmail.com> <20081106095500.GA9587@untitled>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Yang Zhang" <yanghatespam@gmail.com>, git@vger.kernel.org
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Nov 06 11:17:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ky1vH-00083E-FB
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 11:17:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754201AbYKFKP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2008 05:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753311AbYKFKP3
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 05:15:29 -0500
Received: from fk-out-0910.google.com ([209.85.128.185]:22951 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754031AbYKFKPX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 05:15:23 -0500
Received: by fk-out-0910.google.com with SMTP id 18so551345fkq.5
        for <git@vger.kernel.org>; Thu, 06 Nov 2008 02:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=VVzb7GGljHfSDSlJdIUGixApH1aSNqtJLKV7mSaobV4=;
        b=rPLdzjhtt6go4lrKKl00kO87G0v3HfDJGLSbq8+CxAQkjStPzwu+9Tu9eDovTOuXxK
         fItTOb9d1YpTVGakmoHlMW5JnPW1CrnsHkgnK7qrOLvaBYKuvoVoSk5hiVJ7ll55tuk8
         q7eOlWG9bZU8eHI7IlssrfukxDX06L7Q7vRwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=O7IBfoodfUd+rJo2ERZpbh1dmCvQvA0FsiHJ0IaqmK6ztxAtNZfhmjkY1Yi9R3fIdL
         dgAyhhIAO80ifcolOPlUFV8K+ZR/ojnICjR1fZYxrtzPAjRS6bqSYhleTVf15RlmkQaZ
         YMrTfeDcPPQ3co81MmhE9jlJAnAYhOl/HSTUU=
Received: by 10.187.159.15 with SMTP id l15mr411542fao.57.1225966521740;
        Thu, 06 Nov 2008 02:15:21 -0800 (PST)
Received: by 10.187.213.8 with HTTP; Thu, 6 Nov 2008 02:15:21 -0800 (PST)
In-Reply-To: <20081106095500.GA9587@untitled>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100225>

On Thu, Nov 6, 2008 at 10:55, Eric Wong <normalperson@yhbt.net> wrote:
> Yang Zhang <yanghatespam@gmail.com> wrote:
>> Thanks in advance for any help!
>
> Try passing --rebase or --squash with "git pull" to keep history linear
> for SVN.

Consider doing the following:
git config alias.repull "pull --rebase"
And then using 'git repull' instead of 'git pull'.

-- 
Cheers,

Sverre Rabbelier
