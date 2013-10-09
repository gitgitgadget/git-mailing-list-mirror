From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] checkout tests: enable test with complex relative path
Date: Wed, 9 Oct 2013 12:39:53 -0700
Message-ID: <20131009193952.GL9464@google.com>
References: <1381329311-5920-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Oct 09 21:40:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTzc1-0000fn-Qi
	for gcvg-git-2@plane.gmane.org; Wed, 09 Oct 2013 21:40:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754249Ab3JITj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Oct 2013 15:39:58 -0400
Received: from mail-pb0-f42.google.com ([209.85.160.42]:45500 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754076Ab3JITj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Oct 2013 15:39:57 -0400
Received: by mail-pb0-f42.google.com with SMTP id un15so1396860pbc.15
        for <git@vger.kernel.org>; Wed, 09 Oct 2013 12:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=WtcVsu9+V5Lr0M28xaUm25Lj8XEd+d8P9gCOlcscDww=;
        b=t+tk1hZFMCQNT6/uwfjpUJgLe0r75twreLu1WIsyRdtwz22g/j8llRX9QAtC5Wp0Nl
         y/pt2TGwUvtVIE9xWtvkJYdZaimje0SGpNvp/IXj+207XnWeow/RwKVPHveCAR3lF6ZM
         LkYTTFJa3rQaVCBeyH5U/uUq7//Ihl+U2+3YhR+8lpF0qyIo7iAxcxm+m4Mf0bZaX+uq
         K7nx1NdhtbqTHrP/7j7WWSBT9TXlEcvPpRzxgyAmeseWWQw8pik1fkhhe821ZonlHLhQ
         xShwoTzeuy1PgTdFzYwEyfb7z1nwU9XeuUGv7wZeYL9FJgEJIq+0ly4ftmC2qxSMLlJ9
         Jlig==
X-Received: by 10.66.241.71 with SMTP id wg7mr11083762pac.141.1381347596913;
        Wed, 09 Oct 2013 12:39:56 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id tz3sm48338944pbc.20.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 09 Oct 2013 12:39:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1381329311-5920-1-git-send-email-stefanbeller@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235839>

Stefan Beller wrote:

> This test was put in, but commented out in fed1b5ca (2007-11-09,
> git-checkout: Test for relative path use.)
> It's been a while since 2007 and the intended test case works now.
> (I could not find the enabling commit in ls-files however.)

Bisects to v1.5.5-rc0~184^2~3 (setup: sanitize absolute and funny paths
in get_pathspec(), 2008-01-28).  Thanks.
