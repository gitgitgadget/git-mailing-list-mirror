From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/24] Documentation: Move variables from config.txt to
 separate file
Date: Mon, 26 Jul 2010 14:38:41 -0500
Message-ID: <20100726193841.GB1043@burratino>
References: <cover.1280169048.git.trast@student.ethz.ch>
 <75c9db91f5ab43ebb60cace0d20389462a2ab02c.1280169048.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jul 26 21:39:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdTWn-00041A-0S
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 21:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754187Ab0GZTjw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 15:39:52 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54999 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874Ab0GZTjv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 15:39:51 -0400
Received: by wyf19 with SMTP id 19so2449240wyf.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 12:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=05OZfSysFZIsFlvmmxKJ11VDokpx2XkFYGuZG/8BsCc=;
        b=pqH4/IPTWAwRTFJ6LWXcm7bpD0Z+Qo4qWFFKOn5OZERqd+0qh7qHGnJcxKUeeEUMkb
         4/jDeF82M7Jq6hCHcOQaiYieO9ipnFtUIevXTacXO0iZVW5XSnLMkm5kj02hpn4/aezn
         OCNGOWJlKFnDjhXs54u2SRqQY5mIqi2jAPr8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=O7q53chIPnBp0LhrQpGFpklMaR+QRpphqyIed1tff8G85M6VI6FAyE4sDv0e5GoF0x
         DB1ZqDjXiCwulW014Y+H0+VElKFxxMjnWwz7yNEK8XzOO9t7esCFBxtE6A5/aNxZP2Db
         I2zO6xY3fGFU9KTAiFOYzxL6V0hHElskZOT0Y=
Received: by 10.216.177.140 with SMTP id d12mr7942041wem.37.1280173189913;
        Mon, 26 Jul 2010 12:39:49 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id v44sm2189633weq.28.2010.07.26.12.39.47
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 26 Jul 2010 12:39:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <75c9db91f5ab43ebb60cace0d20389462a2ab02c.1280169048.git.trast@student.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151887>

Thomas Rast wrote:

>  Documentation/config-vars.txt | 1691 ++++++++++++++++++++++++++++++++++++++++
>  Documentation/config.txt      | 1693 +----------------------------------------

Scary.  Does -B -M -C -C -C make it any better?
