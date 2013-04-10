From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG] shallow clones over http
Date: Wed, 10 Apr 2013 17:44:15 +0530
Message-ID: <CALkWK0mSiWJ_O-jqu2XZ3UvTsa4P5V0Bi8j67-dtCBR2Mb56Bg@mail.gmail.com>
References: <20130403040352.GA8284@sigill.intra.peff.net> <loom.20130410T135840-387@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Tom <mail@tgries.de>
X-From: git-owner@vger.kernel.org Wed Apr 10 14:15:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPtvY-0002JZ-Qx
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 14:15:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936239Ab3DJMO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 08:14:56 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:55858 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936242Ab3DJMO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 08:14:56 -0400
Received: by mail-ie0-f181.google.com with SMTP id 17so390568iea.40
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 05:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=MUjas0qB5LxOiq1jEizGPDKOEPBbUF6BZD/yY8PZcvM=;
        b=gkzDpf7imSbj9So4Pbh+YdOxSwzqisG/tkpLeZZswnpxYbrw/7CNVLh+PLkJPM1YKg
         kGTs28jQHYO84tjXFh4pYSkLs3I9cZsfEZzy3P0Kg7FeGMEfEcTN/eKN+5gTZ+OJw1L7
         Rcqj5WrP3uEBXRPhGFp++HWlMlM35qFJPHwufKfJVv/PaJUghRFIHqE5GjGLTRFMrQKX
         wSeRdH4grHSahAY6lV0Gyp3eIM3j9Yob4ya5gJ4RvQvEA4Ww1ATqiSJbmwJM6WTy1p/E
         FyQ4DTgcb3453Wbq7BPqHLpTpfvxhbPaJuv9ZEfVClXYtAyX1cX+I+XayZF/Xb45QsDn
         k5Dw==
X-Received: by 10.42.204.79 with SMTP id fl15mr1046124icb.57.1365596095721;
 Wed, 10 Apr 2013 05:14:55 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Wed, 10 Apr 2013 05:14:15 -0700 (PDT)
In-Reply-To: <loom.20130410T135840-387@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220683>

Tom wrote:
> git pull --depth=99999

Unrelated nit: we now have git fetch --unshallow.
