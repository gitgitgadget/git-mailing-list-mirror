From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v6 00/42] Use ref transactions for all ref updates
Date: Tue, 13 May 2014 13:25:10 -0700
Message-ID: <20140513202510.GW9218@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Tue May 13 22:25:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkJGM-0004ru-44
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 22:25:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754992AbaEMUZR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 16:25:17 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:54677 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754981AbaEMUZO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 16:25:14 -0400
Received: by mail-pb0-f51.google.com with SMTP id ma3so705141pbc.10
        for <git@vger.kernel.org>; Tue, 13 May 2014 13:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=RcqZP3oCcw4P/2NqCcIlVy7gAIa1egNMP2q8jQhbAYM=;
        b=Zbv3WqZQ5/21wRYZpMTcx1IAfAeRO1f+fgtbDk7SMIkjTuwAVtQRnl54tBdARrwyIh
         b6uwhh6QGOCoh/CMmN5kAZdhDTf0JkPWDAKDkW2o9SadX3xgHukAwI8omjUFcr126Gew
         EJP4vljhMqQTPfDuKTQmU+i9T6W1m2WeG7hhm1Gh9nn4E4lrI1EXz+pxmNLIcuNFpoFG
         z6TIGSSSx6gXM7txuO9xq9TyeWdHuA7iwKwyTrMnOdfrUi6P4r1rkgUIhrTNbDBdwjf1
         yD7lhFp90ZiTXW7bGhdV/HlMerSGTSbxwuou5tkkdf3LCEdxpQ7qurQAeKL/bP21dsbu
         3hsA==
X-Received: by 10.66.193.104 with SMTP id hn8mr3004455pac.99.1400012713714;
        Tue, 13 May 2014 13:25:13 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id id10sm29791478pbc.35.2014.05.13.13.25.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 13 May 2014 13:25:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398976662-6962-1-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248814>

Hi,

Ronnie Sahlberg wrote:

> This patch series is based on next and expands on the transaction API.

Sorry to take so long to get to this.

For the future, it's easier to review patches based on some particular
branch that got merged into next, since next is a moving target
(series come and go from there depending on what seems to need testing
at a given moment).  Is mh/ref-transaction the relevant branch to
build on?

Trying to apply the series to mh/ref-transaction, I get conflicts in
patch 13 due to absence of rs/ref-update-check-errors-early.

Trying to apply the series to a merge of mh/ref-transaction and
rs/ref-update-check-errors-early, I get a minor conflict in patch 15
but it is easy to resolve and the rest goes smoothly.

Looking forward to reading the rest.  Thanks.
Jonathan
