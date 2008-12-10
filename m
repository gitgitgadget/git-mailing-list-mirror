From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <santi@agolina.net>
Subject: Re: Unneeded branch history
Date: Wed, 10 Dec 2008 13:43:09 +0100
Message-ID: <adf1fd3d0812100443v23c539d6q66049af911c90d49@mail.gmail.com>
References: <50628.127.0.0.1.1228907607.squirrel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Luca Siciliano Viglieri" <Luca.Siciliano@bittwister.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 13:44:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAOQY-0007tO-U9
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 13:44:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbYLJMnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 07:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbYLJMnN
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 07:43:13 -0500
Received: from fk-out-0910.google.com ([209.85.128.190]:20027 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961AbYLJMnN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 07:43:13 -0500
Received: by fk-out-0910.google.com with SMTP id 18so239948fkq.5
        for <git@vger.kernel.org>; Wed, 10 Dec 2008 04:43:10 -0800 (PST)
Received: by 10.103.217.5 with SMTP id u5mr484439muq.118.1228912989541;
        Wed, 10 Dec 2008 04:43:09 -0800 (PST)
Received: by 10.103.167.6 with HTTP; Wed, 10 Dec 2008 04:43:09 -0800 (PST)
In-Reply-To: <50628.127.0.0.1.1228907607.squirrel@localhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102683>

2008/12/10 Luca Siciliano Viglieri <Luca.Siciliano@bittwister.com>:
> Hi,
> i have tried to find a solution to my problem, but i couldn't find
> anything on the documentation.
> I have created from master branch a development branch. I keep the master
> branch regularly uptodate from the server and in the development branch i
> commit my code. When i merge the two branches i obtain a commit with two
> parents and when i push my master branch to the server, all my development
> history it is also saved in the server.
> Can i avoid saving my develoment history, at least on the server, so that
> the master branch has only one parent commits?

$ git merge --squash

or

$ git rebase -i master

and squash/edit/... some of the revisions (this way you can have the
interesting development history)

HTH,
Santi
