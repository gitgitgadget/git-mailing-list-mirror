From: John Tapsell <johnflux@gmail.com>
Subject: Re: Stepping through a single file's history
Date: Fri, 29 Jan 2010 01:58:56 +0000
Message-ID: <43d8ce651001281758x79965b5fn8760b69d4fe82a36@mail.gmail.com>
References: <5699F80A-4B27-4BAB-BEE8-5C48938A970B@flownet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Fri Jan 29 02:59:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nag8V-0004Tc-3p
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 02:59:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753560Ab0A2B66 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 20:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752917Ab0A2B65
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 20:58:57 -0500
Received: from mail-pz0-f189.google.com ([209.85.222.189]:44862 "EHLO
	mail-pz0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023Ab0A2B65 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 20:58:57 -0500
Received: by pzk27 with SMTP id 27so1082931pzk.33
        for <git@vger.kernel.org>; Thu, 28 Jan 2010 17:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:cc:content-type;
        bh=05r3GuBmFK23v0HCPNn/OGnqc/R70cN+ih/JxtmIG88=;
        b=R90KqOTpNWyfbYgvNddpmVBXJLVRwc0wJdjGzscOfPhGHsRQ0AC4lMBYQhW/Mxbox1
         qWmZM3xZLm68rJl6U/Ndasi/znB4nptRKPqooygVe8+y0X9grVIhJe/77Wvc68fmvcCD
         tT9XTo/BkhUYqhgXk5Pp9CC54mQGCfqOAutZI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:cc
         :content-type;
        b=UWQpa7NBKABhzpEU5jfd8gB0yLdnk97WOwVP9GD6FD2Z8xzdeTl2Tlx6zMwIvIsB6p
         vtFu1XsVeSkOsBkm+ldwet041bnQ8cfOnr+iL+tUjtkzOGPHk1xD6rLgg5KeRgoEqsd2
         LpxbnkdxnVw7eFms9cfmZoge33bRXKQjk2y1E=
Received: by 10.114.6.30 with SMTP id 30mr101833waf.143.1264730336972; Thu, 28 
	Jan 2010 17:58:56 -0800 (PST)
In-Reply-To: <5699F80A-4B27-4BAB-BEE8-5C48938A970B@flownet.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138293>

2010/1/29 Ron Garret <ron@flownet.com>:
> Hello,
>
> Is there an easy way to step through the history of a single file?  To be more specific:
...
> (The use case here is remembering that back in the day there was some useful code in this file that I want to retrieve, but not remembering exactly when it was deleted.  So I want to step back through this file's history and do diffs against HEAD.)

How about simply doing:

git log -p filename

and then you can search by pressing "/"  and then typing whatever you remember.

John
