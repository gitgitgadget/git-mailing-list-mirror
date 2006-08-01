From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Diff format in packs
Date: Tue, 1 Aug 2006 12:47:00 +1200
Message-ID: <46a038f90607311747j947c786s6af2fe637dbde89d@mail.gmail.com>
References: <9e4733910607311408i10e17dse776920de7c5076a@mail.gmail.com>
	 <ealruh$sq9$1@sea.gmane.org>
	 <9e4733910607311420n8537b76lbde4d60062195403@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 01 02:47:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7iPw-000331-Eh
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 02:47:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbWHAArD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 20:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWHAArD
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 20:47:03 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:23435 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751086AbWHAArC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jul 2006 20:47:02 -0400
Received: by nf-out-0910.google.com with SMTP id x30so80125nfb
        for <git@vger.kernel.org>; Mon, 31 Jul 2006 17:47:00 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UsQicUXqwZHME/ywQN8WLBob8CryY/uz8sZUJpMDd4ogV3D54qvkGmhjpZoQFggLdOHUaUVJknb2l/wiNcXJH5uB/9n41uUKxZsvAM10thJde1rjx/pjrGpBtWMwsRJfY1kKeiZ1HnXSmDQTwGtwD9Gj3zMiltx0Pci68NymhpI=
Received: by 10.78.158.11 with SMTP id g11mr92939hue;
        Mon, 31 Jul 2006 17:47:00 -0700 (PDT)
Received: by 10.78.120.17 with HTTP; Mon, 31 Jul 2006 17:47:00 -0700 (PDT)
To: "Jon Smirl" <jonsmirl@gmail.com>
In-Reply-To: <9e4733910607311420n8537b76lbde4d60062195403@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24558>

Jon,

just get all the file versions out of the ,v file and into the GIT
repo, then do find .git/objects/ -type f | git-pack-objects. You don't
have to even think of generating the packfile yourself.

On 8/1/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> I am working on combining cvs2svn, parsecvs and cvsps into something
> that can handle Mozilla CVS.

If you publish your WIP somewhere, I might be able to jump in and help
a bit. I've seen your "challenge" email earlier, but haven't been able
to get started yet -- lots of work on other foss fronts.

cheers,


martin
