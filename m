From: Victor Leschuk <vleschuk@accesssoftek.com>
Subject: RE: [PATCH v4] Add git-grep threads param
Date: Tue, 3 Nov 2015 00:36:33 -0800
Message-ID: <6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA10@mail.accesssoftek.com>
References: <1445980944-24000-1-git-send-email-vleschuk@accesssoftek.com>
	<6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA0C@mail.accesssoftek.com>,<xmqqlhagfn95.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Victor Leschuk <vleschuk@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
	"john@keeping.me.uk" <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 09:38:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtX77-0002ii-8y
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 09:38:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753918AbbKCIgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 03:36:37 -0500
Received: from mail.accesssoftek.com ([12.202.173.171]:20319 "EHLO
	mail.accesssoftek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbbKCIgg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Nov 2015 03:36:36 -0500
Received: from mail.accesssoftek.com ([172.16.0.71]) by mail.accesssoftek.com
 ([172.16.0.71]) with mapi; Tue, 3 Nov 2015 00:36:35 -0800
Thread-Topic: [PATCH v4] Add git-grep threads param
Thread-Index: AdEVgj8u4CcGbyg9Tr+GW4tNEQFjMwAj7ewM
In-Reply-To: <xmqqlhagfn95.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280785>

>> do we have any objections on this patch?

> The question you should be asking is "do we have any support".

Hello all, CCing participated reviewers. As Junio  has correctly mentioned: "Do we have any support for including this functionality?"

I think this kind of customization can be useful in tuning up performance as confirmed by conducted tests. And in most cases having anything hard-coded is worse than giving users opportunity to change it, isn't it?
