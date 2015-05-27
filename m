From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/4] showing existing ws breakage
Date: Wed, 27 May 2015 13:46:26 -0700
Message-ID: <xmqqpp5lkau5.fsf@gitster.dls.corp.google.com>
References: <1432669584-342-1-git-send-email-gitster@pobox.com>
	<1432708232-29892-1-git-send-email-gitster@pobox.com>
	<20150527072218.GB6898@peff.net>
	<xmqqa8wpn910.fsf@gitster.dls.corp.google.com>
	<20150527203648.GE14309@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 27 22:46:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxiDh-0005CO-57
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 22:46:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbbE0Uq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 16:46:29 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:37551 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249AbbE0Uq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 16:46:28 -0400
Received: by igbsb11 with SMTP id sb11so23927963igb.0
        for <git@vger.kernel.org>; Wed, 27 May 2015 13:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=s3uroYjNmtDUjWuBULekkdPdiFenf3PKVuNg+6hQNxk=;
        b=tTdj+3T3BzKQ0l6A53nZWcoijrSJNzDiWd3xVxabPSDa4ZJDRGuVlz8QkL0y2jBSTG
         uvdczg/7kZ2Lod1cF/jGZdVcTmRaVPEnnZRHHCUIlSdWC/QjQvNoIJp8+9of6olegCWn
         xcVxhEsZqoW/o/eXoK/XmQeTMW6fIFiTmKqacIZKJREBqwN79Z6W3QeoGE4uAskgze79
         6wfjfk3XTM9eZ/vH5KnVo5faUfnfYDzyZ5+js+y9gJmOqTs9OZNYat4BCK05+AuyBxBa
         WWhO2EtAmxwqwHVKje81MhkA9Fj95TPLUifwMHXnNXNLzzkbmXCUIGEg/ibnMAfoW5jR
         b0mg==
X-Received: by 10.50.50.148 with SMTP id c20mr39487925igo.0.1432759587572;
        Wed, 27 May 2015 13:46:27 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:91c7:752b:4513:7344])
        by mx.google.com with ESMTPSA id l1sm82209ioe.32.2015.05.27.13.46.26
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 27 May 2015 13:46:27 -0700 (PDT)
In-Reply-To: <20150527203648.GE14309@peff.net> (Jeff King's message of "Wed,
	27 May 2015 16:36:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270091>

Jeff King <peff@peff.net> writes:

> Do you want me to also eradicate PLAIN from the code itself? It's a
> rather simple change, but it does touch a lot of places.

Nah, that is not user-facing.  We do not do s/cache/index/ in the
code, either.

Besides, I actually find plain much easier to type than context ;-)
