From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git-svn: cleanup sprintf usage for uppercasing hex
Date: Wed, 23 Jan 2013 17:33:22 -0800
Message-ID: <20130124013322.GC27174@google.com>
References: <20130124012810.GA8096@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Jan 24 02:33:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyBhQ-0008E0-Lo
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 02:33:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752806Ab3AXBdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 20:33:32 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33519 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752241Ab3AXBda (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 20:33:30 -0500
Received: by mail-pa0-f51.google.com with SMTP id fb11so5181778pad.10
        for <git@vger.kernel.org>; Wed, 23 Jan 2013 17:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=0C6+cr8/JJ1FzCg7i8FtZ4aQ7cBbcjb0y5MeuiH7vXY=;
        b=GCjjo/dTWmUAYI4Rz9KjnhnRjy4cpgEicmbPC/j7qDhwbsQzeEMXjWA3E2zK8jwwLJ
         AkohNue0vR2H59K8oEJltwk/6H5sMWuSMdUpH5xl0NJAsK6zrJoOham1EPzYZLGlxcLX
         UXGzPlQXl7NsHqGKg0QBbK+0QoaK0DEvlJWJje4302ePNk9tV1tIgsvlzeVOXVlEH60q
         558s7tQnZWBIkj0nmL/MXqsCOAnnhzuubH0HrsR5tEbW6P9PUgrJizbBXb0WXvSu07Ry
         aWSElE4XeyYw3tw0mO3YCb5Q8lKXlMmgeGHw5DN3g3k/TzARLmpSJhrE3kV/jBN/fYUi
         uz8Q==
X-Received: by 10.68.243.105 with SMTP id wx9mr569309pbc.74.1358991210458;
        Wed, 23 Jan 2013 17:33:30 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id sk1sm13797804pbc.0.2013.01.23.17.33.28
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 23 Jan 2013 17:33:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130124012810.GA8096@dcvr.yhbt.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214385>

Eric Wong wrote:

> We do not need to call uc() separately for sprintf("%x")
> as sprintf("%X") is available.

For what it's worth,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
