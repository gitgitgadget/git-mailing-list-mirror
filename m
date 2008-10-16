From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: Untracked working tree files
Date: Thu, 16 Oct 2008 10:42:13 +0200
Message-ID: <4d8e3fd30810160142x36860354ka30375e3d21438ae@mail.gmail.com>
References: <20081015115654.fb34438f.akpm@linux-foundation.org>
	 <alpine.DEB.1.10.0810151208100.7808@asgard.lang.hm>
	 <alpine.DEB.1.10.0810151211580.7808@asgard.lang.hm>
	 <alpine.LFD.2.00.0810151219120.3288@nehalem.linux-foundation.org>
	 <20081015124949.b657a8db.akpm@linux-foundation.org>
	 <alpine.LFD.2.00.0810151256410.3288@nehalem.linux-foundation.org>
	 <20081015132309.76d3cc28.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>, david@lang.hm,
	git@vger.kernel.org
To: "Andrew Morton" <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Oct 16 10:43:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqOS9-0007vy-A8
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 10:43:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753608AbYJPImQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 04:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753556AbYJPImP
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 04:42:15 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:27197 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753423AbYJPImP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 04:42:15 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3062798wfd.4
        for <git@vger.kernel.org>; Thu, 16 Oct 2008 01:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=mD+AO2PGlZXqstZfRoy97iLbRTcGvKnw8NbIelAxvu0=;
        b=wDlZQLumtLYI152cKbRLKblJO5D0zmrTO+/DcLxUHC2onxWp30uwEzPZerUBTEL3p1
         gJeOWjFGc3d6l/9Og5VhJ42aGfc0qj6y0EWIdmBcXh4Z9R4pJunPynn3qXqKtyjMwkdO
         0gcD6b2TQMdWM3uWl6AI+itlwdqeE/DtoPZ58=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Xlsc8RlmEK6lyVjjNggYLEpKJhGKTgH9finMiR/uG7ISPNfgec7s7Tr+HR2PSgiSWe
         //U2w0Cc6la3gu9eB2jzmphcIJMs7V9c+1dKaPtQK/gpXC0KgonXkouYryrFUU7EpzIW
         6HRKWd0DWH+OK+vcoed3DljUfuiV4C6IDbn8I=
Received: by 10.143.12.19 with SMTP id p19mr717261wfi.171.1224146533659;
        Thu, 16 Oct 2008 01:42:13 -0700 (PDT)
Received: by 10.142.180.6 with HTTP; Thu, 16 Oct 2008 01:42:13 -0700 (PDT)
In-Reply-To: <20081015132309.76d3cc28.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98352>

On Wed, Oct 15, 2008 at 10:23 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Wed, 15 Oct 2008 13:08:36 -0700 (PDT)
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>> On Wed, 15 Oct 2008, Andrew Morton wrote:
[...]
>> Is "git checkout -f" part of the scripting? Or "git reset --hard"?
>
> well, this script has been hacked on so many times I'm not sure what
> it does any more.
>
> Presently the main generate-a-diff function is
>

Hi Andrew,
I was wondering whether you could share the scripts you built on top of git,
you might get some useful suggestions from this list and they could be
inspiration for further improvement in GIT (it just happened with this
thread ;-)

Thanks.

Ciao,
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
