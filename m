From: Christophe de Dinechin <christophe@dinechin.org>
Subject: Re: Memory of past repositories in git remote?
Date: Wed, 25 Mar 2009 15:51:40 +0100
Message-ID: <D264AF56-72BB-4658-9DD6-DAC10E3CADBC@dinechin.org>
References: <784F93DB-2D7C-4F48-88E8-BF56F01CD1E2@dinechin.org> <adf1fd3d0903250505o38e0ac54jcf07f4425eee0a6@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christophe de Dinechin <christophe@dinechin.org>,
	Christophe de Dinechin <christophe.de.dinechin@gmail.com>,
	git@vger.kernel.org
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Wed Mar 25 15:54:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmUV7-0000ge-C4
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 15:54:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756440AbZCYOxJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Mar 2009 10:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754981AbZCYOxH
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 10:53:07 -0400
Received: from smtpfb2-g21.free.fr ([212.27.42.10]:50581 "EHLO
	smtpfb2-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbZCYOxG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Mar 2009 10:53:06 -0400
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id 55125D80791
	for <git@vger.kernel.org>; Wed, 25 Mar 2009 15:52:57 +0100 (CET)
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id AB7D44C8002;
	Wed, 25 Mar 2009 15:51:44 +0100 (CET)
Received: from [10.10.10.22] (val06-1-88-182-161-34.fbx.proxad.net [88.182.161.34])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 4FCB44C811F;
	Wed, 25 Mar 2009 15:51:41 +0100 (CET)
In-Reply-To: <adf1fd3d0903250505o38e0ac54jcf07f4425eee0a6@mail.gmail.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114604>

Yep, that was it. I didn't realize that $url.git was being tested first=
=2E

Thanks
Christophe

On 25 mars 09, at 13:05, Santi B=E9jar wrote:

> 2009/3/25 Christophe de Dinechin <christophe.de.dinechin@gmail.com>:
>> Here are the details. I created a git repository in /home/ddd/vmm, =20
>> impored
>> some Subversion history, and started working with that. I created a =
=20
>> few
>> branches, e.g. one called "perrier". Then, I realized that there =20
>> was a
>> better way to track Subversion changes, and so I moved the old =20
>> repository as
>> /home/ddd/vmm.git, and created a new one that I populated with "git =
=20
>> svn
>> clone svn+ssh://path/to/repot -T trunk -b branches -t users". That =20
>> new
>> repository has no branch named "perrier" in it.
>
> Git tries different url: $url/.git, $url.git and $url (I'm not sure
> about the order).
>
> So having $url and $url.git is asking for problems. I don't know if i=
t
> is documented somewhere.
>
> HTH,
> Santi
