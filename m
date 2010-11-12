From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Incremental object transfer
Date: Fri, 12 Nov 2010 10:09:33 -0600
Message-ID: <20101112160933.GC15141@burratino>
References: <20101112103427.GA29057@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Enrico Weigelt <weigelt@metux.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 12 17:10:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGwCY-0004Ei-PA
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 17:10:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512Ab0KLQKD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 11:10:03 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45354 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753416Ab0KLQKB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 11:10:01 -0500
Received: by mail-fx0-f46.google.com with SMTP id 6so224328fxm.19
        for <git@vger.kernel.org>; Fri, 12 Nov 2010 08:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=KU3DlYg5Mv2KXFBBGa+ogbEHmdwmlLWQoOJSmm2V/74=;
        b=EK9XfZKcNcEM2I1aUeE4dN+W4rN2+3v3sBOyoKnJmS/kSFtIzPUNmAwdO9ugQvmL/M
         5jPsL5lcqq/nuzqbkr7031lRQHoVitt3eWwjYNIL1L62DEkrZoAU9JwUSbeb1vCxPP/d
         0AZpAX5ygysse5zjQgjn4Rck2XH89uNJm3qx0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=QRkSVt4FkLoEGDG/XKfvPJLJ622FtGBBICdEM+/mOKx/qvze12D2A/D+dzXo5My0PX
         hmMfZ/XXzzR/XNJ971Xl1EpknOK8Cz9szPXh5bUaW4Mwnpc5dMxhPLJH1dGO082xlpz8
         YdPEJDJQAs+5KLcYbXtKzwl/d/UWr4qdfeXPI=
Received: by 10.223.107.16 with SMTP id z16mr1670405fao.7.1289578200636;
        Fri, 12 Nov 2010 08:10:00 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id b20sm74599fab.35.2010.11.12.08.09.57
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 12 Nov 2010 08:09:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101112103427.GA29057@nibiru.local>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161350>

Enrico Weigelt wrote:

> as already said some time ago, I'm using git to back up maildirs
> on a machine w/ relatively low ram. The biggest problem for now
> is the initial push (maybe later larger subsequent pushes could
> be also affected too): it takes quite a long time to get everything
> packed, and if the connection breaks (the box is sitting behind
> a dynamic-IP DSL link), everything has to be restarted :(

Maybe use "git bundle" and then transfer by rsync?
