From: Chris Cinelli <chris.cinelli@formativelearning.com>
Subject: Re: Bug in git svn fetch
Date: Mon, 16 Jan 2012 13:29:56 -0800
Message-ID: <CAM1GFk26WCdZM16OUWbOEMYp8vsuU7nD6L25W08-bpSC2PjfrQ@mail.gmail.com>
References: <CAM1GFk0bXTC2YUigJnB2wa4EKHOJ8oO8Sk=8+dApqkXH2_SP+Q@mail.gmail.com>
	<CAM1GFk2zioi10M4HjyOF3a8_Ec23V9URPAAnRzp4xABSjKxZ+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 22:30:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rmu7u-0000KX-M7
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 22:30:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755304Ab2APV36 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Jan 2012 16:29:58 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:38838 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754167Ab2APV35 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jan 2012 16:29:57 -0500
Received: by vcbfo1 with SMTP id fo1so1355444vcb.19
        for <git@vger.kernel.org>; Mon, 16 Jan 2012 13:29:57 -0800 (PST)
Received: by 10.52.69.51 with SMTP id b19mr7169876vdu.9.1326749396947; Mon, 16
 Jan 2012 13:29:56 -0800 (PST)
Received: by 10.52.29.13 with HTTP; Mon, 16 Jan 2012 13:29:56 -0800 (PST)
X-Originating-IP: [64.236.138.1]
In-Reply-To: <CAM1GFk2zioi10M4HjyOF3a8_Ec23V9URPAAnRzp4xABSjKxZ+g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188658>

More details:

The previous commands were (I am using svn2git):

git svn init --prefix=3Dsvn/ --username=3Dchris --no-metadata
--trunk=3Dtrunk --tags=3Dtags --branches=3Dbranches
http://our_server/svn/FL/trunk/
git config --local svn.authorsfile authors_file

The process failed before using http://our_server/svn/FL (instead of
http://our_server/svn/FL/trunk)

We are not sure but it is very likely that on SVN we did a SVN copy,
then and SVN delete and again an SVN copy on the same folder.
I hope this help.

Best,
    Chris

http://www.mail-archive.com/git@vger.kernel.org/

On Mon, Jan 16, 2012 at 1:04 PM, Chris Cinelli
<chris.cinelli@formativelearning.com> wrote:
> We are trying to move from SVN to GIT but we are having problems
>
> git --version
> git version 1.7.9.rc1
>
> I updated because I had the same problem also with version 1.7.5 (jus=
t
> different line number)
>
> Running command: git svn fetch
> Found possible branch point: http://our_server/svn/FUL/trunk =3D>
> http://our_server/svn/FUL/tags/2011_11_26_1223AM, 822
> Use of uninitialized value $u in substitution (s///) at
> /usr/libexec/git-core/git-svn line 2097.
> Use of uninitialized value $u in concatenation (.) or string at
> /usr/libexec/git-core/git-svn line 2097.
> refs/remotes/svn/trunk: 'http://our_server/svn/FUL' not found in ''
>
> The folder=A0tags/2011_11_26_1223AM was created with SVN copy. It may
> also be deleted and recreated above with the same name.
>
> I hope it is an easy fix.
>
> Best,
> =A0 =A0Chris
>
> --Everything should be made as simple as possible, but not simpler
> (Albert Einstein)



--=20
--Everything should be made as simple as possible, but not simpler
(Albert Einstein)
