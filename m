From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Master branch not updating
Date: Mon, 22 Mar 2010 18:17:52 +0100
Message-ID: <4BA7A640.1080207@viscovery.net>
References: <295c22191003220943o2ef330ddk58a8180411ddbb2b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jacopo Pecci <jacopo.pecci@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 18:18:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtlGJ-0006uY-Lz
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 18:18:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755038Ab0CVRR5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Mar 2010 13:17:57 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:48583 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755011Ab0CVRRz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Mar 2010 13:17:55 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NtlGD-0003Qy-DS; Mon, 22 Mar 2010 18:17:53 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 2AFF01660F;
	Mon, 22 Mar 2010 18:17:53 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <295c22191003220943o2ef330ddk58a8180411ddbb2b@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142950>

Am 3/22/2010 17:43, schrieb Jacopo Pecci:
> Then I have tried =93checkout master branch=94, suddenly all the comm=
its
> in between the one labelled [master] and the latest one vanished. I
> have not been able to get back.
>=20
> I am terribly afraid I have lost 4 day work. Do you have any
> suggestion? How is it possible that something which I have committed
> is not retrievable anymore.

1. Don't panic.

2. Make a backup copy, *including* the .git directory (very important!)

The .git directory contains your 4 day work, and it is very likely stil=
l
retrievable.

It may be a simple matter of

   git branch the-lost-state HEAD@{1}

If you can't work on a command line, then git extensions certainly has
some nice UI that lets you create a branch at a particular revision. In
this case, the branch name is "the-lost-state", and the revision is HEA=
D@{1}.

You can try more branch names at HEAD@{2}, HEAD@{3} (you get the point)=
=2E
It means, roughly, "the state where HEAD was 1, 2, 3, etc. git operatio=
ns
ago".

-- Hannes
