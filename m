From: Christian Stimming <stimming@tuhh.de>
Subject: Re: What's in git.git (stable frozen)
Date: Mon, 7 Jan 2008 23:05:58 +0100
Organization: Alumni Technische =?iso-8859-1?q?Universit=E4t?= Hamburg-Harburg
Message-ID: <200801072305.59425.stimming@tuhh.de>
References: <20071022061115.GR14735@spearce.org> <7vhchq11n2.fsf@gitster.siamese.dyndns.org> <18306.41093.376963.228802@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Jan 07 23:08:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JC08a-0004X4-P5
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 23:08:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754271AbYAGWHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 17:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753614AbYAGWHg
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 17:07:36 -0500
Received: from smtp1.rz.tu-harburg.de ([134.28.202.166]:59444 "EHLO
	smtp1.rz.tu-harburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766AbYAGWHf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 17:07:35 -0500
Received: from mail2.rz.tu-harburg.de (mail2.rz.tu-harburg.de [134.28.202.179])
	by smtp1.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m07M7LQG013062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 7 Jan 2008 23:07:21 +0100
Received: from [192.168.2.102] (p54900BDF.dip0.t-ipconnect.de [84.144.11.223])
	(user=alucst mech=LOGIN bits=0)
	by mail2.rz.tu-harburg.de (8.13.8/8.13.8) with ESMTP id m07M7Jle017012
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 7 Jan 2008 23:07:20 +0100
User-Agent: KMail/1.9.5
In-Reply-To: <18306.41093.376963.228802@cargo.ozlabs.ibm.com>
Content-Disposition: inline
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.166
X-Scanned-By: TUHH Rechenzentrum content checker on 134.28.202.179
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69820>

Am Montag, 7. Januar 2008 22:58 schrieb Paul Mackerras:
> I'd like you to do a pull from the gitk.git master branch, but it
> looks to me like there will be a conflict on the Makefile.
> Unfortunately the Makefile that Christian Stimming gave me along with
> the i18n changes is quite different from the one you currently have in
> the gitk-git subdirectory.  I'm not quite sure what to suggest since
> it isn't clear to me exactly what Christian's Makefile (which doesn't
> actually work) is trying to do.  

The Makefile from me was merely a placeholder where the i18n programs should 
work, but it was clear that the installation rules need to be defined 
differently anyway.

> I guess the best thing would be to 
> copy your Makefile over and then add the i18n stuff.

Yes. I've just sent you a patch that does exactly this - that was what I 
thought, too.

> Apart from the i18n changes, there is one more commit (b039f0a6) that
> improves the appearance slightly when running under Tk8.5.

Are you going to release a i18n-enabled gitk sometime soon? If yes, you should 
consider notifying the translator(s) a few days in advance so that they can 
finalize their translations, in case they want to avoid a half-translated 
program to be shipped. Thanks a lot.

Christian
