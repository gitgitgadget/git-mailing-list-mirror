From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: Problem with add folder to a subdirectory
Date: Sun, 4 Apr 2010 11:26:15 +0800
Message-ID: <n2u41f08ee11004032026p9a0be36er7d2e017e294bbd35@mail.gmail.com>
References: <28125580.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Aris Bezas <igoumeninja@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 04 05:26:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyGTr-0003WW-NZ
	for gcvg-git-2@lo.gmane.org; Sun, 04 Apr 2010 05:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589Ab0DDD0S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Apr 2010 23:26:18 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:42453 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237Ab0DDD0R (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Apr 2010 23:26:17 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1060576qwh.37
        for <git@vger.kernel.org>; Sat, 03 Apr 2010 20:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type;
        bh=BfKD46LPbE767AuDdhxuagXg4+f+v1pLZUHZqYFkUOE=;
        b=npS6Eu5RANFuHlMOhsXeO6ZWgFIgpeQj9Sq61D2+5O66bCxzF5P1mDtpGIQUfCQ988
         Q160W2uBlVeZdJ+eyMr4NPUMCQYUcLojWx3NBaau6qvuEQMTjNkvY8NR4rZZVLUssXk9
         UJlNmwl94eVeyerTFwhBEb2JRTAz2UlKzN344=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=f2vGbiO/wVzKcpEIz3s90EGTeWwyBMbAEOtKmw4KrUPAJo12gIPalhAwIsqVDvMkou
         /7gvdYLSeaz49dzIMOGNnBqqp1nEl9+ugc1ea71DB5qrpwwN3iWsi6sg74ca9fgpRKGk
         GQ2HWum2WF/NAQm0oJ53eh1LlOXhlOamnKFCM=
Received: by 10.229.99.146 with HTTP; Sat, 3 Apr 2010 20:26:15 -0700 (PDT)
In-Reply-To: <28125580.post@talk.nabble.com>
Received: by 10.229.215.11 with SMTP id hc11mr6642226qcb.45.1270351575099; 
	Sat, 03 Apr 2010 20:26:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143912>

Hi Aris,
On Sat, Apr 3, 2010 at 4:26 PM, Aris Bezas <igoumeninja@gmail.com> wrote:
>
> Hi,
> I am new to git and i have a problem. I clone repo from a collaborator and i
> want to add some folder to a subdirectory.
> When i add a folder to the root dir ($ git add TestFolder) i have no problem
> but when i try to put it in a different subdirectory like ($ git add
> examples/TestFolder) then with the command ($ git status) i tsake no result
> (nothing to commit (working directory clean)).

Are you sure in the root directory, you can add an empty directory to
the index? I don't think so. See:
https://git.wiki.kernel.org/index.php/GitFaq#Can_I_add_empty_directories.3F

Regards!
Bo
