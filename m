From: Simon Josefsson <simon@josefsson.org>
Subject: Re: Replacement for cvs2cl, for generating ChangeLog
Date: Wed, 28 Feb 2007 15:12:22 +0100
Message-ID: <877iu274mx.fsf@latte.josefsson.org>
References: <877iu3q13r.fsf@latte.josefsson.org>
	<Pine.LNX.4.63.0702271336050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0702271618210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 28 15:12:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMPXs-0003Xm-Pb
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 15:12:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932579AbXB1OMi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 09:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932609AbXB1OMi
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 09:12:38 -0500
Received: from 178.230.13.217.in-addr.dgcsystems.net ([217.13.230.178]:58639
	"EHLO yxa.extundo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932579AbXB1OMi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 09:12:38 -0500
Received: from extundo.com (yxa.extundo.com [217.13.230.178])
	(authenticated bits=0)
	by yxa.extundo.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l1SECNBS025520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 28 Feb 2007 15:12:26 +0100
OpenPGP: id=B565716F; url=http://josefsson.org/key.txt
X-Hashcash: 1:22:070228:git@vger.kernel.org::qDU7nRRFuhLLNtQ6:30IC
X-Hashcash: 1:22:070228:johannes.schindelin@gmx.de::PljzB33rrH3cVJAJ:0+4LU
In-Reply-To: <Pine.LNX.4.63.0702271618210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue\, 27 Feb 2007 16\:19\:33 +0100
	\(CET\)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.94 (gnu/linux)
X-Spam-Status: No, score=-2.0 required=4.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.1
X-Spam-Checker-Version: SpamAssassin 3.1.1 (2006-03-10) on yxa-iv
X-Virus-Scanned: ClamAV version 0.88.2, clamav-milter version 0.88.2 on yxa.extundo.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40925>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Let me hack something.
>
> See my next three posts. This patch series is on top of "next" (it does 
> not apply cleanly to "master", since the format "format:" conflicts...).

Wow, that was quick!  Thanks.  I haven't built my own git yet, so
testing this may take some time...

Generally, I can sympathise with those who think this feature should
not be in the core git.  That would correspond to the cvs2cl tool, it
is an external tool that uses cvs internally.  However, having it be
included in core would be simpler for me.  I don't care strongly which
approach is chosen (external tool vs included in core), but I can't
switch to git for my projects until this is resolved.

/Simon
