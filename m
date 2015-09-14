From: Sukhwinder Singh <php_programmer_india@hotmail.com>
Subject: RE: Git Deployment using existing multiple environments
Date: Mon, 14 Sep 2015 11:25:39 +0530
Message-ID: <BAY180-W55A5095CC7E1322EA80876C25D0@phx.gbl>
References: <BAY180-W16B5F49FFD3614D666B232C25F0@phx.gbl>,<8797177dd247d4ef903603cbe6c57d7d@dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Sep 14 07:55:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbMjx-0004xL-Nx
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 07:55:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbbINFzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 01:55:40 -0400
Received: from bay004-omc4s19.hotmail.com ([65.54.190.221]:64333 "EHLO
	BAY004-OMC4S19.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751223AbbINFzj convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 01:55:39 -0400
Received: from BAY180-W55 ([65.54.190.199]) by BAY004-OMC4S19.hotmail.com over TLS secured channel with Microsoft SMTPSVC(7.5.7601.23008);
	 Sun, 13 Sep 2015 22:55:39 -0700
X-TMN: [+zTamQWUVSWhjyJALi9fYUGCp2+iv8Am]
X-Originating-Email: [php_programmer_india@hotmail.com]
Importance: Normal
In-Reply-To: <8797177dd247d4ef903603cbe6c57d7d@dscho.org>
X-OriginalArrivalTime: 14 Sep 2015 05:55:39.0736 (UTC) FILETIME=[FBF2CD80:01D0EEB1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277808>

Thank you for the reply. Let's say I do setup three different repositories then how can we move work from one repository to the other. For example, from Test Environment to UAT. If there are any links that you can provide me that I can check, it'll be great. 

Regards,
Sukhwinder Singh

----------------------------------------
> Date: Sat, 12 Sep 2015 12:55:46 +0200
> From: johannes.schindelin@gmx.de
> To: php_programmer_india@hotmail.com
> CC: git@vger.kernel.org
> Subject: Re: Git Deployment using existing multiple environments
>
> Hi,
>
> On 2015-09-12 08:31, Sukhwinder Singh wrote:
>
>> We already have 3-4 environments setup on our Windows servers without Git
>> and each environment already has code which is different from each
>> other.
>>
>> There are three environments
>> Live
>> UAT
>> Test (has the latest code)
>>
>>
>> And then developers have their local copies.
>>
>> We write and test the code locally and manually move each point from
>> one environment to other using merging software and test at each
>> environment.
>> Now we want to use git because manually moving the code is a lengthy
>> process. Also as the developers have local copies, it is very
>> difficult to manage code.
>>
>> Code is written locally by the team and then after testing locally it
>> is first merged with "Test" environment code, then "UAT" and then,
>> finally with "Live".
>> So we have two concerns:
>>
>> There is different code already existing on these environments.
>> Testing the code on each environment using the web server.
>>
>> What is the best way to go about it? As I am new to git more details
>> will be helpful, like commands to use.
>
> It seems you are not only looking for commands to use, but for a proper workflow in which Git supports your work best.
>
> The key is to define the roles in your flow first, and then identify the optimal commands.
>
> In your case, I figure that there are three "merge lords" or "merge ladies", one for "Test", one for "UAT", one for "Live". And each of them needs to be notified when changes are ready to be merged, then merge the changes.
>
> If I was walking in your shoes, I would set up four repositories that each are owned by one of the "merge lords/ladies", or the developers, respectively. The code would move from one to the next repository, triggered by a notification, then being pulled into the environment, then tested, and if everything is okay, pushed into the next repository.
>
> (Actually, you could do without the repository corresponding to the "Live" version, but it would be a nice record.)
>
> However, this is just one possible suggestion. I would highly recommend buying and reading the book "Git for Teams", as it has extensive coverage of different work flows, their strengths and their weaknesses.
>
> Ciao,
> Johannes
 		 	   		  