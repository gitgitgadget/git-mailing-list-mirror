From: Tim Janik <timj@imendio.com>
Subject: Re: git-svn breaks on gtk+ import
Date: Fri, 7 Mar 2008 21:09:50 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0803072108500.29360@master.birnet.private>
References: <alpine.DEB.1.00.0803071844510.27175@master.birnet.private> <1204918885.23455.8.camel@brick>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Harvey Harrison <harvey.harrison@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 21:13:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXiuN-0000bs-Be
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 21:11:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758841AbYCGUKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2008 15:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758323AbYCGUKc
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Mar 2008 15:10:32 -0500
Received: from mx02.hansenet.de ([213.191.73.26]:44184 "EHLO
	webmail.hansenet.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757835AbYCGUKb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2008 15:10:31 -0500
Received: from birnet.org (85.176.207.234) by webmail.hansenet.de (7.3.118.12)
        id 47CBEF7600FE77B1; Fri, 7 Mar 2008 21:10:08 +0100
Received: from master.birnet.private (timj@localhost [127.0.0.1])
	by birnet.org (8.13.8/8.13.8/Debian-3) with ESMTP id m27K9pjY029417
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 7 Mar 2008 21:09:51 +0100
Received: (from timj@localhost)
	by master.birnet.private (8.13.8/8.13.8/Submit) id m27K9ojQ029416;
	Fri, 7 Mar 2008 21:09:50 +0100
X-X-Sender: timj@master.birnet.private
In-Reply-To: <1204918885.23455.8.camel@brick>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76518>

On Fri, 7 Mar 2008, Harvey Harrison wrote:

> On Fri, 2008-03-07 at 19:00 +0100, Tim Janik wrote:
>> hi Eric.
>>
>> with git-svn from git 1.5.4.3, imports of the Gtk+ repository fail:
>>
>>    git-svn clone -T trunk -b branches -t tags -r 19001 http://svn.gnome.org/svn/gtk+
>>    Using existing [svn-remote "svn"]
>>    Using higher level of URL: http://svn.gnome.org/svn/gtk+ => http://svn.gnome.org/svn/gtk%2B/http:
>>    No such file or directory: PROPFIND request failed on '/svn/gtk%252B/http%3A': Could not open the requested SVN filesystem at /usr/bin/git-svn line 1352
>>
>
> Strange, mine worked fine, other than:
> svn://svn.gnome.org/svn/gtk+

the problem only comes up wit http://svn.gnome.org/svn/gtk+,
not with svn://svn.gnome.org/svn/gtk+.

>
> Cheers,
>
> Harvey
>

---
ciaoTJ
