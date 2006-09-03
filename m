From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Mozilla version control requirements and git
Date: Mon, 4 Sep 2006 09:40:17 +1200
Message-ID: <46a038f90609031440s33e66499x51026aa6062566d2@mail.gmail.com>
References: <9e4733910609020731k25ce3a0aw7a84542f8cd516f6@mail.gmail.com>
	 <46a038f90609021819v6d427f0eh69bc13b30ef6b692@mail.gmail.com>
	 <9e4733910609022029q9cb9ba9m87cbc37e8d6f4ad7@mail.gmail.com>
	 <ede6in$b9u$1@sea.gmane.org>
	 <9e4733910609030646k6c722068m30f0e05fccc9c3c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 03 23:40:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJzhk-0006LA-EZ
	for gcvg-git@gmane.org; Sun, 03 Sep 2006 23:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWICVkU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Sep 2006 17:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbWICVkU
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Sep 2006 17:40:20 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:49509 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750718AbWICVkT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Sep 2006 17:40:19 -0400
Received: by nf-out-0910.google.com with SMTP id o25so936304nfa
        for <git@vger.kernel.org>; Sun, 03 Sep 2006 14:40:17 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gpfScjVDkiXz38Xgazv2uPuo+fk/PvSH81UpzYXz/gqlo9zl3Lx3M8XXZrQSUW5KsPbejGOC4pm43OClJ6UhwpxGdJsNmP1+aEus782JqqeoBg6MoKVEVj3Z1yxRd06x5a8w9Br9xQ0WoMWCyGZhprskHoiUxp4HdTU5JooFGkw=
Received: by 10.48.220.15 with SMTP id s15mr5937911nfg;
        Sun, 03 Sep 2006 14:40:17 -0700 (PDT)
Received: by 10.49.6.16 with HTTP; Sun, 3 Sep 2006 14:40:17 -0700 (PDT)
To: "Jon Smirl" <jonsmirl@gmail.com>
In-Reply-To: <9e4733910609030646k6c722068m30f0e05fccc9c3c5@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26382>

On 9/4/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> You can't really fake it. Many of the projects in Mozilla are
> dependent on each other. If you break them up into separate
> repositories you lose the ability to do a cross project commit. This
> is common when you are changing an interface between the subprojects.

In many projects this is handled by having tags and generally
versioning modules and interfaces. Being independent gives the
subprojects/modules a lot more freedom to work/branch on wild
tangents, and the versioned interfaces mean that -- with the
contraints of the versioned interfaces -- you can mix and match
branches/releases of the different subprojects.

In short, I'd definitely break those up :-)

cheers,




martin

-- 
VGER BF report: U 0.513231
