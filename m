From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v3] Teach rm to remove submodules unless they contain
 a git directory
Date: Wed, 12 Sep 2012 21:24:17 +0200
Message-ID: <5050E161.9080203@web.de>
References: <7vpq5tjuw3.fsf@alter.siamese.dyndns.org> <504F8427.1020507@web.de> <7vhar4gxdq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
	Phil Hord <phil.hord@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 12 21:24:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBsXz-00057g-VR
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 21:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244Ab2ILTYU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 15:24:20 -0400
Received: from mout.web.de ([212.227.17.12]:54388 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751113Ab2ILTYT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 15:24:19 -0400
Received: from [192.168.178.41] ([91.3.176.219]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0MbQbk-1SvJbC09o4-00J9mm; Wed, 12 Sep 2012 21:24:18
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <7vhar4gxdq.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:zdGsi2fkWC/pwj/sgomaGaeuz/HTIcQPPdz4pTIkJaG
 9SB5Kv4XY3BkYohm1Z5pdO1DMK+Gi3JaCl+2m2ZvKEEAl++EYf
 GEP5n5UWTyLsD9mgC89I2QW3aBFqvvh01Hd0ttCfff/sHqZpUZ
 yh8G62NKIPDYrIJao8fl1X4NWhzlOAO7Vao0QvM0z++TAQ7oUL
 4W6WcwjMnrCE6nckR2b5w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205327>

Am 11.09.2012 21:41, schrieb Junio C Hamano:
> Lilewise.  It may make sense to introduce a helper function to tell
> if it is a submodule on our side by checking only the stage #2 entry
> when you see a nagetive pos returned from cache_name_pos() and call
> it "is_ours_submodule?()" or something.

Thanks, will do so.
