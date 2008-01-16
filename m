From: Mark Junker <mjscod@web.de>
Subject: git-svn: Internal error during fetch of mono repository
Date: Wed, 16 Jan 2008 12:33:36 +0100
Message-ID: <478DEB90.2090306@web.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010606010001010706060800"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 16 12:34:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF6Wz-00073t-Sk
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 12:34:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbYAPLdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 06:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751550AbYAPLdh
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 06:33:37 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:35076 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbYAPLdg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 06:33:36 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 2E1E6C68588B
	for <git@vger.kernel.org>; Wed, 16 Jan 2008 12:33:35 +0100 (CET)
Received: from [80.146.179.234] (helo=mark-junkers-computer.local)
	by smtp06.web.de with asmtp (WEB.DE 4.109 #226)
	id 1JF6WV-0000Sq-00
	for git@vger.kernel.org; Wed, 16 Jan 2008 12:33:35 +0100
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X; de; rv:1.8.1.9) Gecko/20071031 Thunderbird/2.0.0.9 Mnenhy/0.7.5.0
X-Sender: mjscod@web.de
X-Provags-ID: V01U2FsdGVkX19R4tRci3+krxePm+jd9J/KRmrMvrGiWPxVGLU2
	VA3aDgTk6t+8tKBtqRDs+Pxlw0IkBQJNddxbILagpn3NAZUgPe
	crNGWhKOA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70653>

This is a multi-part message in MIME format.
--------------010606010001010706060800
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I got an internal error during fetch of the mono repository. I attach
both the messages produces by the git-fetch and the .git/config.

My git version is 1.5.3.7. The svn version is 1.4.6.

Any idea?

Regards,
Mark


--------------010606010001010706060800
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


--------------010606010001010706060800
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
--------------010606010001010706060800--
