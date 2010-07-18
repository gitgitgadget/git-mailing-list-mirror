From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Files used by git config (Re: Challenge with Git-Bash)
Date: Sun, 18 Jul 2010 13:16:19 -0500
Message-ID: <20100718181619.GA14367@burratino>
References: <001d01cb25cb$eb176980$c1463c80$@net>
 <20100717171303.GB10730@burratino>
 <008a01cb26a4$4313e360$c93baa20$@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
To: Rainer Lauer <lauerr@gmx.net>
X-From: git-owner@vger.kernel.org Sun Jul 18 20:17:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaYQd-0000NB-V6
	for gcvg-git-2@lo.gmane.org; Sun, 18 Jul 2010 20:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756863Ab0GRSRU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Jul 2010 14:17:20 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46592 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756859Ab0GRSRT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jul 2010 14:17:19 -0400
Received: by iwn7 with SMTP id 7so3822867iwn.19
        for <git@vger.kernel.org>; Sun, 18 Jul 2010 11:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=31TqOoCwe6uIcf9v7bXfUvE62kqE+Dzg5artu/DsPTI=;
        b=MqkhDK1QL4r72784PQBkb8wQSSc9aljMcyZuF1/cIgI//QS4xhWMRrjRmWYoXkSbDu
         kTkxQ9nW1kJVG+RMwoguhIGYVlUSy21UROzJGhq61Mm6a6w/0yEpvFxbIHUmS/iemTU0
         rT3stRrnSThfbxWg2q/lebO3C+LEuluT7K+r0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=FIXoT9VnUV7a6ld4S5T82jqfwtQ4tTNFibIwA7oWW9KADz1fRd3+VYoHo88yut6Sdk
         ccqBshQrKVtZbqepKcl4kokI1+RB+1e5IzEm8b/g8FPF/+tkev9482AsKYywtMuZA7Hm
         fU7Q/pT4KNUVTGarMRJIsv0oDav98w6rP0TaE=
Received: by 10.231.179.24 with SMTP id bo24mr3444752ibb.193.1279477038787;
        Sun, 18 Jul 2010 11:17:18 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 34sm21029963ibi.6.2010.07.18.11.17.17
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 18 Jul 2010 11:17:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <008a01cb26a4$4313e360$c93baa20$@gmx.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151229>

Hi again,

Rainer Lauer wrote:

> Where is following information stored?
> Command:  git config --global user.name=3D"Rainer Lauer".

I recommend looking that the user manual[1] to start out.  It
has a few relevant hints.

=46rom the preface:

	Comprehensive reference documentation is available
	through the man pages, or git-help(1) command. For
	example, for the command "git clone <repo>", you can
	either use:

	$ man git-clone

	or:

	$ git help clone

=46rom the start to =E2=80=9Cchapter 3: developing with git=E2=80=9D:

	Before creating any commits, you should introduce
	yourself to git. The easiest way to do so is to make sure
	the following lines appear in a file named .gitconfig in
	your home directory:

	[user]
		name =3D Your Name Comes Here
		email =3D you@yourdomain.example.com

	(See the "CONFIGURATION FILE" section of git-config(1)
	for details on the configuration file.)

Regards,
Jonathan

[1] http://kernel.org/pub/software/scm/git/docs/user-manual.html
