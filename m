From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: A system administration use case for git
Date: Wed, 22 Apr 2009 10:48:23 +0200
Message-ID: <46a038f90904220148i23f1a75n7036d9726870d5f5@mail.gmail.com>
References: <2cfc40320904220133l5ab567f3q46608793b93f0e1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 10:50:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwY9Y-0002it-EW
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 10:50:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752329AbZDVIs1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 04:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752127AbZDVIs0
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 04:48:26 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:64081 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842AbZDVIs0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 04:48:26 -0400
Received: by fxm2 with SMTP id 2so2969619fxm.37
        for <git@vger.kernel.org>; Wed, 22 Apr 2009 01:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IclFnvXLGLLyFBVgWF7DYsgzVCGvdhWoNLngCGZ98B4=;
        b=H/XFPUr4NzsMoVuCz1hvq07nyvlYviLhyEc4OBM9WdE+5o+iDqkPVusld/UNoyMwa0
         lt6uFXoq3eEBEpL6Cy6jSB7K7XT9DU08G1XabNqBSrxSNWLWN6h7uU2qGH+U+xUV0F0G
         gK4jW88FwKGBi4GCUGgA33rFa9PImleTamuvc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lMYowYIQ8ySnJ0JKO7co/9Vb/RIg3CVgUVK57abm4YPVipavLE6jxgqOqWxv7xhCCS
         gHO/DHU3dbEDDEsua+3OAVmuqAQtNIwNKuWS3BX1usAo85Zlner81y2/WfeLCCemnGRt
         4QJogBv0xth2zcT4lZJMXWB+Vc9LfdaWTeSk0=
Received: by 10.223.116.195 with SMTP id n3mr2403890faq.12.1240390103571; Wed, 
	22 Apr 2009 01:48:23 -0700 (PDT)
In-Reply-To: <2cfc40320904220133l5ab567f3q46608793b93f0e1f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117183>

On Wed, Apr 22, 2009 at 10:33 AM, Jon Seymour <jon.seymour@gmail.com> wrote:
> Hello all, it's been quite a while.
> It'd be nice to do this on arbitrary (non-git-controlled) file system tree:
>
> * calculate the git hashes of the tree (without making copies of the
> files in the tree)
> * archive the tree hashes
> * rsync the tree hashes to another place
> * work out which files aren't available in the other place's git repo
> * rsync those files the the other place

Steps:

1 - rsync to the "other place"
2 - use the git repo in that "other place"
3 - if the tree hashes are needed "here", copy them from the "other
place" git to here.

rsync + git = awesomenesssssss




-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
