From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: Intricacies of submodules [was: Migrating svn to git with heavy use of externals]
Date: Fri, 11 Apr 2008 00:07:51 +0800
Message-ID: <46dff0320804100907w5240b79bga3acad9fb8ecb353@mail.gmail.com>
References: <47F15094.5050808@et.gatech.edu>
	 <32541b130804081306q6e06af20u794357eba9d434e@mail.gmail.com>
	 <47FBDA77.2050402@et.gatech.edu>
	 <32541b130804081401n743f39c9o3f016da9dee2eb92@mail.gmail.com>
	 <8FE3B7A7-4C2D-4202-A5FC-EBC4F4670273@sun.com>
	 <32541b130804082033q55c795b5ieaa4e120956ff030@mail.gmail.com>
	 <49E9DCEC-8A9E-4AD7-BA58-5A40F475F2EA@sun.com>
	 <32541b130804082334s604b62b0j82b510c331f48213@mail.gmail.com>
	 <7vhcebcyty.fsf@gitster.siamese.dyndns.org>
	 <6CFA8EC2-FEE0-4746-A4F6-45082734FEEC@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Avery Pennarun" <apenwarr@gmail.com>,
	stuart.freeman@et.gatech.edu, git@vger.kernel.org
To: "Roman Shaposhnik" <rvs@sun.com>
X-From: git-owner@vger.kernel.org Thu Apr 10 18:10:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjzKS-0004eT-8s
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 18:08:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756559AbYDJQHz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 12:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755413AbYDJQHz
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 12:07:55 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:6264 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756559AbYDJQHy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 12:07:54 -0400
Received: by an-out-0708.google.com with SMTP id d31so9230and.103
        for <git@vger.kernel.org>; Thu, 10 Apr 2008 09:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=baf+yZ5yffwZ2VxIIjxcJYC/KHFt0Rdwb9cN3VtQm1Q=;
        b=AyGia8iaKN7N4zZBz3XyHSJhwQ/N4vDsmEhIB5QyKX9pdIr7OK0m7u1CSe4zmZvR96IDxFPKfYfSYKEf55xYjxk7sQYqvD3fAyMwrmpyWv5QfoaSDNGGL5hxDQcq5wFRBGq5hhMNW7oOXzs0lyYpgP61yIue/dOZ1kK+Le1SwKU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ByBrFgHveFVksqVDhboErlHfFogrZD0zFgbVs0GDOomkVppPf6+oeyyDmp7/5Vbn+QaUFw5iPObUuPoY9EpMtfAfOtOcHbafQFqE3Du2SeT9IXsbsCSVqsSjQ2AWULNWFFGz1njQ5vSKiGPfjzuu5noA8QzKijCas8jH4mqKZ9M=
Received: by 10.100.105.15 with SMTP id d15mr3107835anc.32.1207843671976;
        Thu, 10 Apr 2008 09:07:51 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Thu, 10 Apr 2008 09:07:51 -0700 (PDT)
In-Reply-To: <6CFA8EC2-FEE0-4746-A4F6-45082734FEEC@sun.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79234>

On Thu, Apr 10, 2008 at 11:43 AM, Roman Shaposhnik <rvs@sun.com> wrote:
> Hi Junio!
>

>      * Has an idea of having a regular file (subject to having history,
> etc.)
>        called something like .gitconfig at the top level of Git's repository
> ever
>        been considered (implemented?). That way you a repository maintainer
>        would be able to force a particular set of settings on all of its
> clones
>        yet clones will be able to override then in .git/config if needed.
>

I like this idea, it's another common/special requirement just like
.gitignore vs. $GIT_DIR/info/exclude.



-- 
Ping Yin
