From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/4] commit: Fix a memory leak in determine_author_info
Date: Sun, 14 Jul 2013 14:49:32 -0700
Message-ID: <20130714214932.GB13444@google.com>
References: <1373837749-14402-1-git-send-email-stefanbeller@googlemail.com>
 <1373837749-14402-2-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Jul 14 23:49:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyUAn-0001iq-5R
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 23:49:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753337Ab3GNVtg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jul 2013 17:49:36 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:41956 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753304Ab3GNVtg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 17:49:36 -0400
Received: by mail-pb0-f43.google.com with SMTP id md12so10564251pbc.30
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 14:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=mLcCAjHQwO+DIktz0EuxaBF91afejtzKeWLxZH8OmsQ=;
        b=xzKAK5iErJUvpldX/FJbUaIxokq6Nlz9KJDTltKPZlgVhySfEi1lBRQwFxX29Y7KlG
         86dvOFR37DXR5k7ZmJoIeoWvtROiNn4ZI1MK5yhOVBCCPjbBny3F1nWpYb3rBTE3yzax
         ACYFKEAvh1jSom+Uhma3/gcTSxuRP888aMzk+SXyMQAkeCGykvI/LEVeCfB1dd7f+8CO
         kz0YB9LkqEERLckE+5sL8u6S8OMiE/vanFtP4tOYYUh9VjccxOeecDUAzCO3+FOBYD46
         7aaACnbJ+8pHYHjsVPbaPgNE4HYrVeOAr51JRrG8GQYG3A1/ZMS40kAbPFGjS3wsX/AH
         It1w==
X-Received: by 10.68.201.6 with SMTP id jw6mr44885316pbc.202.1373838575781;
        Sun, 14 Jul 2013 14:49:35 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id qb15sm60569850pab.13.2013.07.14.14.49.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 14:49:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1373837749-14402-2-git-send-email-stefanbeller@googlemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230398>

Stefan Beller wrote:

> Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>

Thanks.  That was quick. :)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
