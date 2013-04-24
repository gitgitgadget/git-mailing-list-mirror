From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/5] git-diff.txt: group the [--] and [<path>...]
 templates
Date: Wed, 24 Apr 2013 11:57:32 -0700
Message-ID: <20130424185720.GC29963@google.com>
References: <1366821216-20868-1-git-send-email-artagnon@gmail.com>
 <1366821216-20868-4-git-send-email-artagnon@gmail.com>
 <7vtxmvdc4d.fsf@alter.siamese.dyndns.org>
 <CALkWK0nU-iTSF2DnmJAB=kj6w+VFv3rQrixEnHz0vyXf2d2=Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 20:57:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV4t0-0008DT-R0
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 20:57:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756459Ab3DXS5n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 14:57:43 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:51976 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756072Ab3DXS5m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 14:57:42 -0400
Received: by mail-pa0-f50.google.com with SMTP id bg4so1370322pad.9
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 11:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=1aTteY56acXbKrIFVYegAloDhCZ4JKrQ8IClkmzg2BU=;
        b=VdTtRFoCtP8tVbccvT5O4T3+N6zeSYlUUYJ59UQLls3QeFq5wPl6BOwAYJzNgChtAP
         wrE7yTB5Ue/sxtz87yWMOCtrFYFo77T0jQqnMwZ3VTcEbOOBA6JAwlQhEWyvjjSS19pf
         YD/cHEeCtx81bY/GGjXm0kxh49yKNFPo5oTN0PpTX6UytlNtUuXHxvYKdziRtVyE3KE+
         tC9eL7KtSVbYEkhNTlfmOru6ritSQt1N2mjgOqGWEkLS2+CsBKj6tmDnv5/J7bZQXtdi
         W8nz6YTNJCxeMSuTWoMG23bb+uteIqMORXEMBky7v3qCNce07/dLDZ0fL5dDkngsOLW7
         1AXA==
X-Received: by 10.66.159.193 with SMTP id xe1mr37239996pab.3.1366829862043;
        Wed, 24 Apr 2013 11:57:42 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id dr4sm4046594pbb.19.2013.04.24.11.57.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 24 Apr 2013 11:57:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0nU-iTSF2DnmJAB=kj6w+VFv3rQrixEnHz0vyXf2d2=Mw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222295>

Ramkumar Ramachandra wrote:

> Hm, I thought it improves readability.  I'm trying to say that -- is
> used to separate [<path>...] from [everything else].

I agree with the goal, but I don't think this change achieves it.
Maybe adding gitcli(7) to the SEE ALSO section would work?

Jonathan
