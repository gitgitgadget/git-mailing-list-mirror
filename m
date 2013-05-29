From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH RESEND v2] path: Fix a sparse warning
Date: Wed, 29 May 2013 15:46:08 +0200
Message-ID: <51A606A0.5060101@web.de>
References: <51A3B308.6000201@ramsay1.demon.co.uk> <7vhahn2fz2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>, tboegi@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 29 15:46:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhghp-000369-OF
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 15:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966048Ab3E2NqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 09:46:12 -0400
Received: from mout.web.de ([212.227.15.3]:52554 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935131Ab3E2NqL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 09:46:11 -0400
Received: from [192.168.209.26] ([195.67.191.23]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0MbQbk-1UyFeO1q20-00IwOn; Wed, 29 May 2013 15:46:08
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <7vhahn2fz2.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:YYLjmutON5dCEuJziDUuBLVu6yO6e04zadh0EsfWaL9
 lRpxZ4Qgy+fBnvqXL2sxeHKXotCJHYitt50p4JR4mrxurfYCsu
 GzbhN3wu+ssc2jon5Mj2t8MKmkrQ09vYg6bvi0+rIrxtQZ+n/U
 osQmOYGWIH2iITbfpL2gnaKrRaeaYec8cVvhrK+wiKTDtnuEvC
 wDYKkgnD58tqUux3DTwKw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225824>

On 2013-05-28 19.04, Junio C Hamano wrote:
> 
> Can you tell me what the conclusion on the discussion on your two
> other patches on 'pu'?
> 
> * rj/mingw-cygwin (2013-05-08) 2 commits
>  - cygwin: Remove the CYGWIN_V15_WIN32API build variable
>  - mingw: rename WIN32 cpp macro to GIT_WINDOWS_NATIVE
> 
> I stopped keeping track of the discussion and my vague recollection
> was that it is OK for 1.5 but not verified on 1.7 or something?
> 

The tests I did under cygwin 1.7 did not show any regression.
/Torsten
