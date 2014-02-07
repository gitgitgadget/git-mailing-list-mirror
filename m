From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [WIP/PATCH 2/9] Teach reset the --[no-]recurse-submodules option
Date: Fri, 07 Feb 2014 22:09:00 +0100
Message-ID: <52F54B6C.7040906@web.de>
References: <xmqqd2k4hh4p.fsf@gitster.dls.corp.google.com>	<52CC3E16.4060909@web.de>	<xmqqvbxvekwv.fsf@gitster.dls.corp.google.com>	<52EFF25E.6080306@web.de> <52EFF2C5.3090705@web.de> <xmqqd2j3ddlw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"W. Trevor King" <wking@tremily.us>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 07 22:09:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBsfe-0007kN-GP
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 22:09:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436AbaBGVJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Feb 2014 16:09:05 -0500
Received: from mout.web.de ([212.227.15.14]:63207 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752140AbaBGVJE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Feb 2014 16:09:04 -0500
Received: from [192.168.178.41] ([84.132.186.180]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0Lba35-1VWWEH1E1z-00lErj for <git@vger.kernel.org>;
 Fri, 07 Feb 2014 22:09:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <xmqqd2j3ddlw.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:dvOswQMZYl/OFauPQhlsb63slNlfLDoYPoA93xrNvVbNW1iTOdT
 s3E8+Ry68wzd+M7HHZYIWUrfV58MHcxGzZFHMDbH6wI7yZCHBDeWse9HYg4GzlEXiPWQesT
 4Isz2reEcGGFX0FnNIcqKs2BKCjO27XuTAd8zsyhk0q4ierhJH6Yh/+8GPiVLUThumV2cbi
 RWa8E6dZU7a2o1bF+mt+g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241799>

Am 03.02.2014 23:40, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> This new option will allow the user to not only reset the work tree of
>> the superproject but to also update the work tree of all initialized
>> submodules (so they match the SHA-1 recorded in the superproject) when
>> used together with --hard or --merge. But this commit only adds the
> 
> I agree that --soft and --mixed should not do anything.  I am not
> sure why --keep should not do anything to submodule working trees
> when asked to recurse, though.

Correct, I missed that option. I think it should update submodules
too.
