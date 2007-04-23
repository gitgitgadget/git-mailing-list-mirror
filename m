From: Rogan Dawes <discard@dawes.za.net>
Subject: Re: cvsimport problem
Date: Mon, 23 Apr 2007 10:44:18 +0200
Message-ID: <462C71E2.2040007@dawes.za.net>
References: <000c01c7857c$f27b3c30$0b0aa8c0@abf.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: 'git' <git@vger.kernel.org>
To: Raimund Bauer <raimund.bauer@abf-int.de>
X-From: git-owner@vger.kernel.org Mon Apr 23 10:45:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfuB7-000425-T6
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 10:45:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753106AbXDWIpm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 04:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753007AbXDWIpm
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 04:45:42 -0400
Received: from sumo.dreamhost.com ([66.33.216.29]:57650 "EHLO
	sumo.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854AbXDWIpk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 04:45:40 -0400
Received: from spunkymail-a16.dreamhost.com (sd-green-bigip-81.dreamhost.com [208.97.132.81])
	by sumo.dreamhost.com (Postfix) with ESMTP id D0C1917F9EE
	for <git@vger.kernel.org>; Mon, 23 Apr 2007 01:45:40 -0700 (PDT)
Received: from [192.168.201.100] (dsl-146-24-97.telkomadsl.co.za [165.146.24.97])
	by spunkymail-a16.dreamhost.com (Postfix) with ESMTP id 4DD0E7C10A;
	Mon, 23 Apr 2007 01:44:37 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <000c01c7857c$f27b3c30$0b0aa8c0@abf.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45303>

Raimund Bauer wrote:
> I have already imported lots of cvs repositories into git repostitories on
> our server, which I then clone from several client machines.
> This weekend I ran into a module I couldn't clone:
> 
> $ cvs -d :pserver:anonymous@cvs.drupal.org:/cvs/drupal-contrib login
>  enter passwort 'anonymous'
> $ git cvsimport -d :pserver:anonymous@cvs.drupal.org:/cvs/drupal-contrib -v
> -i contributions/modules/node_import
> Initialized empty Git repository in
> /home/ray/drupal/modules/node_import/.git/
> Running cvsps...
> connect error: Network is unreachable
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Is this maybe the reason?

Rogan
