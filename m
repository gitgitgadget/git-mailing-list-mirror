From: "Peter Harris" <git@peter.is-a-geek.org>
Subject: Re: How do I..?
Date: Wed, 17 Dec 2008 18:44:41 -0500
Message-ID: <eaa105840812171544i53e8a751s70ad495bb6a86160@mail.gmail.com>
References: <e1a4c7f60812171516h7b7bb1fem35dfc6f30747a740@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Dylan Martin" <dmartin@sccd.ctc.edu>
X-From: git-owner@vger.kernel.org Thu Dec 18 00:46:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD65Z-0005rv-7g
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 00:46:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971AbYLQXon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 18:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751991AbYLQXon
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 18:44:43 -0500
Received: from an-out-0708.google.com ([209.85.132.240]:39312 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961AbYLQXon (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 18:44:43 -0500
Received: by an-out-0708.google.com with SMTP id d40so67068and.1
        for <git@vger.kernel.org>; Wed, 17 Dec 2008 15:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=JdIWDyR3MP/bS5vbvE7Uu2JoZK9+3o4OKfzlPeB41Xw=;
        b=wKwc+9SsyM0LgSnEc6mvQ+HJKE40qbtkcnim31WY58h1hSN9nHd/g5XZYwwBhpTN69
         jT5VC/jMDyaIXcy07kL0+OGv3vMB20xYCz+h2yB0hcO3zpwQm2DM+IpAqIJwxNeqkjGF
         W0wj515OBsEDKGXXx6zmciK3s1hlPnGi50VNo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=TwhXLpyZTQelShd32ZDVjOT8QLnzhQudE9bF4pdOAX6vFEILdgXwELZf2PZWrhTxSo
         AJFLI9MtjQokN8oDzNRu4/D2Ma+/HkofF9Snbx7bjVzFbFupqmS/dny96Q9KP1qhOKrI
         6ojD2bUH5nN0iixPunAedyGf3vEDwwaTAZU8Q=
Received: by 10.65.137.5 with SMTP id p5mr1026973qbn.7.1229557481369;
        Wed, 17 Dec 2008 15:44:41 -0800 (PST)
Received: by 10.65.230.19 with HTTP; Wed, 17 Dec 2008 15:44:41 -0800 (PST)
In-Reply-To: <e1a4c7f60812171516h7b7bb1fem35dfc6f30747a740@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: be08f3397c0e983a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103413>

On Wed, Dec 17, 2008 at 6:16 PM, Dylan Martin wrote:
> Before I switched to git, I played around with SVN a bit, and started
> a few tiny SVN repos for various scripts I was working on.  So, I know
> have one git repo with %90 of my stuff and a handful of SVN repos.
> I'd like to be able to add the SVN repos as subdirectories inside my
> git repo.  I've found lots of pages describing how to convert an SVN
> repo into a _new_ git repo, but I haven't found anything yet about
> importing the contents of an SVN repo as a subdirectory of an
> _existing_ git repo.

You could convert each SVN repo into its own temporary git repo, then
use the subtree merge strategy to combine the git trees:
http://www.kernel.org/pub/software/scm/git/docs/howto/using-merge-subtree.html

Peter Harris
