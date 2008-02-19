From: Jon Loeliger <jdl@freescale.com>
Subject: Re: cant get git to work over http
Date: Tue, 19 Feb 2008 15:55:03 -0600
Message-ID: <47BB5037.5090302@freescale.com>
References: <e26d18e40802181649l3c03df82l4eb91c88bec47bf4@mail.gmail.com>	 <alpine.LSU.1.00.0802191115440.30505@racer.site>	 <e26d18e40802191019j48a1ceadk4887ffc35100ab0a@mail.gmail.com>	 <47BB1EC0.601@freescale.com>	 <e26d18e40802191106v51c907bdn6aa51acef5f530a3@mail.gmail.com>	 <alpine.LSU.1.00.0802191916020.7797@racer.site>	 <e26d18e40802191127v7cc9f051l7002b56b41dc9f86@mail.gmail.com>	 <alpine.LSU.1.00.0802191940260.7826@racer.site>	 <e26d18e40802191153w691ac5fcl3fa972ca6503b9fb@mail.gmail.com>	 <47BB3691.9040809@freescale.com> <e26d18e40802191305y5f7b8fdfr3113c84612c53189@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Anatoly Yakovenko <aeyakovenko@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 22:56:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRaS1-0005te-Rb
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 22:56:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755577AbYBSVzj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 16:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755434AbYBSVzj
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 16:55:39 -0500
Received: from az33egw01.freescale.net ([192.88.158.102]:33212 "EHLO
	az33egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755449AbYBSVzi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 16:55:38 -0500
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id m1JLt4eh028132;
	Tue, 19 Feb 2008 14:55:05 -0700 (MST)
Received: from [10.214.72.212] (mvp-10-214-72-212.am.freescale.net [10.214.72.212])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m1JLt3gc024069;
	Tue, 19 Feb 2008 15:55:04 -0600 (CST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <e26d18e40802191305y5f7b8fdfr3113c84612c53189@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74463>

Anatoly Yakovenko wrote:

> so, basically i need to append a .git to the repository root?  I am
> getting these http requests in the access log:
> 
> 72.192.162.186 - aeyakovenko [19/Feb/2008:12:58:13 -0800] "GET
> /var/www/localhost/htdocs/git/repo/info/refs HTTP/1.1" 404 313
> 
> /var/www/localhost/htdocs/git/repo/info/refs doesn't exist, although
> this exists:
> 
> /var/www/localhost/htdocs/git/repo/.git/info/refs
> 

Something is fishy here.  Is your repository bare or not?

jdl
