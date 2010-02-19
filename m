From: Gabriel Filion <lelutin@gmail.com>
Subject: Re: RFD: git-bzr: anyone interested?
Date: Fri, 19 Feb 2010 02:05:58 -0500
Message-ID: <4B7E3856.3080609@gmail.com>
References: <4B7D8358.1080108@gmail.com> <fabb9a1e1002181037n58d6942dpa63a57a23f506d9c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 19 08:06:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiMwL-00021R-8n
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 08:06:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753788Ab0BSHGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 02:06:12 -0500
Received: from mail-qy0-f202.google.com ([209.85.221.202]:61084 "EHLO
	mail-qy0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753356Ab0BSHGL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 02:06:11 -0500
Received: by qyk40 with SMTP id 40so558816qyk.24
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 23:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=MKmKKJNOAFmf2/MV6lku10HW+UJ6uIiXSz7yN8t0ZuE=;
        b=xDofFh5Nv1sLkEcILlVfHoCjDtdKIAH9MKR6Llqb3zq2xGIsXoSVLcmbH+aOsyDluB
         gvHKkuiHXVyTCyaSIF0OZe1dlqRMkPPnuRQ5pZ8dPDFNquiZbPJ9Ff0VfMPmuJsa4HJb
         96ckmmxgv1od+kvFBXgyrvb70OhGPq/wa1b4M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        b=nWPVIL/13CINYCn63Puf4JVRoSQ/DnKs6zIeskSaX0bCsNsfz/iOQ+WhM6eY87aVnO
         r3g7+nkpPeZ1kmjOkrPap9TCWUvgKzuF2aHYWXIgADK+591DEyQ2VbSaPEDEpJU17h49
         QuQF+ZPPOo0ZJyQL6yP8la5hJo6zbhAb0y7Tw=
Received: by 10.224.63.41 with SMTP id z41mr3096526qah.294.1266563170128;
        Thu, 18 Feb 2010 23:06:10 -0800 (PST)
Received: from ?192.168.2.202? (dsl-152-38.aei.ca [66.36.152.38])
        by mx.google.com with ESMTPS id 21sm7292285qyk.0.2010.02.18.23.06.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Feb 2010 23:06:08 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.5) Gecko/20100108 Lightning/1.0b1 Icedove/3.0
In-Reply-To: <fabb9a1e1002181037n58d6942dpa63a57a23f506d9c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140419>

On 2010-02-18 13:37, Sverre Rabbelier wrote:
> By implementing a
> remote helper people can just clone a bzr url, and work with it in the
> exact same way that they would interact with a regular git repository.

This sounds great, it's exactly what I'm hoping to achieve with this
project.

> If you're interested have a look at
> Documentation/git-remote-helpers.txt, and read the mailing list
> archives on the subject.
> 

The Documentation/git-remote-helpers.txt file wasn't really of much help
.. It really only barely scratches the subject, but it does not mention
how remote-helpers really work internally (e.g. how do they get called:
based on protocol used in URLs?)

I'm still trying to dig up information about how to actually build, test
and use a remote helper. I'll probably be reading code for examples.

Another detail hit me: external interaction in git seems like it's
almost always using librairies. If I'm not mistaken, bzr does not have a
separate library. So to have access to it's API, you need bzr to be
installed. This is why the current git-bzr script is using bzr +
bzr-fastimport plugin to do the job.
Is it normal / acceptable for a remote helper to have such dependancies?

And for the language used, maybe python could be logical if I can bind
directly to Bazaar's API. Tell me what you think about this.

-- 
Gabriel Filion
