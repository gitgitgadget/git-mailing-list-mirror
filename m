From: =?UTF-8?B?IkFsZWphbmRybyBSLiBTZWRlw7FvIg==?= <asedeno@MIT.EDU>
Subject: Re: [PATCH 1/2] git-svn: Fix the commit-url config to be the base
  url, just like the url config
Date: Tue, 05 Apr 2011 11:11:06 -0400
Message-ID: <4D9B310A.9020203@mit.edu>
References: <1301944148-7950-1-git-send-email-asedeno@mit.edu> <1301944148-7950-2-git-send-email-asedeno@mit.edu> <20110404215227.GA4224@dcvr.yhbt.net> <F8E6CFA4-79F6-41AC-8266-09B3B46C8520@itasoftware.com> <20110404225442.GA9307@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: James Y Knight <jknight@itasoftware.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Apr 05 17:16:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q77zP-0004Pp-Ti
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 17:16:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753923Ab1DEPQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 11:16:13 -0400
Received: from DMZ-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.34]:63778 "EHLO
	dmz-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753255Ab1DEPQL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Apr 2011 11:16:11 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Apr 2011 11:16:11 EDT
X-AuditID: 12074422-b7ccdae000003dab-b8-4d9b3110328b
Received: from mailhub-auth-3.mit.edu ( [18.9.21.43])
	by dmz-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 18.6C.15787.0113B9D4; Tue,  5 Apr 2011 11:11:12 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id p35FB86V024904
	for <git@vger.kernel.org>; Tue, 5 Apr 2011 11:11:09 -0400
Received: from darkmatter.mit.edu (DARKMATTER.MIT.EDU [18.238.2.175])
	(authenticated bits=0)
        (User authenticated as smtp/darkmatter.mit.edu@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id p35FB6B4026420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Tue, 5 Apr 2011 11:11:07 -0400 (EDT)
Received: by darkmatter.mit.edu (Postfix, from userid 108)
	id CA69014C010; Tue,  5 Apr 2011 11:11:06 -0400 (EDT)
Received: from asedeno.corp.itasoftware.com (ita4fw1.itasoftware.com [63.107.91.99])
	by darkmatter.mit.edu (Postfix) with ESMTPSA id A658B834727;
	Tue,  5 Apr 2011 11:11:06 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110309 Icedove/3.1.9
In-Reply-To: <20110404225442.GA9307@dcvr.yhbt.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsUixCmqrStgONvX4NZGZYuuK91MDowenzfJ
	BTBGcdmkpOZklqUW6dslcGV8uPWateAcT0Xr2XbmBsaPnF2MnBwSAiYSj2esZoGwxSQu3FvP
	1sXIxSEksI9Rov/xMmYI5ySjxLepG5kgnI9MEisenQNrERIoklj8+Ak7RGI3o8S2hbOZQRK8
	AmoSs6+fBSri4GARUJW4tkwCJMwm4CKx5PE1NhBbVCBeYtnL2awQ5YISJ2c+AZspAlT+ccYL
	sDHMAo4Sa9b+ZQSxhQWyJT5t2A510RdGiUtzDzCBJDgFjCS6dzWA7WIWUJdYP08IoldeYvvb
	OcwTGIVnIVkxC6FqFpKqBYzMqxhlU3KrdHMTM3OKU5N1i5MT8/JSi3RN9XIzS/RSU0o3MYJC
	m91FaQfjz4NKhxgFOBiVeHhXv5jpK8SaWFZcmXuIUZKDSUmU119/tq8QX1J+SmVGYnFGfFFp
	TmrxIUYJDmYlEV7T17N8hXhTEiurUovyYVLSHCxK4rxzJNV9hQTSE0tSs1NTC1KLYLIaHBwC
	Vw4emc0oxZKXn5eqJMHrYgC0QLAoNT21Ii0zpwShlImDE2QRD9AibpAa3uKCxNzizHSI/ClG
	RSlx3mCQhABIIqM0D64XlpJeMYoDvSXMawdSxQNMZ3Ddr4AGMwENrlYG+aC4JBEhJdXAmH+b
	f9HdiOPLtedmM2rutN1aJeL8uOWKrY2Y/uV7NzVOLkgKvnFg82LuihcVVjzf2Y0fHWe5Ub0w
	pnazgZTB94D5yttNmnrTK25sv13LqG/iY5lrdVSvtfdVoeiF5wUs0ZLOcyV+v0h/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170882>

On 04/04/2011 06:54 PM, Eric Wong wrote:
> James Y Knight <jknight@itasoftware.com> wrote:
>> > On Apr 4, 2011, at 5:52 PM, Eric Wong wrote:
>>> > > $_commit_url is a user-specified parameter from the --commit-url switch.
>>> > > If they want to override it it's the user's perogative.  It's not the
>>> > > default and not commonly used.
>> > 
>> > In .git/config:
>> > 
>> > [svn-remote "svn"]
>> >         url = http://hostname/svnrepo/
>> >         commiturl = svn+ssh://hostname/svnrepo
>> >         branches = branches/*:refs/remotes/origin/*
>> >         fetch = trunk:refs/remotes/origin/master
>> > 
>> > The commiturl configuration is necessary so that the canonical URL is the http:// url (which can be used for read-only access), but if you want to commit, you have to use svn+ssh. This is a fairly common way of setting up access to an svn repository, so I'm surprised to be the first one to hit this issue.
>> > 
>> > Without the patch, you need:
>> >         commiturl = svn+ssh://hostname/svnrepo/trunk
>> > which of course then doesn't allow you to commit to other branches.
> Originally --commit-url was only intended to be a command-line option
> and for overriding specific cases and also for dealing with permission
> mismatches (limited commit access to a branch, unlimited read access
> to the repo).
> 
> Your patch breaks existing use cases, I think.
> 
> I think Junio's suggestion for a pushurl config which does what you
> think commitUrl does would be what you're after...

That sounds good to me. I'll submit an updated patch later today.

-Alejandro
