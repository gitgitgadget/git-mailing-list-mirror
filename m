From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: Re: [BUG?] "git rebase --interactive" forces me to edit message.
Date: Sat, 07 Jun 2008 06:46:33 +0900
Message-ID: <200806062147.m56LlCOd030269@mi0.bluebottle.com>
References: <alpine.DEB.1.00.0806050536380.21190@racer> <200806050358.m553wgK9013230@mi0.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 06 23:48:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4jn6-0003BL-73
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 23:48:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759356AbYFFVrO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Jun 2008 17:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757817AbYFFVrO
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 17:47:14 -0400
Received: from mi0.bluebottle.com ([206.188.25.15]:49159 "EHLO
	mi0.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757361AbYFFVrN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 17:47:13 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi0.bluebottle.com (8.13.1/8.13.1) with ESMTP id m56LlCOd030269
	for <git@vger.kernel.org>; Fri, 6 Jun 2008 14:47:12 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:subject:date:in-reply-to:references:
	mime-version:content-type:content-transfer-encoding:x-trusted-delivery;
	b=cLXY0uwrPfTugm1oIm23dbsksJWx+22YIW086V/hGh1OQsh5/Q2IQ+t5eAZlQcfIM
	SBh9+yEhmkYeTHegYsg9hHM4zLg4CM//aiA5YgtvUhq5n8uJ1StVhjhGgQd2tFJ
Received: from nanako3.mail.bluebottle.com ([212.62.97.21])
	(authenticated bits=0)
	by fe1.bluebottle.com (8.13.1/8.13.1) with ESMTP id m56Ll4uu026134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 6 Jun 2008 14:47:09 -0700
In-Reply-To: <alpine.DEB.1.00.0806050536380.21190@racer>
X-Trusted-Delivery: <d0f10ba480c41f0f38d8588850516744>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84120>

Quoting Johannes Schindelin <Johannes.Schindelin@gmx.de>:

> Hi,
>
> On Thu, 5 Jun 2008, =E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=
=AA=E3=81=93 wrote:
>
>> When an interactive rebase stops because of conflicts in a commit ma=
rked=20
>> with pick, the user must edit the file to resolve them, run "git add=
",=20
>> and run "git rebase --continue".  It then opens vi and asks the user=
 to=20
>> edit the message.  If I told the command to edit, I think it is OK t=
o=20
>> start vi, but when I am just picking the commit, I should be able to=
 use=20
>> the message from the original commit without having to view nor edit=
 nor=20
>> save it first. Is this a bug?
>
> No, it is intentional.
>
> If you have to edit, because of conflicts, it may be because _part_ o=
f the=20
> commit ended up in upstream already.
>
> To remind the user that the commit message may need to be adjusted, r=
ebase=20
> --interactive fires up the editor.
>
> Yes, it happened to me.  Yes, the reminder was helpful.
>
> Hth,
> Dscho

Thank you very much.  I think I understand the problem better with your=
 explanation (and much more detailed explanation from Junio).

But I started wondering (especially after read Junio's example) if you =
might have to stop and force edit the message even for commits you "pic=
k", once you have a conflict.  The patch might not conflict, but  with =
your logic shouldn't you be given a chance to amend messages, now it wa=
s discovered that the upstream did change that overlaps what you did?

--=20
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
=46inally - A spam blocker that actually works.
http://www.bluebottle.com/tag/4
