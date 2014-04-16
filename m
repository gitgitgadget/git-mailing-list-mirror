From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/6] compat/regex/regcomp.c: reduce scope of variables
Date: Wed, 16 Apr 2014 09:49:30 -0700
Message-ID: <20140416164930.GP3912@google.com>
References: <1397640811-17719-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 18:49:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaT1t-0005L8-46
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 18:49:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751725AbaDPQti (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 12:49:38 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:50498 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbaDPQtd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 12:49:33 -0400
Received: by mail-pb0-f43.google.com with SMTP id um1so11107089pbc.30
        for <git@vger.kernel.org>; Wed, 16 Apr 2014 09:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=pmDgt+KGiqpgz3RAypKeQTAO/Kap5gVL82IC8yTEYzA=;
        b=VPep2nXIN1rHMMEpMPhqmmr92zy+ImeyqfdefC6lxekBeDWAtyXTwLUFll3BqcX8wd
         NP9MTecZnw7rgkY28Qi5CQ8u1QXsaPaXybkfrgVfGk39JKju/tMozfQAlh5xEkelO4z5
         95XIP6mDKvLI65K0IRz+7DrKVWaZ4ULdqBHeoltux9RSRh04yOabaR2azc/SFif4wbjc
         QrZ9xLgT0wZSBS4DeXjzdoqinRYGUFsNGbt0q/i10fcy/QextL+nGCqaBa50+i3E+gqF
         VJhiBx3WsOSdNEorljDOY0BBG2f0fpweJio0lh9hLk8kZeC7pNV4W/a7pFKUtxma3HB6
         Qo9A==
X-Received: by 10.68.220.137 with SMTP id pw9mr9771712pbc.24.1397666973135;
        Wed, 16 Apr 2014 09:49:33 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id it4sm48044048pbd.48.2014.04.16.09.49.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Apr 2014 09:49:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1397640811-17719-1-git-send-email-gitter.spiros@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246342>

Hi,

Elia Pinto wrote:

> [Subject: compat/regex/regcomp.c: reduce scope of variables]

gnulib regex is still maintained upstream and available under the
LGPL 2.1+.  Shouldn't we make the change there and reimport to
make it easier to pull in later changes?

Thanks,
Jonathan
