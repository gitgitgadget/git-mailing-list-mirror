From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC PATCH] Fix gitdir detection when in subdir of gitdir
Date: Fri, 16 Jan 2009 17:50:45 +0100
Message-ID: <4970BAE5.8080006@viscovery.net>
References: <1232120253-1551-1-git-send-email-szeder@ira.uka.de> <alpine.DEB.1.00.0901161729070.3586@pacific.mpi-cbg.de> <4970BA2B.7090807@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 16 17:52:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNrvb-0004pB-Is
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 17:52:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756186AbZAPQuv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Jan 2009 11:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934786AbZAPQuu
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 11:50:50 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:8256 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762678AbZAPQus convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jan 2009 11:50:48 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LNruA-0005du-7z; Fri, 16 Jan 2009 17:50:46 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id F33A86C4; Fri, 16 Jan 2009 17:50:45 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <4970BA2B.7090807@viscovery.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105976>

Johannes Sixt schrieb:
> G=C3=A1bor's patch needs a better justification which misbehavior it =
tries to
> fix, and the spot that it changes:

I actually meant: "which use-case the patch tries to help". Because the
current behavior can hardly be classified as bug. ("You have no busines=
s
cd-ing around in .git." ;)

-- Hannes
