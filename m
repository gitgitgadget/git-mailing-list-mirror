From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v8 40/44] refs.c: call lock_ref_sha1_basic directly from
 commit
Date: Thu, 22 May 2014 10:53:54 -0700
Message-ID: <20140522175354.GR12314@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
 <1400174999-26786-41-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu May 22 19:54:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnXBp-00006J-PT
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 19:54:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbaEVRx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 13:53:58 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:65520 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890AbaEVRx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 13:53:57 -0400
Received: by mail-pa0-f47.google.com with SMTP id lf10so2809319pab.34
        for <git@vger.kernel.org>; Thu, 22 May 2014 10:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=WfDEn9v+3UzIE/uISd/mfw7zqEU8+DiOG+rFbREC1EE=;
        b=eJtGsCSFgBZanYT+iMIjHwpJhPygqNxAmoi4CMaDvExJAEH8qBQFKFetxYpxo0DXU5
         TFblXzQfPuEBHSLxk89kcCghioAd5U0ZSRL+KY8m8FojmFYM4skPvt0/U8Z6BLFlNkNP
         dBAv/eqIyWtycvx/SV5diI2jAvvLoOqYVQouj60XOew0g/ILcwYvBI0g4WYg9qLBX4f1
         ezv21jLFBwecTm2huaenlZyCuwJCIQgZoOh8pVDDShzRqHgudWLk/BXA5ZiucXk6lDel
         YlpoB9befKPDTjIrnlV5QUe4Z7b3wnSi/2lA4jBTsZTkai4A+jOH8l6K+jxC6hkTkSIF
         NuOA==
X-Received: by 10.69.19.225 with SMTP id gx1mr69893335pbd.34.1400781237217;
        Thu, 22 May 2014 10:53:57 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ie9sm2069606pad.29.2014.05.22.10.53.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 22 May 2014 10:53:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1400174999-26786-41-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249923>

Ronnie Sahlberg wrote:

> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  refs.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
