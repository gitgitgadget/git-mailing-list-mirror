From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 12/17] revert: Save command-line options for continuing operation
Date: Tue, 19 Jul 2011 01:48:34 +0530
Message-ID: <CALkWK0=O-z4yw+dETkpZ2+1_eB6Z1pn55C0ggK0Q9-Hsoh53QA@mail.gmail.com>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-13-git-send-email-artagnon@gmail.com> <20110712195246.GC14909@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 18 22:19:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiuHV-0000WV-CM
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 22:19:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240Ab1GRUTD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 16:19:03 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61535 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355Ab1GRUTB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 16:19:01 -0400
Received: by mail-wy0-f174.google.com with SMTP id 8so2341586wyg.19
        for <git@vger.kernel.org>; Mon, 18 Jul 2011 13:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=sFKinUp42zm3uEdUF0rIrI0kdFC6hLOsLpG5sVhUbfc=;
        b=ZZRVmWl2FrRHWmD53wt1sPh2nXGSLIz7/i/LIUvCfKEuyUhF8AvHNnsuv+L0LDWtVN
         aAF4hrrSnI289Z0pR7OgCFlmKROdGMDrbCFYbveUHu4ag5amsPgfm8uhMw4E4r9tep/a
         zOJ4+YQiiw6l26iXDfPLxOz38zpvsWOf8i4dY=
Received: by 10.216.175.206 with SMTP id z56mr1709689wel.66.1311020341295;
 Mon, 18 Jul 2011 13:19:01 -0700 (PDT)
Received: by 10.216.234.143 with HTTP; Mon, 18 Jul 2011 13:18:34 -0700 (PDT)
In-Reply-To: <20110712195246.GC14909@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177405>

Hi,

> Subject: [PATCH 12/17] revert: Save command-line options for continuing operation

I threw away my custom parser and re-used gitconfig as Jeff suggested.
 Complete rewrite.

-- Ram
