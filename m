From: Chris Cinelli <chris.cinelli@formativelearning.com>
Subject: Bug in git svn fetch
Date: Mon, 16 Jan 2012 13:04:00 -0800
Message-ID: <CAM1GFk2zioi10M4HjyOF3a8_Ec23V9URPAAnRzp4xABSjKxZ+g@mail.gmail.com>
References: <CAM1GFk0bXTC2YUigJnB2wa4EKHOJ8oO8Sk=8+dApqkXH2_SP+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 22:04:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rmtir-0004FC-1f
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 22:04:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756675Ab2APVED convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Jan 2012 16:04:03 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:39616 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754889Ab2APVEB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jan 2012 16:04:01 -0500
Received: by vcbfo1 with SMTP id fo1so1340224vcb.19
        for <git@vger.kernel.org>; Mon, 16 Jan 2012 13:04:01 -0800 (PST)
Received: by 10.220.227.72 with SMTP id iz8mr8480567vcb.53.1326747840997; Mon,
 16 Jan 2012 13:04:00 -0800 (PST)
Received: by 10.52.29.13 with HTTP; Mon, 16 Jan 2012 13:04:00 -0800 (PST)
X-Originating-IP: [64.236.138.1]
In-Reply-To: <CAM1GFk0bXTC2YUigJnB2wa4EKHOJ8oO8Sk=8+dApqkXH2_SP+Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188653>

We are trying to move from SVN to GIT but we are having problems

git --version
git version 1.7.9.rc1

I updated because I had the same problem also with version 1.7.5 (just
different line number)

Running command: git svn fetch
=46ound possible branch point: http://our_server/svn/FUL/trunk =3D>
http://our_server/svn/FUL/tags/2011_11_26_1223AM, 822
Use of uninitialized value $u in substitution (s///) at
/usr/libexec/git-core/git-svn line 2097.
Use of uninitialized value $u in concatenation (.) or string at
/usr/libexec/git-core/git-svn line 2097.
refs/remotes/svn/trunk: 'http://our_server/svn/FUL' not found in ''

The folder=A0tags/2011_11_26_1223AM was created with SVN copy. It may
also be deleted and recreated above with the same name.

I hope it is an easy fix.

Best,
=A0 =A0Chris

--Everything should be made as simple as possible, but not simpler
(Albert Einstein)
