From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v11 20/41] sequencer.c: use ref transactions for all ref
 updates
Date: Wed, 28 May 2014 11:53:42 -0700
Message-ID: <20140528185342.GU12314@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
 <1401222360-21175-21-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed May 28 20:53:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wpiyz-0001bh-Q5
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 20:53:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753956AbaE1Sxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 14:53:46 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36067 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752504AbaE1Sxp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 14:53:45 -0400
Received: by mail-pa0-f41.google.com with SMTP id kx10so1637873pab.28
        for <git@vger.kernel.org>; Wed, 28 May 2014 11:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=wp+jtxJgTQYFyKp0g+NzQc3IjM720VR8MiIYu2UTJno=;
        b=iriICGN+hOLXcf7tQA/fgLrLTCXsvKNgHdneD8+vZQvDw9w773HZCNyhHBYK1uVI5U
         26Pp4F5A6QR5P5DYd8+THdt7dp3G+6Te0pktAe9fCXx8PSHnWGp9yIJV6YDK5vFyvxs5
         reSa5hUpbgYsfPD1zqd6vNakGW8xR2FUs26jXQLV9TzLkiHoF/tDRrohVyASGgJYkoxa
         EMT5164VwG7MMylqLy5sUC4XSSADM81084aNCo9LdI9NES+do7FK+b3/4pLn+LBvI4by
         qoXQCuQclO470Tq1lJ0pauJcNgsozonpif9dWtsXc4X2SOpovCKPkayB2zlW3jyfZUJu
         J0dw==
X-Received: by 10.68.132.9 with SMTP id oq9mr1738150pbb.103.1401303225091;
        Wed, 28 May 2014 11:53:45 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ky8sm29587928pbc.64.2014.05.28.11.53.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 28 May 2014 11:53:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1401222360-21175-21-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250314>

Ronnie Sahlberg wrote:

> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  sequencer.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
