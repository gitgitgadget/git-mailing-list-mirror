From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 6/6] template: Fix comment indentation in pre-rebase hook
Date: Sun, 14 Jul 2013 11:53:58 -0700
Message-ID: <20130714185358.GD4381@google.com>
References: <CAD77+gSX1ggBWHhGwxRUBPGQ6ONJd76SO-3tU05QT47iKCv9hg@mail.gmail.com>
 <1373818879-1698-1-git-send-email-richih.mailinglist@gmail.com>
 <1373818879-1698-7-git-send-email-richih.mailinglist@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 14 20:54:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyRQu-0004ko-MS
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 20:54:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752977Ab3GNSyD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jul 2013 14:54:03 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:46163 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752891Ab3GNSyC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 14:54:02 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so10524731pbc.21
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 11:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=9fDfZjqlGNHynya1kSBLBJUahtqB08UtfSXtgp7XZjM=;
        b=LQ1G/4I9qGmIfG13y4LGuMHXLj03+ZsHQbSMAONghN/ZITJ4jwGCauckpyldbSR+RP
         w67K5b0OzjtabN7xD1/xslY/ack31z+WgmBg8RBuIWOuDLq65S160px0RBkDWv7Sdv9c
         KjSHOqw5mAplLbxkXuEEbUUGMOCYRGN7XkvrIl/5xjID0n9ATGE4lK++hmZfx/gwAE8W
         zNr2Twyq9KARLnIdMivkN3derJTS87VftHYCTszwJTr3pDIRgQl7Dhxc9Tu/9FZlXVYL
         7cYN4jwyvj4UGt0KEO/5Q+HmeIyLeodSWUuMHqCBcoqXnptI72EW8Ca1PQ5s6cdoFq3v
         eGJA==
X-Received: by 10.68.103.131 with SMTP id fw3mr24154291pbb.65.1373828041466;
        Sun, 14 Jul 2013 11:54:01 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id iv4sm56709012pbc.9.2013.07.14.11.54.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 11:54:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1373818879-1698-7-git-send-email-richih.mailinglist@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230383>

Richard Hartmann wrote:

> The other hooks use two whitespace for indentation instead of tabs
> to signify code in the example/echo output.
> Follow the same layout in templates/hooks--pre-rebase.sample

I don't understand the point of this one.  Is it just consistency for
the sake of consistency?  Aren't other parts of git inconsistent in
this area?
