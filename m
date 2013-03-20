From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/6] t5516 (fetch-push): introduce mk_test_with_name()
Date: Wed, 20 Mar 2013 11:41:57 -0700
Message-ID: <20130320184157.GO3655@google.com>
References: <1363783501-27981-1-git-send-email-artagnon@gmail.com>
 <1363783501-27981-4-git-send-email-artagnon@gmail.com>
 <20130320182830.GJ3655@google.com>
 <CALkWK0mCVb6N76QU+U3iTO_gmU4PmhrTOgU53DAMd5x1bCQEtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 19:42:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UINy3-0002AU-0p
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 19:42:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932983Ab3CTSmE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 14:42:04 -0400
Received: from mail-da0-f53.google.com ([209.85.210.53]:59407 "EHLO
	mail-da0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932916Ab3CTSmD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 14:42:03 -0400
Received: by mail-da0-f53.google.com with SMTP id n34so40765dal.12
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 11:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=YhpKqEn8nw4J3gcQ4Rra+8scYyxZ7539iJlA5H8afxo=;
        b=q7dE4L1BcYarcBQCZjJij+dg+lQoY83LBhdhZX9306nJ3Z1tQboEv+Zd/MQRKBiXZY
         bncVY0g6dl0ooA0RjbYbTTFDpas53HWYjhR+Du8chiiIGNHJOTbPx4japmjNA1dGkk71
         htmF+HvKEzMyJ5ikgDNokLQHQMWu5CkH9uVONAMhZNDGzPqiXakGghBgoQF1P4g96wVP
         HoniNIOFbAdqaZSyFNIbmWhmzG9/eyA19CCQNSWAwF3d8QDv2f1yQMIenk9aAJqWQj+8
         /8ng1yLXy5TtCfcojRPjXQJdmXHoYjRwQ51Yx8t4rf3lZtyj0eEd72o+cXJ0N52r9GjU
         nKoQ==
X-Received: by 10.66.250.135 with SMTP id zc7mr10541047pac.162.1363804922144;
        Wed, 20 Mar 2013 11:42:02 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id hu2sm2972188pbc.38.2013.03.20.11.41.59
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 20 Mar 2013 11:42:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0mCVb6N76QU+U3iTO_gmU4PmhrTOgU53DAMd5x1bCQEtA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218649>

Ramkumar Ramachandra wrote:
> Jonathan Nieder wrote:

>> I dunno.  The helper functions at the top of this test are already
>> intimidating, so I guess I am looking for a way to avoid making that
>> problem worse.
[...]
> My patch does not make the situation worse in any way:

Um, yes it does.  It adds another function to learn to an already
intimidating list.

Hoping that clarifies,
Jonathan
