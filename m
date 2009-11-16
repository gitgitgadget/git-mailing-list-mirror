From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Git graph with branch labels for all paths in text environment
Date: Mon, 16 Nov 2009 16:27:46 +0100
Message-ID: <4B016F72.7000001@drmicha.warpmail.net>
References: <1258373038892-4011651.post@n2.nabble.com>	<adf1fd3d0911160423q4e21126dm37be7838f0ce8379@mail.gmail.com> <19201.21478.127959.431877@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>,
	rhlee <richard@webdezign.co.uk>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Mon Nov 16 16:29:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NA3Vg-0007G9-PG
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 16:28:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883AbZKPP2k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Nov 2009 10:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752865AbZKPP2j
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 10:28:39 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:42350 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752845AbZKPP2j (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Nov 2009 10:28:39 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D525EC0B73;
	Mon, 16 Nov 2009 10:28:44 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 16 Nov 2009 10:28:44 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=s09gQujasgvLETrq87GWz+hsFdg=; b=XrmZ217y1NQ0mkeDMqwVFvnBw5InYjKIzsCm3EZpn8WXFXTBRTsxlTDfuT+yMJ7Owjf1/gz2zsdrT1sAlZ3493SrBAz+nmUiksc2q0ahm3L5P5hQGvNwLdQy01PBy0yWXxPYbTk145R+e/ccSgKbKzjixaRqsOObi/xY6w14hLs=
X-Sasl-enc: v8kAmb2oUOr7EvSVVooaN7XaSaaZAuooK5SJcA6iB3C7 1258385324
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 024AD9C56;
	Mon, 16 Nov 2009 10:28:43 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091116 Lightning/1.0pre Shredder/3.0.1pre
In-Reply-To: <19201.21478.127959.431877@lisa.zopyra.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133010>

Bill Lear venit, vidit, dixit 16.11.2009 14:30:
> On Monday, November 16, 2009 at 13:23:10 (+0100) Santi B=E9jar writes=
:
>> On Mon, Nov 16, 2009 at 1:03 PM, rhlee <richard@webdezign.co.uk> wro=
te:
>>> Is there anyway to to view a text based git grah that shows all pat=
hs with
>>> the branch labels? Like a on gitk but ncurses based?
>>
>> For third-party tools you can check:
>>
>> http://git-scm.com/tools
>=20
> Anything that can print this?:
>=20
>                                        H---I---J topicB
>                                       /
>                              E---F---G  topicA
>                             /
>                A---B---C---D  master
>=20
> I've always liked the text-based format that keeps things in-line, as
> above.  Very readable.  I thought someone on this list posted
> something about a tool that could produce such graphs from
> reasonably-sized git repos.  Anyone have such a thing?

You really mean horizontally? I know those wide screen monitors are
becoming ubiquitious, but still...

Or are you more after the "in-line" part in the sense that "each branch
is on its line"? This is a bit difficult to define, though (the graph
above is linear, e.g.).

Michael
