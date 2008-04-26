From: Thomas Koch <thomas@koch.ro>
Subject: Re: git cvsimport problem
Date: Sat, 26 Apr 2008 14:46:44 +0200
Organization: Young Media Concepts
Message-ID: <200804261446.44735.thomas@koch.ro>
References: <48131F1A.3010409@opensourceclub.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alenoosh Baghumian <alenoosh@opensourceclub.org>
X-From: git-owner@vger.kernel.org Sat Apr 26 14:48:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jpjp6-0004sx-0X
	for gcvg-git-2@gmane.org; Sat, 26 Apr 2008 14:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752534AbYDZMrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2008 08:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751779AbYDZMrK
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Apr 2008 08:47:10 -0400
Received: from koch.ro ([195.34.83.107]:45444 "EHLO
	ve825703057.providerbox.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752316AbYDZMrI (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Apr 2008 08:47:08 -0400
Received: from 149-60.62-81.cust.bluewin.ch ([81.62.60.149] helo=jona.local)
	by ve825703057.providerbox.net with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <thomas@koch.ro>)
	id 1Jpjni-0000sc-LE; Sat, 26 Apr 2008 14:46:49 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <48131F1A.3010409@opensourceclub.org>
Content-Disposition: inline
X-Spam_score: -2.4
X-Spam_score_int: -23
X-Spam_bar: --
X-Spam_report: Spam detection software, running on the system "ve825703057.providerbox.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Am Samstag 26 April 2008 14:24:58 schrieb Alenoosh Baghumian:
	> Hi > > I want to import a cvs project , here's what I do : > > 1) cvs check
	out > 2) $ cd cvs-pro > 3) cvs-pro$ git cvsimport -C path/to/destination
	-v > > it starts executing but finally stops with the following error: > git-cvsimport:
	fatal: cvsps reported error > > > what is the problem ? > Am I doing anything
	wrong ? > > Thanks in advance for your help . > > Alenoosh > -- > To unsubscribe
	from this list: send the line "unsubscribe git" in > the body of a mes 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80372>

Am Samstag 26 April 2008 14:24:58 schrieb Alenoosh Baghumian:
> Hi
>
> I want to import a cvs project , here's what I do :
>
> 1)  cvs check out
> 2) $ cd cvs-pro
> 3) cvs-pro$ git cvsimport -C path/to/destination -v
>
> it starts executing but finally stops with the following error:
> git-cvsimport: fatal: cvsps reported error
>
>
> what is the problem ?
> Am I doing anything wrong ?
>
> Thanks in advance for your help .
>
> Alenoosh
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Hi Alenoosh,

git-cvsimport does not run against a checkout of a CVS repo, but against the 
original CVS repo. Most likely this original repo is not on your local 
machine. Be aware, that the import of a large, remote CVS repo can 
run several days.

Googling after git cvsimport will give you some examples.

Best regards,

-- 
Thomas Koch, Software Developer

Young Media Concepts GmbH
Sonnenstr. 4
CH-8280 Kreuzlingen
Switzerland

Tel    +41 (0)71 / 508 24 86
Fax    +41 (0)71 / 560 53 89
Mobile +49 (0)170 / 753 89 16
Web    www.ymc.ch
