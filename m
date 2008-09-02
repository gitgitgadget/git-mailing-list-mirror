From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: Error on new installation
Date: Tue, 2 Sep 2008 20:25:16 +0100
Message-ID: <200809022025.16793.alan@chandlerfamily.org.uk>
References: <200808310047.50560.alan@chandlerfamily.org.uk> <a2075f4c0809020719u40850e8bk240db2ee1499ee0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 02 21:26:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KabVz-0007eB-8o
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 21:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbYIBTZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 15:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbYIBTZF
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 15:25:05 -0400
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:58090 "EHLO
	smtp-out5.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751390AbYIBTZE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Sep 2008 15:25:04 -0400
Received: from [172.23.170.139] (helo=anti-virus01-10)
	by smtp-out5.blueyonder.co.uk with smtp (Exim 4.52)
	id 1KabUr-0001yz-JT
	for git@vger.kernel.org; Tue, 02 Sep 2008 20:25:01 +0100
Received: from [77.101.57.129] (helo=home.chandlerfamily.org.uk)
	by asmtp-out4.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1KabUm-0005JG-2X
	for git@vger.kernel.org; Tue, 02 Sep 2008 20:24:56 +0100
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.63)
	(envelope-from <alan@chandlerfamily.org.uk>)
	id 1KabUl-0006aa-R6
	for git@vger.kernel.org; Tue, 02 Sep 2008 20:24:55 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <a2075f4c0809020719u40850e8bk240db2ee1499ee0@mail.gmail.com>
Content-Disposition: inline
X-SA-Exim-Connect-IP: 192.168.0.21
X-SA-Exim-Mail-From: alan@chandlerfamily.org.uk
X-SA-Exim-Scanned: No (on home.chandlerfamily.org.uk); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94694>

On Tuesday 02 Sep 2008, Felipe Carvalho Oliveira wrote:
> I use sshfs (my hosting don't permits Shell Acess) to mount my "sftp"
> server on my filesystem and it works welll (a litle bit slow, but
> works).

Interesting - but I changed my mind in the end and use a 
post-commit/post-merge hook to see if I am now on my "site" branch on 
my home change and then rsync the working tree over to the server.  It 
means I don't need the whole repository on the server, and I also can 
use git-describe --tags to give me a version no reference file

-- 
Alan Chandler
http://www.chandlerfamily.org.uk
