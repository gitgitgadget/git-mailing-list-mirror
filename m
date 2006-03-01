From: "Emmanuel Guerin" <emmanuel@guerin.fr.eu.org>
Subject: Re: Quick question: end of lines
Date: Wed, 1 Mar 2006 01:12:36 +0100
Message-ID: <f898cca90602281612n777a4f17m@mail.gmail.com>
References: <f898cca90602281032n6603bf14q@mail.gmail.com>
	 <46a038f90602281215n259066b1qe2e6421625b82e75@mail.gmail.com>
Reply-To: "Emmanuel Guerin" <emmanuel@guerin.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Mar 01 01:14:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEExO-0007NB-AN
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 01:12:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932612AbWCAAMh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Feb 2006 19:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932729AbWCAAMh
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Feb 2006 19:12:37 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:53902 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932612AbWCAAMg convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2006 19:12:36 -0500
Received: by wproxy.gmail.com with SMTP id i22so5417wra
        for <git@vger.kernel.org>; Tue, 28 Feb 2006 16:12:36 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WZqkgGpNSnDEMIwA0Y4vyVhmp/ycz6gP6iZI5NTxyDA4xdP30JJ814Z2m3eC90fjD6KHoY1Cq+WBL+cwVTgqdQ50FNi4nxkNNy1oHakPvLDuH1yLjdoH6N+VQx1BbXNhyYXWdlcau1D/XEoTR3V+UE1GECPJrvjsq2RTO0IC7R4=
Received: by 10.54.84.9 with SMTP id h9mr1285470wrb;
        Tue, 28 Feb 2006 16:12:36 -0800 (PST)
Received: by 10.54.70.4 with HTTP; Tue, 28 Feb 2006 16:12:36 -0800 (PST)
To: git@vger.kernel.org
In-Reply-To: <46a038f90602281215n259066b1qe2e6421625b82e75@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16960>

2006/3/1, Martin Langhoff <martin.langhoff@gmail.com>:
> Why is this important?
>
> (I am thinking: any reasonably good text editor will know how to deal
> with unix newlines, but you may have different reasons).

Actually, you have found the problem. My particular setup is that
Visual Studio is used on Windows. The editor will handle unix end of
lines all right, but tends to insert windows ones when modifications
are made. This leads to files with inconsistent end of lines, and
nightmares with merges. We use Subversion for the moment, and we have
to make sure that all text files are declared properly in svn to avoid
conflicts.

What I begin to realize is that the only possibility probably lies in
using a tool that converts the modified files "on the fly" before
commits. I just want to make sure that no other solution was found by
others facing a similar problem.

Anyway, thanks for the answers,

Emmanuel
