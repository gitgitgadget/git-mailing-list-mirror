From: Eric Raible <raible@nextest.com>
Subject: Re: Re: Re: Why the default action for pull is merge, but not rebase?
Date: Wed, 27 Oct 2010 12:30:46 -0700
Message-ID: <4CC87DE6.9090604@nextest.com>
References: <20101027173644.GB15657@burratino> <0016e645b8c87a160804939cdc5e@google.com> <20101027180541.GA20527@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <Euguess@gmail.com>, <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 27 21:30:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBBi3-0005TA-7c
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 21:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756150Ab0J0Tas convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 15:30:48 -0400
Received: from mail.nextest.com ([12.96.234.114]:27494 "EHLO
	Exchange.DOMAIN1.nextest.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755806Ab0J0Tar (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Oct 2010 15:30:47 -0400
Received: from [131.101.151.88] (131.101.151.88) by
 Exchange.DOMAIN1.nextest.com (131.101.21.39) with Microsoft SMTP Server (TLS)
 id 8.2.254.0; Wed, 27 Oct 2010 12:30:46 -0700
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.9) Gecko/20100915 Lightning/1.0b2 Thunderbird/3.1.4
In-Reply-To: <20101027180541.GA20527@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160117>

On 11:59 AM, Jonathan Nieder wrote:
> Eugene Sajine wrote:
>=20
>> So, I just have to run git pull --rebase to get my scenario working,=
 right?
>=20
> Maybe the =E2=80=9C[branch "<name>"] rebase=E2=80=9D and =E2=80=9C[br=
anch] autosetuprebase=E2=80=9D
> configuration items could help.

One frustrating aspect of branch.<name>.rebase is that AFAIK
there's no way for it to preserve merges.

I would much prefer if branch.<name>.rebase was allowed to
specify the arguments to be passed to rebase:

	git config branch.mybranch.rebase "-i --preserve-merges"

Anyone else see the value of something like this?
