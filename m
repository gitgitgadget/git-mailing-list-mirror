From: Mark Junker <mjscod@web.de>
Subject: git-svn: Internal error during fetch of mono repository
Date: Wed, 16 Jan 2008 11:39:41 +0100
Message-ID: <478DDEED.8050906@web.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050908040400080601050007"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 16 11:40:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF5gq-0003IH-5h
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 11:40:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752213AbYAPKjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 05:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752086AbYAPKjo
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 05:39:44 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:40223 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbYAPKjn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 05:39:43 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id 95D3BCA6A04D
	for <git@vger.kernel.org>; Wed, 16 Jan 2008 11:39:41 +0100 (CET)
Received: from [80.146.179.234] (helo=mark-junkers-computer.local)
	by smtp08.web.de with asmtp (WEB.DE 4.109 #226)
	id 1JF5gL-0008Gv-00
	for git@vger.kernel.org; Wed, 16 Jan 2008 11:39:41 +0100
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X; de; rv:1.8.1.9) Gecko/20071031 Thunderbird/2.0.0.9 Mnenhy/0.7.5.0
X-Sender: mjscod@web.de
X-Provags-ID: V01U2FsdGVkX18LKA0HDclMln5LNGfCH8EVht/8eAnD0KusuZPy
	CahnJB1aSuqZeSm4hCk3ULq+KPUzaUdTdJS877Ib1tQW2izIp9
	1jUqVnd10=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70650>

This is a multi-part message in MIME format.
--------------050908040400080601050007
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I got an internal error during fetch of the mono repository. I attach 
both the messages produces by the git-fetch and the .git/config.

My git version is 1.5.3.7. The svn version is 1.4.6.

Any idea?

Regards,
Mark

--------------050908040400080601050007
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="config"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="config"

[core]
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true
[svn-remote "svn"]
	url = svn://anonsvn.mono-project.com/source
	fetch = trunk:refs/remotes/trunk
	branches = branches/*:refs/remotes/*
	tags = tags/*:refs/remotes/tags/*

--------------050908040400080601050007
Content-Type: text/plain;
 name="git-svn-error.txt"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="git-svn-error.txt"

SW5kZXggbWlzbWF0Y2g6IDkyOTFjZjU5YzZmNTg5NDg0NWZiYTAzZGY0Nzg0ODcyYjUyYWI3
NWIgIT0gNWY3MzJjMzFhNGJiNzgwNjE4ZGUwMzEzNzVlYTZmMzE5NzYwY2VhNg1yZXJlYWRp
bmcgY2UwY2M1YTAzMmZhN2IxOTI2MTI4ZGY1YmI3NTFiZjAwMzAzZTBiOA1Gb3VuZCBwb3Nz
aWJsZSBicmFuY2ggcG9pbnQ6IHN2bjovL2Fub25zdm4ubW9uby1wcm9qZWN0LmNvbS9zb3Vy
Y2UvdHJ1bmsvZGVidWdnZXIgPT4gc3ZuOi8vYW5vbnN2bi5tb25vLXByb2plY3QuY29tL3Nv
dXJjZS90YWdzL01PTk9fREVCVUdHRVJfMF8xMCwgNDU5MjQNSW5pdGlhbGl6aW5nIHBhcmVu
dDogdGFncy9NT05PX0RFQlVHR0VSXzBfMTBANDU5MjQNRm91bmQgYnJhbmNoIHBhcmVudDog
KHRhZ3MvTU9OT19ERUJVR0dFUl8wXzEwKSBkOGM1YjVkODQxMmU0YmZlNDA2NDg1OGEwZDk0
MjU4Yjc3MDkwM2RkDUluZGV4IG1pc21hdGNoOiA1ZjczMmMzMWE0YmI3ODA2MThkZTAzMTM3
NWVhNmYzMTk3NjBjZWE2ICE9IDkyOTFjZjU5YzZmNTg5NDg0NWZiYTAzZGY0Nzg0ODcyYjUy
YWI3NWINcmVyZWFkaW5nIGQ4YzViNWQ4NDEyZTRiZmU0MDY0ODU4YTBkOTQyNThiNzcwOTAz
ZGQNRm9sbG93aW5nIHBhcmVudCB3aXRoIGRvX3N3aXRjaA1JbnRlcm5hbCBlcnJvcjogQ2Fu
J3QgZmluZCBhIHRlbXBvcmFyeSBkaXJlY3RvcnkgYXQgL29wdC9sb2NhbC9iaW4vZ2l0LXN2
biBsaW5lIDMyMjc=
--------------050908040400080601050007--
