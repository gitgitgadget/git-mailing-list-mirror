From: Shenbaga Prasanna <prasanna.s@freshdesk.com>
Subject: Re: macblame - al alterntive to 'git blame'
Date: Tue, 24 Mar 2015 14:10:30 +0000 (UTC)
Message-ID: <loom.20150324T150954-333@post.gmane.org>
References: <CAFKdeLPb4HPJ4a5tvYXa2GEr-WK-Wra56m2vrU7-LheNDWp7iA@mail.gmail.com> <CACsJy8ARVhgCOcM=XbELV-x_cNa8iGqMX6O2ouUp8UPq7xzcXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 25 07:25:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yaekd-0004yp-4P
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 07:25:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752594AbbCYGZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 02:25:10 -0400
Received: from plane.gmane.org ([80.91.229.3]:39104 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750815AbbCYGZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 02:25:09 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1YaekS-0004qK-5t
	for git@vger.kernel.org; Wed, 25 Mar 2015 07:25:05 +0100
Received: from 14.141.101.134.static-Chennai.vsnl.net.in ([14.141.101.134.static-Chennai.vsnl.net.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Mar 2015 07:25:04 +0100
Received: from prasanna.s by 14.141.101.134.static-Chennai.vsnl.net.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Mar 2015 07:25:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 14.141.101.134 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.101 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266263>


sample output..

for file Gemfile..
Contributor: Prasanna with 93.75 % contribution with 30 lines of code
Contributor: h4r1sh with 6.25 % contribution with 2 lines of code
* * * * * * * * * * * * * * * * * * * * * * * * *

and I built this tool by pipelining the output produced by 'git blame'
and we use this tool for our internal purposes in our organisation
where some files are edited by some 15 people and this will tell us
whom to catch if that files run into any problems (assuming largest
contributor knows what this file is upto).

Thanks,
Prasanna
