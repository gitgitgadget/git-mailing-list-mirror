From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [long] worktree setup cases
Date: Wed, 20 Oct 2010 14:18:49 -0500
Message-ID: <20101020191849.GA17720@burratino>
References: <20101020085859.GA13135@do>
 <20101020190709.GB10537@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, fbriere@fbriere.net, drizzd@aon.at
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 20 21:24:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8eGi-0006XQ-3i
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 21:24:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755341Ab0JTTYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 15:24:06 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:54272 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755328Ab0JTTYE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 15:24:04 -0400
Received: by gyg13 with SMTP id 13so12408gyg.19
        for <git@vger.kernel.org>; Wed, 20 Oct 2010 12:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=cqgwk8ZR6nM0ffEHfGbaWxPCWRbssDNrDNQ+pgCyEps=;
        b=NRDxR/G/39D5n7SIVwesHEm3bzFh7aRey5XjimnRiMZ/TFQyX/xU11jX116FOI2mX4
         gqm6ggqDK1pjjnqJX8OPCML+09hbqF8P+6SNNJsGmcPsIzn/zdHnEDx59e1H7G106q9e
         FCAe7cF32IVLlT3AMuLZmk47/cRRNXqQBbO9s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Dppdp3d5LjFghEZlrhDueb5HtJ1Bq+DVIDWdxK8AacLZ7MGSkxFnm2cCVF1lermeoC
         dRYzuDSvRVJDjUrKHzDp9BdLsubwaQ7h5rZhsP5YAIWg+lWQ5JIPPNkhSEnf6tfp6ncb
         bChxjVmFZlqXWf5Qm60QYqjPxzOoeIyRWMPgc=
Received: by 10.42.194.141 with SMTP id dy13mr1959060icb.496.1287602553078;
        Wed, 20 Oct 2010 12:22:33 -0700 (PDT)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id e16sm222281vcm.8.2010.10.20.12.22.31
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 20 Oct 2010 12:22:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101020190709.GB10537@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159424>

Hi again,

One correction.

Jonathan Nieder wrote:

>  - if GIT_DIR was set explicitly, GIT_WORK_TREE defaults to
>    "." (for legacy reasons).

In this case GIT_WORK_TREE defaults to the original cwd.
GIT_WORK_TREE=. would have meant work tree == git dir, which
is wrong.

Sorry for the noise.
