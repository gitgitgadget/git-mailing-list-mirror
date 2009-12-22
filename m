From: Nick Triantos <nick@perceptivepixel.com>
Subject: Huge pack file from small unpacked objects
Date: Tue, 22 Dec 2009 01:19:39 -0500
Message-ID: <75B8C0BEE0AE2A44AA971D218D9FE99E6B06F030@VMBX125.ihostexchange.net>
References: <404585ED79625A40AB5A9884ECA9A63B3E02083F@VMBX125.ihostexchange.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "'git@vger.kernel.org'" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 22 07:19:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMy65-00013x-1E
	for gcvg-git-2@lo.gmane.org; Tue, 22 Dec 2009 07:19:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbZLVGTs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Dec 2009 01:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbZLVGTs
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Dec 2009 01:19:48 -0500
Received: from relay.ihostexchange.net ([66.46.182.55]:17977 "EHLO
	relay.ihostexchange.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbZLVGTr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Dec 2009 01:19:47 -0500
Received: from VMBX125.ihostexchange.net ([192.168.40.5]) by
 hub105.ihostexchange.net ([66.46.182.55]) with mapi; Tue, 22 Dec 2009
 01:19:40 -0500
Thread-Topic: Huge pack file from small unpacked objects
Thread-Index: Acp+YiGNC+Sm/dKxS4imFtBblGe/sQAC3zOQ
In-Reply-To: <404585ED79625A40AB5A9884ECA9A63B3E02083F@VMBX125.ihostexchange.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135570>

Hi,

(re-sending.. I'm not sure if my last send made it to the list, I got a=
 bounce because it had HTML.)

I recently created a repo from SVN via git-svn.=A0 The bare repo was ab=
out ~600MB.=A0 I cloned it, and on the clone, I added 2 small files (.g=
itignore and .gitattributes) to a branch, merged them to master, and pu=
shed that back to the origin.=A0 The cloned repo remains at about 600MB=
, while my origin repo (the one from svn) is now about 2.4GB.=A0 I foun=
d that it created a file in objects/pack which accounts for this huge s=
ize.

I've tried running 'git repack -a -d' but that didn't shrink the size o=
f this pack file.

Any ideas why the pack file is so huge?=A0 Anything I can do to shrink =
it?=A0 My coworkers are understandably unhappy that the repo is so huge=
 now (makes for very slow pulls)

thanks,
-Nick
