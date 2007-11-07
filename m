From: Christian Stimming <stimming@tuhh.de>
Subject: Re: [PATCH 1/9] gitk i18n implementation: Add Makefile with rules for po file creation and installation.
Date: Wed, 7 Nov 2007 23:18:46 +0100
Message-ID: <200711072318.46846.stimming@tuhh.de>
References: <200711071839.08570.stimming@tuhh.de> <7vbqa5ag7s.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 07 22:47:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpskX-00028o-M8
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 22:47:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754954AbXKGVrd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 16:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754925AbXKGVrd
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 16:47:33 -0500
Received: from smtp3.rz.tu-harburg.de ([134.28.202.138]:52498 "EHLO
	smtp3.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754879AbXKGVrc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 16:47:32 -0500
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp3.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id lA7Ll9D7013160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 7 Nov 2007 22:47:09 +0100
Received: from [192.168.2.102] (p54900614.dip0.t-ipconnect.de [84.144.6.20])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id lA7Ll7RZ029792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 7 Nov 2007 22:47:08 +0100
User-Agent: KMail/1.9.5
In-Reply-To: <7vbqa5ag7s.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.138
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63865>

Am Mittwoch, 7. November 2007 22:38 schrieb Junio C Hamano:
> Christian Stimming <stimming@tuhh.de> writes:
> > The compiled .msg files will be installed into $(sharedir)/gitk/lib/msgs
> > according to Junio's mailing list proposal on 2007-07-28.
> > ---
> > These patches are against master of gitk.git at git.kernel.org.
> >
>
> There is a slight issue of merging this into git.git, as the
> initial "coolest merge ever" was done with the understanding
> that gitk will remain a single file project.
>
> The simplest way without using submodule (because it would
> require everybody who follow git.git to update to 1.5.3 or
> later, which I'd rather not to do at this point yet) would be to
> merge gitk.git with the subtree strategy to a subdirectory,
> which I think will be what I'll end up doing.

Yes, merging with subtree strategy to a subdirectory was exactly what you 
proposed here http://marc.info/?l=git&m=118559853016496&w=2 and Paul agreed 
upon here http://marc.info/?l=git&m=118560371427209&w=2 .

Regards,

Christian
