From: Stefan Tatschner <rumpelsepp@sevenbyte.org>
Subject: Re: git svn timezone issue?
Date: Thu, 09 Jul 2015 15:30:56 +0200
Message-ID: <1436448656.1480.6.camel@sevenbyte.org>
References: <1436448494.1480.5.camel@sevenbyte.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 09 15:48:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDCBj-00067N-HM
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 15:48:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbbGINs3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 09:48:29 -0400
Received: from mail.sevenbyte.org ([5.9.90.188]:40829 "EHLO mail.sevenbyte.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752128AbbGINsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 09:48:25 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.sevenbyte.org (Postfix) with ESMTP id 77A13126062F
	for <git@vger.kernel.org>; Thu,  9 Jul 2015 15:30:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at sevenbyte.org
Received: from mail.sevenbyte.org ([127.0.0.1])
	by localhost (mail.sevenbyte.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b_6sjxxu3w21 for <git@vger.kernel.org>;
	Thu,  9 Jul 2015 15:30:56 +0200 (CEST)
In-Reply-To: <1436448494.1480.5.camel@sevenbyte.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273755>

On Do, 2015-07-09 at 15:28 +0200, Stefan Tatschner wrote:
> Hi,
> 
> at work we use svn, so I used "git svn" to import that stuff to git.
> Now it seems that there are some timezone issues. "git log" shows 
> +0000
> as timezone, while "git svn log" shows the correct timezone +0200. 

Ok, I just discovered the --localtime switch in the manpage. Sorry for
the noise!

Thanks,
Stefan
