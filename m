From: Paolo Bonzini <paolo.bonzini@lu.unisi.ch>
Subject: Re: [PATCH 2/3] git-fetch: Support the local remote "."
Date: Tue, 13 Mar 2007 17:53:44 +0100
Message-ID: <45F6D718.5080601@lu.unisi.ch>
References: <87bqixf6qf.fsf@gmail.com>
Reply-To: bonzini@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	"Junio C. Hamano" <junkio@cox.net>
To: =?UTF-8?B?U2FudGkgQsOpamFy?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 17:53:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRAFy-0003tj-5d
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 17:53:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030800AbXCMQxs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 13 Mar 2007 12:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030797AbXCMQxs
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 12:53:48 -0400
Received: from server.usilu.net ([195.176.178.200]:57147 "EHLO mail.usilu.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030800AbXCMQxr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 12:53:47 -0400
Received: from [192.168.68.211] ([192.168.68.211] RDNS failed) by mail.usilu.net over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 13 Mar 2007 17:53:42 +0100
User-Agent: Thunderbird 1.5.0.10 (Macintosh/20070221)
In-Reply-To: <87bqixf6qf.fsf@gmail.com>
X-OriginalArrivalTime: 13 Mar 2007 16:53:42.0262 (UTC) FILETIME=[27E8E960:01C76590]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42134>

Santi B=C3=A9jar wrote:
> To this end, git-parse-remote is grown with a new kind of remote,
> `builtin'. This returns all the local branches in
> get_remote_default_refs_for_fetch. This is equivalent to having a
> fake remote as:
>=20
> [remote "local"]
> url =3D .
> fetch =3D refs/*
>=20
> Based on a patch from Paolo Bonzini.

Can you please compare the times to do "git fetch ."?  The reason
to touch git-fetch.sh was an optimization that Junio requested.

I found my 2nd submission to be 20% faster than the first.

Paolo
