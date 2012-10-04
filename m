From: =?UTF-8?Q?Romain_Vimont_=28=C2=AEom=29?= <rom@rom1v.com>
Subject: Re: git commit --amen
Date: Thu, 04 Oct 2012 16:38:22 +0200
Message-ID: <ace0aa63d5e822c6cdd5d9a3d20bd675@rom1v.com>
References: <0d559e3191a392841124d96870a67735@rom1v.com>
 <CABURp0rbNZSOC_Jtxfjp+j3SQR=+r0pU6vOXvc0Jnth0UU9mDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:29:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtZo-0001w8-FL
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:07:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965289Ab2JDOh4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Oct 2012 10:37:56 -0400
Received: from rom1v.com ([78.236.177.60]:42990 "EHLO rom1v.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965229Ab2JDOhy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 10:37:54 -0400
Received: by rom1v.com (Postfix, from userid 33)
	id 346511193; Thu,  4 Oct 2012 16:38:22 +0200 (CEST)
X-PHP-Originating-Script: 1000:main.inc
In-Reply-To: <CABURp0rbNZSOC_Jtxfjp+j3SQR=+r0pU6vOXvc0Jnth0UU9mDA@mail.gmail.com>
X-Sender: rom@rom1v.com
User-Agent: Roundcube Webmail/0.8.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207005>

Great !
Thank you for your answer ;-)

It does not seem to work with git diff:
git diff --cache     #missing d
git diff --cumulativ #missing e

=C2=AEom

Le 2012-10-04 16:25, Phil Hord a =C3=A9crit=C2=A0:
>> Is it normal that "git commit --amen" actually works ?
>> (it does like --amend)
>>
>> version 1.7.10.4
>
> Yes.  From Documentation/technical/api-parse-options.txt:
>
>     * Long options may be 'abbreviated', as long as the abbreviation
>       is unambiguous.
>
> Apparently since 2008-06-22.
>
> So 'git commit --am' also works.  But it should probably be avoided
> because of its similarity to 'git commit -am'.
>
> Phil
