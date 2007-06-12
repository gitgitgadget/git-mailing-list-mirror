From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Problem with a push
Date: Wed, 13 Jun 2007 11:38:30 +1200
Message-ID: <46a038f90706121638l2bcc613fue6446750d2db651f@mail.gmail.com>
References: <Pine.LNX.4.64.0706111632050.4406@www.mintpixels.com>
	 <alpine.LFD.0.98.0706111556160.14121@woody.linux-foundation.org>
	 <200706121007.17044.andyparkins@gmail.com>
	 <alpine.LFD.0.98.0706120800430.14121@woody.linux-foundation.org>
	 <7vk5u9hzv9.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Andy Parkins" <andyparkins@gmail.com>, git@vger.kernel.org,
	plexq@plexq.com
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 01:38:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyFwb-0003R5-NA
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 01:38:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755399AbXFLXig (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 19:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755339AbXFLXif
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 19:38:35 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:9621 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755198AbXFLXie (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 19:38:34 -0400
Received: by wx-out-0506.google.com with SMTP id t15so19109wxc
        for <git@vger.kernel.org>; Tue, 12 Jun 2007 16:38:30 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=egCAtytjLytELw/EE+2KEO9LOFglDKvJSep8cOb9l/qSNgB9yXwgUorDsG4gW6fjT40bcIO8C6J7sKJvCP+cstHDPc20WWEtsK0lvlqTpcNjJ/lxPg81Fod5ojduaZrHsZM8No9fXTudwSqFhH2D2bkM0aZW7VxUOugmx55PAOU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LUiUMli8/YZbK5pVvu9IS0o/GhupHH76QORYyr9cJZsFXqnG971Tun8uXMYgUYJHRoEbylmO1HlTTdkrk1m1QmbL1a3bWpYoPEzgX/CRgxbVpx2d8QH2QaxAaV415dxB+uhGPI51eSw94n2eOqkSDZGW9NOfHh03zhvaYvNs2EU=
Received: by 10.90.81.14 with SMTP id e14mr4780agb.1181691510819;
        Tue, 12 Jun 2007 16:38:30 -0700 (PDT)
Received: by 10.90.52.9 with HTTP; Tue, 12 Jun 2007 16:38:30 -0700 (PDT)
In-Reply-To: <7vk5u9hzv9.fsf@assigned-by-dhcp.pobox.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50007>

On 6/13/07, Junio C Hamano <gitster@pobox.com> wrote:
>  - When doing 'matching refs', do it only under refs/heads/.

Yes please ;-)

We've had this conversation about 2 weeks ago -- it's confusing (and
worrying) to see that a git-push tries to push stuff from remotes/ to
the repo...

cheers,

martin
