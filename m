From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/2] "git add -A/--no-all" finishing touches
Date: Thu, 25 Apr 2013 16:24:10 -0700
Message-ID: <20130425232410.GN29963@google.com>
References: <7vehe3qi5m.fsf@alter.siamese.dyndns.org>
 <1366663435-13598-1-git-send-email-gitster@pobox.com>
 <7vhaiu1a89.fsf@alter.siamese.dyndns.org>
 <7v4neu19mj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Thomas Rast <trast@inf.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 01:24:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVVWV-0006Pw-Fz
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 01:24:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428Ab3DYXYP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 19:24:15 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:33662 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932087Ab3DYXYP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 19:24:15 -0400
Received: by mail-da0-f46.google.com with SMTP id x4so1091076daj.5
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 16:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=QaGKNxFGQfZSPpYMh36Qy7Xq6zcQf2yIblg9/y/TyfE=;
        b=PJtXxTTvMPX4vXv6i8O2ozYco7JPhfWhCwHruXiyD+WNGBmma6H7peFqHwUwqKHzeY
         i2MRBnJY/difTekJOSO8hZK4O/CiCU0y13nZZKFpqNbTmGR1QctWgpSmyR4rPcTPPara
         1Tq2++O2roD6jtNhZB5+YUEmF1BbGYRnNjLsB6jfMl++zZME+TsXk2JZOJsYy7FC+heL
         XoEEsq8xsn3Mom8VbnsR0Bkoz4HGTfsgNMkrOijW5jNvqvwebGyaJnKE3x6swn26JIGs
         gdObWTBB7DqzUmnJsLlQ6UBjYXYlIuEbc2D2700IfyJvqiWVr1uhrpsWd8b7OKjavUTG
         XkgA==
X-Received: by 10.66.118.201 with SMTP id ko9mr43140580pab.81.1366932254430;
        Thu, 25 Apr 2013 16:24:14 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id vv6sm9967335pab.6.2013.04.25.16.24.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Apr 2013 16:24:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v4neu19mj.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222464>

Junio C Hamano wrote:

> At the point of calling warn_pathless_add(), it seems that we are
> triggering this for paths that are not necessarily modified when run
> with "add -n -u".

Do you mean files that were touched but have no content change, or
something more subtle?
