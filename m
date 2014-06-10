From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v14 31/40] refs.c: make prune_ref use a transaction to
 delete the ref
Date: Tue, 10 Jun 2014 16:37:59 -0700
Message-ID: <20140610233759.GF8557@google.com>
References: <1402093758-3162-1-git-send-email-sahlberg@google.com>
 <1402093758-3162-32-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 01:38:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuVcH-0002fw-4C
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jun 2014 01:38:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753001AbaFJXiE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 19:38:04 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:53146 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751504AbaFJXiD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 19:38:03 -0400
Received: by mail-pd0-f171.google.com with SMTP id ft15so1306609pdb.2
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 16:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=mtzlOcOcMfDO+qhxRAIiYQkGdEgxpiE6w1g+vVZ+0ZI=;
        b=04XD3RNRH4q72eHVcb3GGZ20s3x1xv8H5kL8pNyEMx4Mctt6CYN+NszSiqV1oc38h+
         5Un5+OXMskCJvorSYjCTyMxW0zHnPFNxiR0JB671mxYok8OxGKT6K61rMHaMuwdG8+Ze
         udNwlwn/QROMwlLO6DA5sdRN1nyTROcAgTZl1PnsjyHBo4F1sUqE2yjjfFzNJNPsUARq
         zrrDddE3hmocnuZP+FdtzEz/I+jAI05Y0JNuRgkuK5eRbFjzOuWkccEKnu0SlqmsDOpp
         9jM7MLQkp9gLN1dCVuHYsxmG2GtG0xavuKBWY8X/2ulN9hUfS8/5W6BK267Y6fu1Nthe
         9YlQ==
X-Received: by 10.66.119.136 with SMTP id ku8mr8727110pab.121.1402443482073;
        Tue, 10 Jun 2014 16:38:02 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id fv2sm71550000pbd.11.2014.06.10.16.38.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 10 Jun 2014 16:38:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1402093758-3162-32-git-send-email-sahlberg@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251325>

Ronnie Sahlberg wrote:

> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  refs.c | 28 +++++++++++++++++++++-------
>  refs.h | 11 ++++++++++-
>  2 files changed, 31 insertions(+), 8 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
