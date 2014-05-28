From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v11 21/41] fast-import.c: change update_branch to use ref
 transactions
Date: Wed, 28 May 2014 11:54:32 -0700
Message-ID: <20140528185432.GV12314@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
 <1401222360-21175-22-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed May 28 20:54:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wpizn-0002qi-RY
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 20:54:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753983AbaE1Syg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 14:54:36 -0400
Received: from mail-pb0-f43.google.com ([209.85.160.43]:64819 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020AbaE1Syf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 14:54:35 -0400
Received: by mail-pb0-f43.google.com with SMTP id up15so11586719pbc.16
        for <git@vger.kernel.org>; Wed, 28 May 2014 11:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=6A5AnG+R1qwKyoDTprJnp9uS58Ovi5s1lTjA1vllFt0=;
        b=Os3X2DP6QZTetesQcdpw4rwvjQlBxvBp0IXNm58nTQUzILx+PMfnKhldHA55fdVupy
         vVE8Xa9V7+ka7vHjsT99ccZk5cg+CI2sTWPQhDuTB/Zpt9SaXI1J6aDv/2UkiOYdtNB5
         +dSmpx/5HRwbQUnzAyKvkEkio6W0P+dP21uUHAyqfiJyPJuBlmfJdu/ytJ3VpS4qvTcd
         jig6aX5PlUJMbi/zWaAbu+vufW3GSQl22aYexaCvPMGkKb5NHkESACZ5uRAqxYTM4y8r
         mIzLISt02sJmC2dZ6Y0nUTrLo4Xz++YC7Ftyzm4rnnl0m09Leu6F2bXGA0E0fLSYlL6b
         nuMQ==
X-Received: by 10.68.193.166 with SMTP id hp6mr1958487pbc.144.1401303275444;
        Wed, 28 May 2014 11:54:35 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id gg3sm29612849pbc.34.2014.05.28.11.54.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 28 May 2014 11:54:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1401222360-21175-22-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250315>

Ronnie Sahlberg wrote:

> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  fast-import.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
