From: =?UTF-8?Q?Odin=20H=C3=B8rthe=20Omdal?= <odinho@opera.com>
Subject: Re: git submodule update needs to be at the toplevel of working tree,
 why?
Date: Fri, 22 Nov 2013 15:37:00 +0100
Message-ID: <1385131020.5838.50791533.395F2F63@webmail.messagingengine.com>
References: <1385126550.10973.50760825.6B70B959@webmail.messagingengine.com>
 <20131122134747.GC15033@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Nov 22 15:37:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vjrr8-0003Ez-RW
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 15:37:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755339Ab3KVOhI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Nov 2013 09:37:08 -0500
Received: from smtp.opera.com ([213.236.208.81]:59556 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752132Ab3KVOhH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Nov 2013 09:37:07 -0500
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com [66.111.4.228])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-9.4) with ESMTP id rAMEb1nI002836
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 22 Nov 2013 14:37:02 GMT
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 5E74920FDC;
	Fri, 22 Nov 2013 09:37:00 -0500 (EST)
Received: from web2 ([10.202.2.212])
  by compute6.internal (MEProxy); Fri, 22 Nov 2013 09:37:00 -0500
Received: by web2.nyi.mail.srv.osa (Postfix, from userid 99)
	id 31D2354006F; Fri, 22 Nov 2013 09:37:00 -0500 (EST)
X-Sasl-Enc: ckXBLhzpo7FXpk4XAj9ypXmeS1GLh/9TMIy/dlz/JOyH 1385131020
X-Mailer: MessagingEngine.com Webmail Interface - ajax-3f1150ec
In-Reply-To: <20131122134747.GC15033@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238189>

On Fri, Nov 22, 2013, at 14:47, John Keeping wrote:
> On Fri, Nov 22, 2013 at 02:22:30PM +0100, Odin H=C3=B8rthe Omdal wrot=
e:
> > I'm usually in a subfolder doing actual work. A very common problem=
 I
> > have is wanting to do a submodule update, but git really hates that=
=2E And
> > I wonder why?
> >=20
> > It wouldn't be hard to cd to the toplevel working directory, do the
> > update, and cd back. It's what I have to do manually every time now
> > already:
>=20
> This restriction was removed in Git 1.8.4.

Oh, awesome!  My system git is 1.8.3.2.

I'll do a manual install then :)

Sorry for the noise. (I didn't find any earlier talk about it, but I
only used gmame's search, so it might have missed something)

--=20
  Odin H=C3=B8rthe Omdal
  odinho@opera.com
