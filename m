From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git ate my home directory :-(
Date: Mon, 25 Mar 2013 14:43:43 -0700
Message-ID: <20130325214343.GF1414@google.com>
References: <5150C3EC.6010608@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Richard Weinberger <richard@nod.at>
X-From: git-owner@vger.kernel.org Mon Mar 25 22:44:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKFBj-0004Tq-Pz
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 22:44:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933254Ab3CYVnv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 17:43:51 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:42572 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933102Ab3CYVnu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 17:43:50 -0400
Received: by mail-pd0-f169.google.com with SMTP id 10so168534pdc.14
        for <git@vger.kernel.org>; Mon, 25 Mar 2013 14:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=fiFNYoo2SfS0hAxms8w5+WYzBgWqE2Pue7TdzQ7jXsA=;
        b=UY8qkDatZ6+3JbRp6gAd7PSpHjCiJl1UY85qeEP0wBldx4uETaFT/Rp3plQllDoGDE
         ycsuTpo0PqynCIJnm7RgTtPZuH30sqcTi4WnoLD/e5ZPc/BX8rhW2ByUwwCfC3eT/k/H
         JOIKCb1/mfzqegpqg3e5ELoWu+v7ExelGqRCFUhSXkqZIr46YJYAzqg18YUdwl7atFxb
         0F4dTgsqRxO+qvK+LOjOJWo6uXwcsOzHizsqZlwu8op/ZWJJyLv1FD0Rtvy6Ac6rZIxK
         hKVYU89MeFkjSdbiFl/PX6LZ6aAyczDhQVX1C4qP2Igyn7D+hAUu/X47mZUSQgfwcdVx
         Ym4g==
X-Received: by 10.68.242.132 with SMTP id wq4mr19391818pbc.160.1364247829796;
        Mon, 25 Mar 2013 14:43:49 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id t1sm16252536pab.12.2013.03.25.14.43.45
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 25 Mar 2013 14:43:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5150C3EC.6010608@nod.at>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219098>

Hi,

Richard Weinberger wrote:

> In my scripts I'm setting GIT_DIR to use git-fetch and git-reset without changing the
> current working directory all the time.

Yeah, for historical reasons GIT_WORK_TREE defaults to $(pwd) when
GIT_DIR is explicitly set.

In git versions including the patch 2cd83d10bb6b (setup: suppress
implicit "." work-tree for bare repos, 2013-03-08, currently in "next"
but not "master"), you can set GIT_IMPLICIT_WORK_TREE=0 to avoid this
behavior.

Thanks for a useful example, and sorry for the trouble.

Sincerely,
Jonathan
