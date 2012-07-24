From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 1/7] i18n: New keywords for xgettext extraction from sh
Date: Tue, 24 Jul 2012 12:46:56 -0500
Message-ID: <20120724174656.GE2939@burratino>
References: <cover.1343112786.git.worldhello.net@gmail.com>
 <6fbf2661d428ca4c4227b418368716d903dfd3e3.1343112786.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 19:47:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StjCQ-0005MW-G1
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 19:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755857Ab2GXRrE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 13:47:04 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:54397 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755803Ab2GXRrC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 13:47:02 -0400
Received: by gglu4 with SMTP id u4so6948920ggl.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 10:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=kLWpLcHL1g0kqNX7qe698F5wYihZUYOyfh0cRB3gmqY=;
        b=M8PuqYxE11Pr5dJvJ4Xj3ZMvmCWB4JB7YRZ6P45EMQwpblbDf75VGLAabo6WvXMnss
         t7OVF3KjGjQMIGEIslO20y5lKU+AwUpvgGoEKbG/LsyF9zwsejq27QxhvYl0Ee3x4yLr
         r1sZsR0ze2+pj5ZcWQs1KMYaj4x88Pu5lPhIikDug88ABljcQBu6lvE6hU//Y3zMMZmV
         0gc9Knt8mkhw7MAlM6ENLtqdYM8DS9Lv2E32CjPRiQvMg2EdpsNrPDLghUBT8r4VFERh
         M4qUJbz0fLKku4c/44HYBS8lKUBdoFgDHl5jU3Rw7ypg93tPDxNqI2lGD6d7FNfPYXz6
         1cbw==
Received: by 10.43.52.198 with SMTP id vn6mr16955747icb.42.1343152021038;
        Tue, 24 Jul 2012 10:47:01 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id pp4sm5118947igb.5.2012.07.24.10.47.00
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 10:47:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <6fbf2661d428ca4c4227b418368716d903dfd3e3.1343112786.git.worldhello.net@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202047>

Jiang Xin wrote:

> Since we have additional shell wrappers (gettextln and eval_gettextln)
> for gettext, we need to take into account these wrappers when run
> 'make pot' to extract messages from shell scripts.

Yes, thanks for fixing it.

As Stefano mentioned, s/run/running/ would make the above clearer.

With or without that change,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
