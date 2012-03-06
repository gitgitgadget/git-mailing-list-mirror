From: Ben Tebulin <nntp.20.jexpert@spamgourmet.com>
Subject: Re: git push from client is not updating files on server
Date: Tue, 06 Mar 2012 18:46:26 +0100
Message-ID: <jj5ih2$f0m$1@dough.gmane.org>
References: <CAC0z1F-bGikXZtLnd8d=3G+4okvNqZaxyrLjh4G3YzPpmqyxQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 06 18:46:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4yT0-0003dQ-F9
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 18:46:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550Ab2CFRqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 12:46:25 -0500
Received: from plane.gmane.org ([80.91.229.3]:36330 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932522Ab2CFRqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 12:46:25 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1S4ySs-0003SY-Tb
	for git@vger.kernel.org; Tue, 06 Mar 2012 18:46:22 +0100
Received: from 217.6.238.194 ([217.6.238.194])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Mar 2012 18:46:22 +0100
Received: from nntp.20.jexpert by 217.6.238.194 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Mar 2012 18:46:22 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 217.6.238.194
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <CAC0z1F-bGikXZtLnd8d=3G+4okvNqZaxyrLjh4G3YzPpmqyxQA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192367>

You can only push to "bare-only repositories". These do not contain a 
working tree but only a .git directory.

You can only see changes changes in Git repository on the file system if 
you clone & pull this bare-only repository to a regular repository.

It seems you looking for the wrong thing in the wrong place...

Am 06.03.2012 17:52, schrieb Jerome Yanga:
> My main objective is to create a central public Git server.
 > [...]
> However, when I log into the central public Git server and look at the
> files in the project, none of them have change.  I can only see the
> changes from the client via Gitweb.
