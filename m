From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 1/1] Makefile: make curl-config path configurable
Date: Mon, 5 Oct 2015 14:11:07 -0700
Message-ID: <20151005211107.GF11993@google.com>
References: <1444077159-3268-1-git-send-email-repk@triplefau.lt>
 <20151005204909.GE11993@google.com>
 <20151005210545.GC386@cruxbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>, Jeff King <peff@peff.net>
To: Remi Pommarel <repk@triplefau.lt>
X-From: git-owner@vger.kernel.org Mon Oct 05 23:11:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjD2S-0000N6-02
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 23:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837AbbJEVLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 17:11:12 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36382 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498AbbJEVLK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 17:11:10 -0400
Received: by pablk4 with SMTP id lk4so186333780pab.3
        for <git@vger.kernel.org>; Mon, 05 Oct 2015 14:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=W/L0Ts7SsP3Rnf68J6QiT+PnxdaeMcuSuFhfCQi+Ow0=;
        b=NMsbtuBGj8NCKZzPlTzfXX1BAC7zdByU/Lt9aZPYRLyQnIszlg8hlIXvnAKCIhTqri
         dH34nCANNeil/VinYzzV7oBGGxyhbaq/sOXe+3gGM2zlCDsm+hV/00gERC3Y2VVtoczE
         BJfklgHkuaWj9l2Xp37oKcC/YKPynEddPIr8ngkBotvHFRya6ROGPoYq+bnmvI+Hymw6
         R+YMbnunWHdckMosVytQSb/G4o2GC2K7IFwqjdRa0QfKxIuJso7mWpblPP94q+1A9D/B
         4kHvpfXw8Kl/t2v0ZDBgcjIjaHwpYfL/nLJ6EyBtxK3BjZ5FF29JcIo1hPTarDzohybg
         ujiw==
X-Received: by 10.68.57.197 with SMTP id k5mr42114034pbq.142.1444079470222;
        Mon, 05 Oct 2015 14:11:10 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:201e:549b:492b:2feb])
        by smtp.gmail.com with ESMTPSA id ip1sm29355805pbc.30.2015.10.05.14.11.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 Oct 2015 14:11:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20151005210545.GC386@cruxbox>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279097>

Remi Pommarel wrote:

> Do I need to resend a v4 patch with these modifications ? I am not sure
> about the correct workflow here.

If you like the changes, you can ask Junio to squash them in.

If you don't like them, that's also fine and you can just say so.
