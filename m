From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] builtin/push.c: use OPT_BOOL, not OPT_BOOLEAN
Date: Mon, 8 Jul 2013 17:29:34 -0700
Message-ID: <20130709002934.GX408@google.com>
References: <7vsizoyap9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 02:29:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwLoN-0006jK-Ge
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 02:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753458Ab3GIA3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 20:29:39 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:34944 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407Ab3GIA3j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 20:29:39 -0400
Received: by mail-pb0-f54.google.com with SMTP id ro2so4870008pbb.13
        for <git@vger.kernel.org>; Mon, 08 Jul 2013 17:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=1wdufjzBfpXVkIoKsAO+5Oh3tOBDzvjNMNKFIldGCvY=;
        b=PBj2Lj12IQzBz0C0JFeGPd1dXz2AnnJjswZdgYJxknrql+5zLNg8p3uVOSYGczF9Zp
         7zIAYvZBqf9eqwkfOc/hhVF79tQoKwazlx4kMzmlVy6uNjNcE8godyHYLrLHuMtWU1Nq
         NpRjQyAx7ChhQgcJhxLKkvYoxn/QuJ6VhbkbKa3fdTN1bqk6be8XXSZnItNB7xLGDEkb
         /qQWUe45XATga0Ccm9cwoOwWl/UnHGjB/787RmHCCHFMZUDY8kSQWGHVQCpg3Y0ao3gG
         htQtZqdpp0qhuTBK8C7uBF01AcscXSkJLAAeUhnquTIGQomZXa4FEtqHVpB4jrOzsECR
         P7AA==
X-Received: by 10.66.141.4 with SMTP id rk4mr25042764pab.127.1373329778771;
        Mon, 08 Jul 2013 17:29:38 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id te9sm10560235pab.6.2013.07.08.17.29.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Jul 2013 17:29:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vsizoyap9.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229901>

Junio C Hamano wrote:

> The command line parser of "git push" for "--tags", "--delete", and
> "--thin" options still used outdated OPT_BOOLEAN.  Because these
> options do not give escalating levels when given multiple times,
> they should use OPT_BOOL.

Thanks.  Looks obviously correct, so

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
