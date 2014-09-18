From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v21 0/19] rs/ref-transaction (Re: Transaction patch
 series overview)
Date: Thu, 18 Sep 2014 09:57:22 -0700
Message-ID: <20140918165721.GA772@google.com>
References: <20140911030318.GD18279@google.com>
 <xmqqfvfxdcjz.fsf@gitster.dls.corp.google.com>
 <20140912004717.GY18279@google.com>
 <xmqqsijwaclo.fsf@gitster.dls.corp.google.com>
 <20140912191812.GZ18279@google.com>
 <xmqqk358a9yz.fsf@gitster.dls.corp.google.com>
 <54136B10.4050001@alum.mit.edu>
 <20140912235745.GB18279@google.com>
 <54198B39.8020405@alum.mit.edu>
 <xmqqfvfoq3ra.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Ronnie Sahlberg <sahlberg@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 18 18:57:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XUf1W-0008Gg-Ur
	for gcvg-git-2@plane.gmane.org; Thu, 18 Sep 2014 18:57:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbaIRQ5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2014 12:57:31 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:44752 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932274AbaIRQ53 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2014 12:57:29 -0400
Received: by mail-pd0-f180.google.com with SMTP id ft15so1763070pdb.25
        for <git@vger.kernel.org>; Thu, 18 Sep 2014 09:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=rLVS6tA4GTxa+r7FUBEJMRnB07pUPV+Mu549nd9z/rY=;
        b=cPOCTViT/kiCmCfLv6H4jb0S3nDnRLQsABPYJS/jjOz5nqqi1rNw6+K/0XTxC+VcT5
         wBbvBanDhbNfswjzJZQcIiw2dAEliQIlTNhB76+T8BLbiE770BvLBxnyCf9pRUuQySKA
         axawZAZOUUBf2Zax/8uhXTssdEnqLv6r+iVZA38vkZQQ3FuUBESNDxBVkM6obTOwuSYg
         AKjlqgAqRvuwN2KEMimYych4rdsFasgdBBZObGnzXmdhCbxVm+I0PPm/0tWrM9k6apCF
         Hi0LNkQ4feGZiNHeSFaLrSOjbqqRRGGiSwm7ofXsm/Rb6UEikvjSka7/avqLGY6dVh6h
         W8KQ==
X-Received: by 10.66.120.99 with SMTP id lb3mr6211861pab.152.1411059449334;
        Thu, 18 Sep 2014 09:57:29 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id om6sm20184200pdb.89.2014.09.18.09.57.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Sep 2014 09:57:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqfvfoq3ra.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257266>

Junio C Hamano wrote:

> Jonathan: Is a current version of this patch series set up to be
> fetched so that it can be reviewed outside Gerrit?

The current tip is 06d707cb63e34fc55a18ecc47e668f3c44acae57 from
https://code.googlesource.com/git (fetch-by-sha1 should work).  Each
reroll gets its own refname of the form refs/changes/62/1062/<number>
with <number> increasing.  The "Download" widget in the top-right
corner of https://code-review.googlesource.com/1062 shows the refname.

There are plenty of unaddressed comments from Michael, so I'd hold off
on picking up the latest for pu for now.

Thanks,
Jonathan
