From: Christian Stimming <stimming@tuhh.de>
Subject: gitk still interested in translations?
Date: Sun, 21 Oct 2007 14:54:22 +0200
Message-ID: <200710211454.23143.stimming@tuhh.de>
References: <20070727165318.e96b1yxxwsooo884@webmail.tu-harburg.de> <20070727170300.t01ku4u2sg04sgsk@webmail.tu-harburg.de> <18090.44123.905869.974967@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Oct 21 15:00:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjaPT-0002Sy-72
	for gcvg-git-2@gmane.org; Sun, 21 Oct 2007 15:00:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834AbXJUM7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2007 08:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751829AbXJUM7v
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Oct 2007 08:59:51 -0400
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:35583 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751804AbXJUM7u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2007 08:59:50 -0400
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l9LCxJfk026057
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Sun, 21 Oct 2007 14:59:20 +0200
Received: from [192.168.2.102] (p549028DD.dip0.t-ipconnect.de [84.144.40.221])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id l9LCxI6j029723
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 21 Oct 2007 14:59:19 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <18090.44123.905869.974967@cargo.ozlabs.ibm.com>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61901>

Hi Paul,

in July I submitted patches to add the necessary framework for UI 
translations/i18n to the gitk tool [1] [2], and I'd also volunteer to provide 
a full German translation. As you pointed out [3], this would require some 
decisions on integration and installation places, which according to Junios 
reply [4] didn't seem too difficult.

What is the progress on your i18n plans in gitk? None of the patches had been 
applied to gitk, have they? If you say you *are* interested, I'd be happy to 
provide an up-to-date patch against gitk.git @ kernel.org for #1 Makefile 
rules, #2 msgcat integration, and most importantly #3 message markup.

Christian

[1] http://marc.info/?l=git&m=118554802809395&w=2
[2] http://marc.info/?l=git&m=118554865029767&w=2
[3] http://marc.info/?l=git&m=118559040716553&w=2
[4] http://marc.info/?l=git&m=118559853016496&w=2

Am Samstag, 28. Juli 2007 04:39 schrieb Paul Mackerras:
> Christian Stimming writes:
> > Similar to the discussion in git-gui, all user-visible strings are
> > passed through the [mc ...] procedure to have them translated by msgcat.
> >
> > Signed-off-by: Christian Stimming <stimming@tuhh.de>
> > ---
> > @Paul: Are you interested in applying this? If yes, I'd happily
>
> Yes, it doesn't look too bad.  The patch seemed to be line-wrapped and
> whitespace-damaged, though.
>
> > provide the Makefile rules for string extraction and translation
> > catalog updates, but I'd like to hear a proposal or decision on where
> > to place them. Should the po files for translation go into the po/
> > subdirectory? And then a proposal/decision of where to install the
> > compiled .msg catalogs will be necessary.
>
> Yes indeed.  Junio?
>
> Is it possible to include the translations, or at least the more
> common translations, in the Tcl code itself?  So far I have managed to
> have gitk be self-contained, in that it doesn't need any external data
> files, which simplifies installation and is a useful attribute in some
> situations.
>
> Also I would want to be sure that gitk wouldn't crash or fail to
> function if it can't find its message catalogs.
>
> Paul.
