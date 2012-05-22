From: =?UTF-8?B?VGFqdGkgw4Frb3M=?= <akos.tajti@intland.com>
Subject: Re: git-upload-pack stream
Date: Tue, 22 May 2012 23:46:08 +0200
Message-ID: <4FBC091F.2070705@intland.com>
References: <4FBBC063.3050108@intland.com> <20120522181240.GA20305@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 22 23:46:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWwuP-0008DT-Uo
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 23:46:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754315Ab2EVVqV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 May 2012 17:46:21 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:55415 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348Ab2EVVqU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 17:46:20 -0400
Received: from [192.168.2.199] (dslb-188-104-171-178.pools.arcor-ip.net [188.104.171.178])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0MM2YK-1SPGLH36Gy-008Kqh; Tue, 22 May 2012 23:46:13 +0200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; hu; rv:1.9.2.28) Gecko/20120306 Thunderbird/3.1.20
In-Reply-To: <20120522181240.GA20305@sigill.intra.peff.net>
X-Provags-ID: V02:K0:fwdxsfC7NjhhSYl5SCrvhPwrYzRa56DEcoRwlGvKxgO
 +yG+/ci5yoQZ8oZQfA1nFUGREVs7AuhJezF+qqMTGyRajjrr3A
 MYReLNEyG4iD+l9ZpS49jO0cbNSuuJYgyQ8ZNP/+O7FLTH2lJm
 POZ7cP2lO68eSRL8oH4O6FLGOK1EsMP23zZzugwrWN6c3trDUF
 U+vnEoDM0kv7MerfF+yb3kpsdw+oAIZmHvBaJfLTPhYy6kuLui
 3Qho/gae6cOTBIgl51rNz9vhW3QCydAk1Y/7Ayx8bT/TvVBeMi
 Yi7L8l6BZrBhoEpO2OiThnEg909yfiejIPKqAWyaRBrmknitLG
 j++Na15LBBvC4szgDp5Q=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198257>

Jeff,

thanks for the information

=C3=81kos

2012.05.22. 20:12 keltez=C3=A9ssel, Jeff King =C3=ADrta:
> On Tue, May 22, 2012 at 06:35:47PM +0200, Tajti =C3=81kos wrote:
>
>> when pushing through http git-http-backend gets a stream of object
>> when sending the git-upload-packl command. This stream starts with
>> two object ids and a branch name. Is there a specification about how
>> this streem exactly looks like?
> Have you looked at what's in Documentation/technical in the git.git
> repository? Specifically, protocol-common.txt and pack-protocol.txt
> describe what happens over the regular protocol. The http version of =
the
> protocol just splits that into chunks, but the output that upload-pac=
k
> produces is the same.
>
> You mentioned "pushing", though, which does not involve git-upload-pa=
ck
> at all. Did you mean git-receive-pack? From your description, I guess
> maybe you mean the "command-list" lines sent by send-pack to
> receive-pack? They are defined pack-protocol.txt. See the subsection
> "Reference Update Request and Packfile Transfer" under "Pushing Data =
to
> a Server".
>
> -Peff
