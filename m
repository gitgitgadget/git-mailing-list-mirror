From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v3 3/5] submodule.c: add .gitmodules staging helper functions
Date: Wed, 31 Jul 2013 01:13:05 +0200
Message-ID: <51F84881.9040204@web.de>
References: <51F8187F.7040603@web.de> <51F8190A.3030002@web.de> <7vsiyvvidl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 31 01:13:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4J6R-0007NU-Tj
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 01:13:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758261Ab3G3XNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jul 2013 19:13:12 -0400
Received: from mout.web.de ([212.227.15.4]:50420 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758216Ab3G3XNL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 19:13:11 -0400
Received: from [192.168.178.41] ([79.193.94.161]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0LbroC-1UNaMr22dw-00jG88 for <git@vger.kernel.org>;
 Wed, 31 Jul 2013 01:13:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <7vsiyvvidl.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:56UB2r89syOd0eWCfQ62xXRStC+gFrV7Bg6+8uhzJQTP50cyGLf
 hjx21IvZAd2gJ5RpZHuZbcnsF2y1f1Bhh0i+4+nowkhV+H6LsvLjszoFX30RhHD62lFDBbp
 RM8Xg/HBSjRFQfkzOMfwGHNkk2hAcCnhXg83jyM2WtDwtEvCYxZfG4Unr0vFIleWsyQ4vT9
 m28UMte3j9ikFP9OzeOCQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231398>

Am 30.07.2013 23:37, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> +int is_staging_gitmodules_ok()
> 
> Will tweak this to:
> 
> 	int is_staging_gitmodules_ok(void)
> 
> and fix this as well:
> 
>> +int is_staging_gitmodules_ok();
>> +void stage_updated_gitmodules(void);
> 
> 
> before queuing.

Thanks. As Frederik already noticed, this series is missing at least
one strbuf_release(). Will fix both in v4.
