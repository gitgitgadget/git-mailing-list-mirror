From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5 14/35] lock_file(): exit early if lockfile cannot be
 opened
Date: Tue, 16 Sep 2014 15:12:27 -0700
Message-ID: <20140916221226.GN29050@google.com>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
 <1410896036-12750-15-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Sep 17 00:12:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XU0zD-0005ci-Vw
	for gcvg-git-2@plane.gmane.org; Wed, 17 Sep 2014 00:12:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754044AbaIPWMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 18:12:31 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:44418 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752779AbaIPWMa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2014 18:12:30 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj1so702840pad.0
        for <git@vger.kernel.org>; Tue, 16 Sep 2014 15:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=FiKWk+hEc99XIIQHnTq1ByVIqvOumDPbyOGIJa1Dqlc=;
        b=iGuwsMckiH923ELPAUNKhoCEGTz+/KP8oZaZobcZdQhpIDfjzb4zifvWJru3gsz6Qi
         fcOeUoRRdGVa/LSb6dg/bCGl/Ynq6zTeHdHODBySwBJaPU9z0qkP7Y+yU5tXAfLxcn0U
         mXuePidsJcy5O9Q9509yme0uC0FZ1fgXLZywAOIhcHxXcYb73uE91jR84jcsXCblH43x
         tKTFORedp6V1dYauzSYCwoop4l9XdFYGupT5nTX/UbMM0t6bk87egDaSHM60IH0ONwgo
         a/B/+EWEXLLDeI5BmVnYoK9+C/NrDKOcnHM8grQz+zTLoOAf1pw4U0lz2pB5gLgNDsKO
         WX9A==
X-Received: by 10.69.26.134 with SMTP id iy6mr55454978pbd.115.1410905550019;
        Tue, 16 Sep 2014 15:12:30 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id xt10sm15517500pab.44.2014.09.16.15.12.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Sep 2014 15:12:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1410896036-12750-15-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257198>

Michael Haggerty wrote:

>  lockfile.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
