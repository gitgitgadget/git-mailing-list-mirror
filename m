From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: GIT_SSL_NO_VERIFY=1 over http doesn't ignore a different ip
 address for the signed certificate
Date: Thu, 21 Feb 2008 20:04:11 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0802212003140.14691@yvahk3.pbagnpgbe.fr>
References: <e26d18e40802201535s7a5c12fbtd61d2445426f4018@mail.gmail.com> 
 <20080221064252.GA16036@glandium.org> <e26d18e40802211057o255246f3p31800c73eb8391ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 21 20:04:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSGiy-00008P-ED
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 20:04:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbYBUTEO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 14:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbYBUTEO
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 14:04:14 -0500
Received: from kluster1.contactor.se ([91.191.140.11]:60838 "EHLO
	kluster1.contactor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029AbYBUTEO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 14:04:14 -0500
Received: from linux3.contactor.se (linux3.contactor.se [91.191.140.23])
	by kluster1.contactor.se (8.13.8/8.13.8/Debian-3) with ESMTP id m1LJ4BGD009592
	for <git@vger.kernel.org>; Thu, 21 Feb 2008 20:04:11 +0100
X-X-Sender: dast@linux3.contactor.se
In-Reply-To: <e26d18e40802211057o255246f3p31800c73eb8391ec@mail.gmail.com>
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74643>

On Thu, 21 Feb 2008, Anatoly Yakovenko wrote:

> yep, it tells me that the certificate is rejected because it was signed for 
> a different ip then the one i am connected too.  while this is a security 
> threat, browsers will let you ignore it, so i expect that libcurl or git 
> should be able to ignore that error as well.

libcurl can most certainly be told to ignore that:

http://curl.haxx.se/libcurl/c/curl_easy_setopt.html#CURLOPTSSLVERIFYHOST
