From: Tony Finch <dot@dotat.at>
Subject: Re: [PATCH v2] git-prompt: preserve value of $? inside shell
 prompt
Date: Wed, 14 Jan 2015 10:05:56 +0000
Message-ID: <alpine.LSU.2.00.1501141003400.23307@hermes-1.csi.cam.ac.uk>
References: <xmqqa92fbo0j.fsf@gitster.dls.corp.google.com> <alpine.LSU.2.00.1412221808110.2546@hermes-1.csi.cam.ac.uk> <20150114005726.Horde.idyLC0Or9SvaghEN_N_pRg1@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1870869256-2065834300-1421229956=:23307"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Jan 14 11:06:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBKq4-0000gN-PM
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 11:06:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752732AbbANKGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 05:06:00 -0500
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:47301 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744AbbANKF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 05:05:59 -0500
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-1.csi.cam.ac.uk ([131.111.8.51]:44434)
	by ppsw-50.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.158]:25)
	with esmtpa (EXTERNAL:fanf2) id 1YBKpo-0001g0-q5 (Exim 4.82_3-c0e5623)
	(return-path <fanf2@hermes.cam.ac.uk>); Wed, 14 Jan 2015 10:05:56 +0000
Received: from fanf2 by hermes-1.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1YBKpo-0006kM-1h (Exim 4.72)
	(return-path <fanf2@hermes.cam.ac.uk>); Wed, 14 Jan 2015 10:05:56 +0000
X-X-Sender: fanf2@hermes-1.csi.cam.ac.uk
In-Reply-To: <20150114005726.Horde.idyLC0Or9SvaghEN_N_pRg1@webmail.informatik.kit.edu>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262370>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1870869256-2065834300-1421229956=:23307
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

SZEDER G=C3=A1bor <szeder@ira.uka.de> wrote:
>
> Makes sense, but the patch doesn't cover all cases, because
> __git_ps1() can exit early

Thanks for looking at the patch. I feel quite silly for missing the other
return points :-( Follow-up patch on the way...

Tony.
--=20
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
Faeroes, Southeast Iceland: Cyclonic for a time in Faeroes, otherwise
northeasterly 6 to gale 8, increasing gale 8 to storm 10. Very rough or hig=
h.
Rain, snow or wintry showers. Moderate or poor, occasionally very poor.
--1870869256-2065834300-1421229956=:23307--
