From: "Anatoly Yakovenko" <aeyakovenko@gmail.com>
Subject: Re: cant get git to work over http
Date: Tue, 19 Feb 2008 14:13:30 -0800
Message-ID: <e26d18e40802191413w48fe4a71hd7895b09d15cb44e@mail.gmail.com>
References: <e26d18e40802181649l3c03df82l4eb91c88bec47bf4@mail.gmail.com>
	 <e26d18e40802191106v51c907bdn6aa51acef5f530a3@mail.gmail.com>
	 <alpine.LSU.1.00.0802191916020.7797@racer.site>
	 <e26d18e40802191127v7cc9f051l7002b56b41dc9f86@mail.gmail.com>
	 <alpine.LSU.1.00.0802191940260.7826@racer.site>
	 <e26d18e40802191153w691ac5fcl3fa972ca6503b9fb@mail.gmail.com>
	 <47BB3691.9040809@freescale.com>
	 <e26d18e40802191305y5f7b8fdfr3113c84612c53189@mail.gmail.com>
	 <47BB5037.5090302@freescale.com>
	 <e26d18e40802191359r4c435818n4ae7b357d452d51e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Mike Hommey" <mh@glandium.org>, git@vger.kernel.org
To: "Jon Loeliger" <jdl@freescale.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 23:14:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRaj0-0005Rw-SG
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 23:14:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754749AbYBSWNc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 17:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754719AbYBSWNc
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 17:13:32 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:6295 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754683AbYBSWNb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 17:13:31 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3712862wah.23
        for <git@vger.kernel.org>; Tue, 19 Feb 2008 14:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=YjM8ppbONc4KrL5/uXqjgp1c5BhMO24kSYl75iq+sQE=;
        b=fvw+3kIQ/9BcZ9suFMV+FWvrqNWOGHQov6ace2MCKGox9QZTDjanAbaL1QXGsy5VPbUrMf9OnwbbPxuqSZSMlsaFvOf9+kBCMs/cq5j1XDooTStHzOAqfPZ7TrD/sZCVqFoF+VyW8rmtSjxGaAcHPzB627GHHELzmKUyPp8GtPI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lB4csjpwURrGls4iHrf0nw76CkSgYKTi+mmu2DImWyxRq2bSLcMg36LgI6gMDmXYFoFf8h2oWDMaK8u7Jt60BigNZJev/Afu0vjkyftBstZJTwyLjY3baOTdDu585cIDVps+qY+7ChoGHM+A0klQBsbm+0SJBEQyyEppcrbRgSA=
Received: by 10.114.183.1 with SMTP id g1mr102927waf.3.1203459210692;
        Tue, 19 Feb 2008 14:13:30 -0800 (PST)
Received: by 10.114.167.5 with HTTP; Tue, 19 Feb 2008 14:13:30 -0800 (PST)
In-Reply-To: <e26d18e40802191359r4c435818n4ae7b357d452d51e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74467>

On Feb 19, 2008 1:59 PM, Anatoly Yakovenko <aeyakovenko@gmail.com> wrote:
> > Something is fishy here.  Is your repository bare or not?
>
> no, why does it need to be bare?
>
so bare or not ssh works but http doesnt:

$ git-clone ssh://aeyakovenko@localhost/var/www/localhost/htdocs/git/bare
bare-ssh
Initialized empty Git repository in /home/aeyakovenko/projects/bare-ssh/.git/
Receiving objects: 100% (3/3), done.
remote: Counting objects: 3, done.
remote: Total 3 (delta 0), reused 0 (delta 0)



and running over a bare directory doesn't work:


$ git-clone http://aeyakovenko@localhost/git/bare bare
Initialized empty Git repository in /home/aeyakovenko/projects/bare/.git/
Cannot get remote repository information.
Perhaps git-update-server-info needs to be run there?

apache acess log:

127.0.0.1 - - [19/Feb/2008:14:10:19 -0800] "GET /git/bare/info/refs
HTTP/1.1" 401 460

i feel like i am taking crazy pills, why is apache looking for
/git/bare/info/refs, and no the directory from the doc root?
