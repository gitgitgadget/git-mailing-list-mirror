From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: gitk: Removing Stacked Git branches from the --all view
Date: Tue, 17 Aug 2010 00:02:13 -0600
Message-ID: <4C6A25E5.5050707@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 17 08:02:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlFFZ-0006UT-Tb
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 08:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783Ab0HQGCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 02:02:12 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:33054 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925Ab0HQGCM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 02:02:12 -0400
Received: (qmail 31860 invoked by uid 399); 17 Aug 2010 00:02:11 -0600
Received: from unknown (HELO ?192.168.1.100?) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAM; 17 Aug 2010 00:02:11 -0600
X-Originating-IP: 76.27.116.215
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.8) Gecko/20100802 Lightning/1.0b2 Thunderbird/3.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153701>

  I often run 'gitk --all'.  It works great until I introduce Stacked 
Git into the equation.  StGit uses branches called branchname.stgit for 
various metadata.  The metadata turns into an ugly mess with gitk --all.

I've been playing around with various 'git log' options, but I'm not 
finding one that gives me the gitk --all view as if StGit were never 
attached to the repository.  (Speaking of StGit and apps that store 
metadata in branches... it would be awesome to have a filter that knocks 
those branches out of ALL views of the data.)

Would someone mind helping me out?

Thanks.

Josh
