From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: git history and file moves
Date: Fri, 24 Oct 2008 14:30:46 -0700
Message-ID: <4911F71203A09E4D9981D27F9D8308580AA7FFFB@orsmsx503.amr.corp.intel.com>
References: <1224640967.14280.0.camel@minggr.sh.intel.com>
 <81b0412b0810220419q43f6985fs1c608e3d3cbcf8f3@mail.gmail.com>
 <48FF1EDB.8010503@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Alex Riesen <raa.lkml@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>,
	"Lin, Ming M" <ming.m.lin@intel.com>
X-From: git-owner@vger.kernel.org Fri Oct 24 23:32:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtUGU-00063A-Ic
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 23:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752562AbYJXVau (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 17:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754435AbYJXVau
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 17:30:50 -0400
Received: from mga11.intel.com ([192.55.52.93]:12164 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751059AbYJXVat convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Oct 2008 17:30:49 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP; 24 Oct 2008 14:26:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.33,480,1220252400"; 
   d="scan'208";a="631351928"
Received: from unknown (HELO azsmsx601.amr.corp.intel.com) ([10.2.121.193])
  by fmsmga001.fm.intel.com with ESMTP; 24 Oct 2008 14:31:35 -0700
Received: from orsmsx002.amr.corp.intel.com (10.22.226.105) by
 azsmsx601.amr.corp.intel.com (10.2.121.193) with Microsoft SMTP Server (TLS)
 id 8.1.311.2; Fri, 24 Oct 2008 14:30:48 -0700
Received: from orsmsx503.amr.corp.intel.com ([10.22.226.47]) by
 orsmsx002.amr.corp.intel.com ([10.22.226.105]) with mapi; Fri, 24 Oct 2008
 14:30:47 -0700
Thread-Topic: git history and file moves
Thread-Index: Ack0Qycm9gEghI5OTrqHJVbytEoAfQB3JCJg
In-Reply-To: <48FF1EDB.8010503@drmicha.warpmail.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99067>

Here's what we have:

/var/www/cgi-bin/gitweb.acpica/gitweb.conf

Containts this : GITWEB_CSS = "/icons/gitweb.css";


What should we add to automatically get all file history?

Thanks,
Bob

>-----Original Message-----
>From: Michael J Gruber [mailto:git@drmicha.warpmail.net]
>Sent: Wednesday, October 22, 2008 5:39 AM
>To: Lin, Ming M
>Cc: Alex Riesen; git@vger.kernel.org; Moore, Robert
>Subject: Re: git history and file moves
>
>Alex Riesen venit, vidit, dixit 10/22/08 13:19:
>> 2008/10/22 Lin Ming <ming.m.lin@intel.com>:
>>> I'm looking for a way to move files to a new directory and have the
>>> full history follow the file automatically. Is this possible?
>>>
>>> I know about --follow, but I want the history to just follow the file
>>> transparently. ...
>>
>> Of all Git tools, what does not do this "transparently" or
>"automatically"?
>> How more transparent do you imagine this?
>> What do you think should follow what?
>>
>> I ask, because it is hard to understand what exactly is it you're
>missing:
>> merge support (which we have), git log listing the files as
>copied/renamed
>> (which is what --follow is for, and the suggestion for you is to make an
>> alias or something), git blame (ever looked at git gui blame?) or gitk
>> (which follows renames in default configuration)
>>
>>> Also, we have a git web interface and we want the full
>>> history for the moved files to be available.
>>
>> It is available. Whether it is shown is another question. git-web can
>> be improved (or just configured?)
>
>By default, gitweb uses "-M" for diff. You can specify all options (-C,
>-CC, -B) using  "@diff_opts" in the config file for gitweb.cgi - if that
>is what you are using. Is it?
>
>Anyways, using default configs for git log and gitweb.cgi both of them
>show the full history (renames, history before and after) for me here,
>using current git (1.6.0.3.514.g2f91b). What is your setup?
>
>Michael
