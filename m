From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: What should be the CRLF policy when win + Linux?
Date: Wed, 5 May 2010 15:27:58 +0200
Message-ID: <t2wf3271551005050627jbe328d84q23a85a1e5dced082@mail.gmail.com>
References: <4BE141E3.2060904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: mat <matthieu.stigler@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 05 15:28:27 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9eeJ-00051P-4Q
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 15:28:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759061Ab0EEN2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 May 2010 09:28:20 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:51469 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755191Ab0EEN2T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 09:28:19 -0400
Received: by pva18 with SMTP id 18so454621pva.19
        for <git@vger.kernel.org>; Wed, 05 May 2010 06:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=kiPM/UTO7JDrecJ5yb/0khdOBJPPYOBRU2IaXh6Mpnw=;
        b=SypESoQ+5x4oGM2+LnzV15L1nPNrzIrcLpaU/UB4Y4DIpj0Jrl271dNL66b77cHsvc
         9xAc5uBSs2ZE4xJf6KztYyVSXLlo8bVYyWIYqn5FnR5/o3QMs1Zc824dJhGWJKkR/3Yc
         SDIZYlEIf8zg03brUZSJFs1MtrX7jp53p16ow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=gzQvwtfimo7rkX86cF/ceh8w+BQoiZ3tCFZc1uSgmpzNtrwXVF3JGrZxgDwS9kOUQ7
         DNr93APFAQy2kVvMk5q19Cyjvn29P35qIRinBxOn5HXvq7wJOumQiEt8kzBnd4hvWYn7
         gVIsa3ZSMwDUc7TOrcOmWB+AIP9YEKz5f0Is8=
Received: by 10.142.207.11 with SMTP id e11mr5497993wfg.93.1273066098299; Wed, 
	05 May 2010 06:28:18 -0700 (PDT)
Received: by 10.142.254.21 with HTTP; Wed, 5 May 2010 06:27:58 -0700 (PDT)
In-Reply-To: <4BE141E3.2060904@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146392>

Hi,

On Wed, May 5, 2010 at 12:01 PM, mat <matthieu.stigler@gmail.com> wrote:
> So I don't know exactly what I should do...Should I change all the CRLF from
> project A, but people will have also problems, or can I switch the config,
> once I'm using project A and B? It is not so clear in my mind and I would
> appreciate any advice!!

I'm not sure what you should be doing because I've never worked with
Windows, but the following information might be useful: Yes, you can
have project-specific config quite easily.

In the command
> git config --global core.autocrlf true
just drop `--global` and the setting becomes repository-specific.

-- Ram
