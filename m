From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: bug with .git file and aliases
Date: Mon, 20 Jul 2009 17:18:28 +0200
Message-ID: <adf1fd3d0907200818l429e701ds6a42ec49f02d5ba9@mail.gmail.com>
References: <7f9d599f0907200654q2e068e6aq3051c122f6596053@mail.gmail.com>
	 <adf1fd3d0907200704sb097a99h1ab8f118be5854f9@mail.gmail.com>
	 <7f9d599f0907200727v5b258a73n3fa664f134c0eead@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>
To: Geoffrey Irving <irving@naml.us>
X-From: git-owner@vger.kernel.org Mon Jul 20 17:18:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSudQ-0007uN-2e
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 17:18:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbZGTPSa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Jul 2009 11:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbZGTPS3
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 11:18:29 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:28770 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbZGTPS2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jul 2009 11:18:28 -0400
Received: by an-out-0708.google.com with SMTP id d40so3695695and.1
        for <git@vger.kernel.org>; Mon, 20 Jul 2009 08:18:28 -0700 (PDT)
Received: by 10.100.249.5 with SMTP id w5mr6323141anh.28.1248103108464; Mon, 
	20 Jul 2009 08:18:28 -0700 (PDT)
In-Reply-To: <7f9d599f0907200727v5b258a73n3fa664f134c0eead@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123609>

2009/7/20 Geoffrey Irving <irving@naml.us>:
> On Mon, Jul 20, 2009 at 10:04 AM, Santi B=E9jar<santi@agolina.net> wr=
ote:
>> I suspect that the $GIR_DIR and .git file works equally in this
>> aspect, so you should specify where is the workdir in .git/config wi=
th
>> respect the repository:
>>
>> git config core.workdir `pwd`
>
> Nope, that has no effect.

Here it has the desired effect. From where did you run the above
command? What is the output of:

git config core.workdir

?

It should output the path of the repo, not of the "a" subdirectory.

HTH,
Santi
