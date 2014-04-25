From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 00/19] Use ref transactions from most callers
Date: Fri, 25 Apr 2014 14:53:36 -0700
Message-ID: <20140425215318.GA9218@google.com>
References: <1398442494-23438-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Fri Apr 25 23:53:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wdo45-0006im-C2
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 23:53:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbaDYVxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 17:53:43 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:44468 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171AbaDYVxm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 17:53:42 -0400
Received: by mail-pd0-f169.google.com with SMTP id y13so2665685pdi.0
        for <git@vger.kernel.org>; Fri, 25 Apr 2014 14:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=WFi1YOK9PU2PHA6vc2nqStoNJ4ZVuHXe2tKycJto1Do=;
        b=rKaJhUgIWoCPRXldfLoBYiBNNrz7v+hkvIDbzvgmTvQWipf4RHJVVxWSS2wWPTVm0T
         h3uv2MtWjazW+epN85fKRVxBeMQd03yWJiw/txBl138BvRJUvPi+dR+TZP5rpJ2wW4jw
         XrA/T6J7jL4N4peasdxcUJdl8Cf1PEX/Ey1KcfdHwG64cS8LOujm68nOiDH5+3c6Sz+r
         N4z5UtBbweb/lJJeAtTJANjrB4G4NxzKmxRJHiOpoQzww25hoyTSutihFfifBcbMuMDk
         gOov8xGVYrcghdJcTYuRuMBCihHGdBO029AyaVFicbJX1i25rgj4Y75A5jVPqc7XDxDt
         ihWQ==
X-Received: by 10.68.137.136 with SMTP id qi8mr10644761pbb.79.1398462821599;
        Fri, 25 Apr 2014 14:53:41 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ov4sm18148019pbc.46.2014.04.25.14.53.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 25 Apr 2014 14:53:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398442494-23438-1-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247116>

Ronnie Sahlberg wrote:

> This patch series changes most of the places where the ref functions for
> locking and writing refs to instead use the new ref transaction API.

Thanks.  Is this series based against mh/ref-transaction from "next"?

[...]
> I think I have covered all issues raised on the previous reviews and also
> done a bunch of cleanups and improvements to the transaction API.

Whoops, sorry I replied to an old message.
