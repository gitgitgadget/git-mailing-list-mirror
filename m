From: "Patrick Aljord" <patcito@gmail.com>
Subject: Re: executing git from a non git directory
Date: Sun, 22 Jul 2007 14:02:29 -0500
Message-ID: <6b6419750707221202t7a5cbafcs5d38ee7a10042247@mail.gmail.com>
References: <6b6419750707212355q48a934e4n3be0d6111694ad01@mail.gmail.com>
	 <20070722071136.GA346@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 22 21:02:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICghO-0007Wh-Mk
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 21:02:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759670AbXGVTCb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 15:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759610AbXGVTCb
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 15:02:31 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:1937 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759375AbXGVTCa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 15:02:30 -0400
Received: by py-out-1112.google.com with SMTP id d32so2910401pye
        for <git@vger.kernel.org>; Sun, 22 Jul 2007 12:02:29 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J4vmsjNlLX+dfVfzG/1UZRO/Tt38zADWOzQKkXTIjs1PYGGSY9XGY+3Ng8p3RTvvt9f6DFz48niPuIcsz5HoYkZgaho2fChaNG/Eks9Kk4Yu65OoqIRJCXqVcpSh059+R7DwcGpqUVU+8ot+Y/GZf2x2PR6owrB5W3xrCnCkNnY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oFB+oxlRzw6Ahsqg3KGp1YAx7RHt9YKjEvCMrMsNnDFUpO17VynB5c4DN72eZGl6oTY6ZvV89NXChvNgnc1NHOSf/8UuEd3BSncXmsbyH5Zl4Yobiamzrbwq3mN3RIqEx9/8ZFBCietzxdBaAVDGxWnnKpyFom1jkfLtFatXMxk=
Received: by 10.140.147.5 with SMTP id u5mr710808rvd.1185130949098;
        Sun, 22 Jul 2007 12:02:29 -0700 (PDT)
Received: by 10.141.18.11 with HTTP; Sun, 22 Jul 2007 12:02:29 -0700 (PDT)
In-Reply-To: <20070722071136.GA346@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53295>

ok thanx to both of you Jeff and Shawn for the info.

On 7/22/07, Jeff King <peff@peff.net> wrote:
>   git --work-tree=/path/to/my_git_dir --git-dir=/path/to/my_git_dir/.git status
>
> which is what you actually want.

ok, I'm going to try that, thanx.

Pat
