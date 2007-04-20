From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 20 Apr 2007 13:58:12 +0200
Message-ID: <81b0412b0704200458n33c1eb83p540b738e7ff26ec9@mail.gmail.com>
References: <7vodly0xn7.fsf@assigned-by-dhcp.cox.net>
	 <7vr6qlxexe.fsf@assigned-by-dhcp.cox.net>
	 <7v647tcjr6.fsf@assigned-by-dhcp.cox.net>
	 <20070419100757.GB27208@admingilde.org>
	 <7vmz13z4au.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Martin Waitz" <tali@admingilde.org>, git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 20 13:58:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Herkp-0004ZJ-V7
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 13:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767051AbXDTL6R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 07:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766581AbXDTL6R
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 07:58:17 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:50654 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767051AbXDTL6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 07:58:16 -0400
Received: by an-out-0708.google.com with SMTP id b33so895451ana
        for <git@vger.kernel.org>; Fri, 20 Apr 2007 04:58:15 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Z3YYC+W/2DnMF3hgF6JY581iY+qXLyf56ceKtwCojcWyg3/KViQaHwYyBWBMVDiWyD7ubeTY+8XIe8h0gmMEQV6wylzzTqBSY0Wy3cmzhvf5a1Eug20GUFKVwyBSjwGMahSnUtGpjoqlMVOvj0IKuAusu+Bjy0TT3MP9fWZOJvI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EXppiF6MkFRAJ1JNSgav8KFzSpi/Hg60NSIJxpEsLtNAdBPRGFnCmsC1HlHKtUK8pvGOeQLlBqtaEyYa7c4FBrrHqksbL7wrQ3wGQ+gFuyXefy5cHfMQ84QlXlncvzJVkxGgWZgJjldgW31jfRuzTO3n4ytxFdatCM28ffTo20s=
Received: by 10.100.153.17 with SMTP id a17mr1644235ane.1177070292351;
        Fri, 20 Apr 2007 04:58:12 -0700 (PDT)
Received: by 10.100.225.3 with HTTP; Fri, 20 Apr 2007 04:58:12 -0700 (PDT)
In-Reply-To: <7vmz13z4au.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45095>

On 4/20/07, Junio C Hamano <junkio@cox.net> wrote:
> Making git.git the first guinea pig has a unique bootstrapping
> problem involved, however.  These kind of changes in git.git
> itself has to wait at least until what we have in 'next' today
> is in everybody's hands.

Have you any plans as to when that should begin to happen?
We can warn user if he tries to add a subproject until
porcelain support can be considered usable. It certainly
wont be a problem for early adopters, they know what they're
doing, and an accidental git add of a directory (which by accident
is a git repo all by itself) does not go unnoticed.
Or even disallow it by default (unset dir_struct:dir_links), and
give git add/update-index an option to allow them. We can
reconsider the default later.
