From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 15/16] checkout: add new options to support narrow checkout
Date: Wed, 17 Sep 2008 18:32:40 +0200
Message-ID: <48D13128.3000509@viscovery.net>
References: <48cdde2837b2d_12d73fc6eb2c355c27876@app02.zenbe.com.tmail>	 <200809152205.15388.jnareb@gmail.com>	 <fcaeb9bf0809160521o24fd26e4l40f1798228d51712@mail.gmail.com>	 <200809171107.35826.jnareb@gmail.com> <fcaeb9bf0809170649w418f4af5x3055c04994c694dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 18:34:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfzyR-00016g-MS
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 18:33:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752916AbYIQQcn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 12:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752736AbYIQQcn
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 12:32:43 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:42492 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589AbYIQQcm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 12:32:42 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KfzxI-0000HZ-Ip; Wed, 17 Sep 2008 18:32:40 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 4E8D0AFCC; Wed, 17 Sep 2008 18:32:40 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <fcaeb9bf0809170649w418f4af5x3055c04994c694dc@mail.gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96126>

Nguyen Thai Ngoc Duy schrieb:
> Well I've been asking about the name on this list long enough. I'm
> going with 'sparse checkout' as svn' sparse directories does not look
> too different from git's.

FWIW, /me likes 'sparse checkout'.

> --path clears out all no-checkout bits and set again based on the
> given spec. --add-path adds more checkout entries based on the given
> spec, think of widening checkout area. --remove-path does narrow the
> checkout area. They are like '=', '+=' and '-=' operators
> respectively.

The still un-answered question was: In a full checkout, i.e. in a
repository where the narrow/sparse checkout feature has never been used so
far, is

   $ git checkout --add-path=foo

a no-op, or is it equivalent to

   $ git checkout --path=foo

Or stated differently: In the sequence

   $ git checkout --full
   $ git checkout --add-path=foo

is the second statement redundant?

-- Hannes
