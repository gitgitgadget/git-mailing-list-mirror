From: Hadmut Danisch <hadmut@danisch.de>
Subject: Re: Why can't git open empty branches ?
Date: Wed, 11 Apr 2012 13:06:36 +0200
Message-ID: <4F8565BC.1070701@danisch.de>
References: <4F855E6B.4010504@danisch.de> <20120411105906.GA19823@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 13:06:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHvNq-0000qs-Va
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 13:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755163Ab2DKLGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 07:06:38 -0400
Received: from mail.rackland.de ([212.86.200.188]:50366 "EHLO mail.rackland.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751238Ab2DKLGi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 07:06:38 -0400
Received: from [192.168.160.116] (178-26-58-165-dynip.superkabel.de [178.26.58.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by mail.rackland.de (Postfix) with ESMTPSA id 8230F2C082;
	Wed, 11 Apr 2012 13:06:35 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120329 Thunderbird/11.0.1
In-Reply-To: <20120411105906.GA19823@burratino>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195164>

Am 11.04.2012 12:59, schrieb Jonathan Nieder:
> 	git checkout --orphan <new branch>
> 	git rm -fr .



I would have expected something more obvious and intuitive like

  git branch --empty



It is not really plausible to create a new branch by checking out a
non-existing one.

However, this helps. Thanks.
