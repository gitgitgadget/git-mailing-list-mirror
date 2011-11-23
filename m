From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: Possible bug with branch names and case sensitivity
Date: Wed, 23 Nov 2011 15:08:36 -0700
Message-ID: <4ECD6EE4.6080702@workspacewhiz.com>
References: <D144F6C9-C6A3-4516-BC88-B9EB50890EF4@bitart.com> <CAG+J_Dz6nK5fPhBRmoojmgYSv5OviN7pfgNKnRy9_9WmDS1_2w@mail.gmail.com> <4ECB315F.4080701@alum.mit.edu> <CAG+J_DxREbykWggrD49L7qvR9M36wKL7+_kOYbvcWmLBCF2Gog@mail.gmail.com> <CACBZZX4qs8-u33bZbrxYS1CrwjTQc=4YOk2SUjtYzL=vc9KYgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Gerd Knops <gerti@bitart.com>, git@vger.kernel.org
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 23 23:07:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTKyf-0008Q1-Hk
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 23:07:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756353Ab1KWWHe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Nov 2011 17:07:34 -0500
Received: from hsmail.qwknetllc.com ([208.71.137.138]:48016 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756343Ab1KWWHd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 17:07:33 -0500
Received: (qmail 25685 invoked by uid 399); 23 Nov 2011 15:07:27 -0700
Received: from unknown (HELO ?192.168.1.109?) (jjensen@workspacewhiz.com@67.171.115.152)
  by hsmail.qwknetllc.com with ESMTPAM; 23 Nov 2011 15:07:27 -0700
X-Originating-IP: 67.171.115.152
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <CACBZZX4qs8-u33bZbrxYS1CrwjTQc=4YOk2SUjtYzL=vc9KYgA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185881>

----- Original Message -----
=46rom: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
Date: 11/23/2011 1:50 PM
>
>
> Note that Git doesn't only have confusing behavior with refs on
> case-insensitive filesystems. The other day HFS+ users @ work had
> issues because of a case collision in the checked out tree, which
> confused git status et al.
Is core.ignorecase set to true?  Is the repository shared with a case=20
sensitive file system?

I have a patch sitting around for 'git update-index --add' that fixes=20
some case insensitivity issues, especially when using Git Gui.  This=20
patch complements the core.ignorecase patches I sent in the past.

-Josh
