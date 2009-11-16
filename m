From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: Git graph with branch labels for all paths in text environment
Date: Mon, 16 Nov 2009 13:23:10 +0100
Message-ID: <adf1fd3d0911160423q4e21126dm37be7838f0ce8379@mail.gmail.com>
References: <1258373038892-4011651.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: rhlee <richard@webdezign.co.uk>
X-From: git-owner@vger.kernel.org Mon Nov 16 13:23:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NA0c7-0004WW-PG
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 13:23:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753549AbZKPMXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 07:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752989AbZKPMXI
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 07:23:08 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:12328 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753335AbZKPMXG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 07:23:06 -0500
Received: by ey-out-2122.google.com with SMTP id 9so1940452eyd.19
        for <git@vger.kernel.org>; Mon, 16 Nov 2009 04:23:11 -0800 (PST)
Received: by 10.213.100.11 with SMTP id w11mr1367107ebn.34.1258374190889; Mon, 
	16 Nov 2009 04:23:10 -0800 (PST)
In-Reply-To: <1258373038892-4011651.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133006>

On Mon, Nov 16, 2009 at 1:03 PM, rhlee <richard@webdezign.co.uk> wrote:
>
> Hi git forum,
>
> Is there anyway to to view a text based git grah that shows all paths with
> the branch labels? Like a on gitk but ncurses based?

For third-party tools you can check:

http://git-scm.com/tools

>
> I can get all paths in git log --graph, but I can't get the branch labels.

Have you tried  --decorate?

I have an alias for this:

alias.logk = log --graph --pretty=oneline --abbrev-commit --decorate

HTH,
Santi
