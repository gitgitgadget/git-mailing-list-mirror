From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Best practice question
Date: Thu, 19 Jun 2008 12:39:19 -0400
Message-ID: <32541b130806190939t2a26c6f7j987eb1c679d53b3a@mail.gmail.com>
References: <485A6E03.6090509@et.gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: stuart.freeman@et.gatech.edu
X-From: git-owner@vger.kernel.org Thu Jun 19 18:40:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9NBl-0002dr-Cv
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 18:40:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752001AbYFSQjY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 12:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751897AbYFSQjY
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 12:39:24 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:17242 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbYFSQjX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 12:39:23 -0400
Received: by fk-out-0910.google.com with SMTP id 18so848155fkq.5
        for <git@vger.kernel.org>; Thu, 19 Jun 2008 09:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ENEcdsmr5V7B6Z+aAjCOojaB55s03KMVAtNJiEWdmWU=;
        b=tJ5Qbm9OPG+RqGVNVWDcrHHyfWUblmABJpdcpY7gBlbtsNtpzVMbbVmqGbpLAtX+7C
         sgqluWUwKdSiWy98plT9RXhXI2f/SDKzTpF0QOQo8C2FW36zs7kuiV+iyQryn4Sbkm02
         mXzS0X5ZAI8VmXwWyq1kEiaXcFeU6+7eCmH3E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=gN7e/JgATxB+pIDTTJyPnOCJmgw5PhGT0KWU7xitBqdmMFiQL8HNJlLl5KK+zKj9ME
         T9jBeBDOp+FmVd0jn0jxTJ5AC6gIaAMiuPwrUDCpsvU2sevcuNSyrv+NdNUvJ7st27i8
         5FLB/2Tu4Ma/lwMvYk22RHgsxCy76P9+db2VQ=
Received: by 10.82.135.7 with SMTP id i7mr138563bud.42.1213893559436;
        Thu, 19 Jun 2008 09:39:19 -0700 (PDT)
Received: by 10.82.100.5 with HTTP; Thu, 19 Jun 2008 09:39:19 -0700 (PDT)
In-Reply-To: <485A6E03.6090509@et.gatech.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85490>

On 6/19/08, D. Stuart Freeman <stuart.freeman@et.gatech.edu> wrote:
> My project has an "about" page that lists the version.  I understand why
>  git doesn't do keyword expansion, but I'm wondering if there's a
>  recommended best practice for keeping that up to date.

If you compile git yourself and run "git --version", it contains the
current version number.  You may want to do it the same way.

See also the "git-describe" command.

Have fun,

Avery
