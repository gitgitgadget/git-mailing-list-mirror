From: Illia Bobyr <ibobyr@blizzard.com>
Subject: Re: Don't share anything but those files
Date: Fri, 13 Jul 2012 18:08:15 +0000
Message-ID: <5000640F.40609@blizzard.com>
References: <500037EB.5030408@modusfx.com>
 <20120713152127.GC17521@phobos.chilli.itwm.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Yves Perron <yves.perron@modusfx.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Edward Toroshchin <edward.hades@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 13 20:18:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpkS9-0008Ql-U1
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jul 2012 20:18:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755984Ab2GMSSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jul 2012 14:18:52 -0400
Received: from mx10.blizzard.com ([12.130.201.12]:18479 "EHLO
	mx10.blizzard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753468Ab2GMSSv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jul 2012 14:18:51 -0400
X-Greylist: delayed 626 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Jul 2012 14:18:51 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=blizzard.com; i=ibobyr@blizzard.com; q=dns/txt;
  s=mail; t=1342203531; x=1373739531;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yfHFF/SeZVDDR6uof1haBaQQcS/bOmDWRuqHznmu9FA=;
  b=Zfnc1829bp0dogvWl4fVarTFzofTlLTeJs+YnDeW/k+lKB8rg9UrHmRh
   /N0/V+uZjukuMmzRqrzKSzILZEaaDfGqrYELPBL/2o/4E1QV67GIy1s2/
   8CKseK22NBxfeDndqWf9ezMHLXjcROFbluxooRCMQ1stIypyoQBMFj0xT
   o=;
X-IronPort-AV: E=Sophos;i="4.77,579,1336374000"; 
   d="scan'208";a="7775707"
Received: from irvex204.corp.blizzard.net ([10.130.14.25])
  by mx10.blizzard.com with ESMTP; 13 Jul 2012 11:08:17 -0700
Received: from IRVEX018.corp.blizzard.net (10.130.2.73) by
 IRVEX204.corp.blizzard.net (10.130.14.25) with Microsoft SMTP Server (TLS) id
 14.1.289.1; Fri, 13 Jul 2012 11:08:17 -0700
Received: from IRVEX008.corp.blizzard.net ([fe80::c5f9:f4ad:53fc:4d4b]) by
 IRVEX018.corp.blizzard.net ([::1]) with mapi id 14.01.0289.001; Fri, 13 Jul
 2012 11:08:16 -0700
Thread-Topic: Don't share anything but those files
Thread-Index: AQHNYQhqjuGn3/e8N025rrVE3QGFrZcnyZ+AgAAumoA=
In-Reply-To: <20120713152127.GC17521@phobos.chilli.itwm.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.129.238.170]
Content-ID: <9327D0702A40E346A5B669BAA22D1D52@blizzard.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201415>

On 7/13/2012 8:21 AM, Edward Toroshchin wrote:
> On Fri, Jul 13, 2012 at 10:59:55AM -0400, Yves Perron wrote:
>> I'm wondering how to commit only selected files/folders on GIT, if even
>> possible.
> Just "git add" only the files you need.
>
> If you want git to ignore all the rest, you can write '*' in your
> .gitignore

As an alternative, you may be able to use negative patterns in your 
.gitignore or other ignore files.  Like this:

*
!.gitignore
!a_file_that_should_be_tracked
!a_dir_to_track/

See "git help ignore" for more details.

Illia Bobyr