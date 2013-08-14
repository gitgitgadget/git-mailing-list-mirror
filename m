From: XinLingchao <douglarek@outlook.com>
Subject: RE: About *git clone --depth=n* puzzle
Date: Wed, 14 Aug 2013 20:45:46 +0800
Message-ID: <BAY169-W3481BBD06C4449E7C5D6F5B4450@phx.gbl>
References: <BAY169-W472B90AB796C71E8D0D038B4450@phx.gbl>,<520B4529.9080304@googlemail.com>,<BAY169-W647D5A2BFDC793ADFA5078B4450@phx.gbl>,<20130814115956.GA29295@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"junchunx.guan@gmail.com" <junchunx.guan@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Aug 14 14:46:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9aSc-0003Pd-CZ
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 14:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555Ab3HNMps convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Aug 2013 08:45:48 -0400
Received: from bay0-omc1-s27.bay0.hotmail.com ([65.54.190.38]:38707 "EHLO
	bay0-omc1-s27.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932495Ab3HNMpr convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 08:45:47 -0400
Received: from BAY169-W34 ([65.54.190.59]) by bay0-omc1-s27.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Wed, 14 Aug 2013 05:45:46 -0700
X-TMN: [NGvSnwPx/WXvCoDBkQ6cuy28S2FUFecn]
X-Originating-Email: [douglarek@outlook.com]
Importance: Normal
In-Reply-To: <20130814115956.GA29295@sigill.intra.peff.net>
X-OriginalArrivalTime: 14 Aug 2013 12:45:46.0426 (UTC) FILETIME=[3251F9A0:01CE98EC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232282>

Peff, thanks for your detial explain,=A0 and I think I have got the poi=
nt :P

-Lingchao Xin

----------------------------------------
> Date: Wed, 14 Aug 2013 07:59:56 -0400
> From: peff@peff.net
> To: douglarek@outlook.com
> CC: stefanbeller@googlemail.com; git@vger.kernel.org; junchunx.guan@g=
mail.com
> Subject: Re: About *git clone --depth=3Dn* puzzle
>
> On Wed, Aug 14, 2013 at 05:19:36PM +0800, XinLingchao wrote:
>
>>> There was a similar discussion going on in July this year,
>>> maybe this is an interesting read with respect to this topic
>>> http://www.spinics.net/lists/git/msg196138.html
>>>
>> Stefan, I do NOT think so, the key point is not about the depth limi=
t,
>> it is about whether remote clone depth equals local clone depth.
>
> I do not think it is about local vs remote, but rather about which
> version of git the remote side is running. Prior to 682c7d2
> (upload-pack: fix off-by-one depth calculation in shallow clone,
> 2013-01-11), a shallow clone always returned one extra commit. That f=
ix
> went into v1.8.2.
>
> So if you have a post-v1.8.2 git client, a local clone will use the s=
ame
> git version as the "remote" side of the connection. But if you are
> contacting a remote server, the results you get will depend on what
> version of git is running on the remote server.
>
> And as the example you showed uses github.com as the remote, and as I
> happen to know that GitHub's servers do not currently have 682c7d2, y=
ou
> would see the old behavior.
>
> -Peff 		 	   		  