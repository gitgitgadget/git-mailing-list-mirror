From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] push: Alias pushurl from push rewrites
Date: Wed, 27 Mar 2013 15:56:56 -0700
Message-ID: <20130327225656.GK28148@google.com>
References: <20130327122216.5de0c336@hoelz.ro>
 <20130327182345.GD28148@google.com>
 <20130327172909.532a30b6@hoelz.ro>
 <20130327224735.GJ28148@google.com>
 <20130327175358.53903fae@hoelz.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	josh@joshtriplett.org
To: Rob Hoelz <rob@hoelz.ro>
X-From: git-owner@vger.kernel.org Wed Mar 27 23:57:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKzHi-0004HC-Rw
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 23:57:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754982Ab3C0W5D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 18:57:03 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:55699 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754962Ab3C0W5B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 18:57:01 -0400
Received: by mail-pd0-f180.google.com with SMTP id g10so3795253pdj.39
        for <git@vger.kernel.org>; Wed, 27 Mar 2013 15:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=DmDWqlHgnRiv8kZwP53w248XLB5eUJmBADbnLqTJmuI=;
        b=G98W33Oy4fdhdbJnh8M6Ci0tEjxzKjtOyi7q2FBrBDTon1N0kmKWIwpJANcAGs1WZd
         VX2HWcmoRgA9h4yhHZJcBKsXXeMtmKmP62OORwbt7Wmyft1cmBm7u7S7apUN2jgu1JzU
         Zpdig3ALMBH+zyY1EOKvx60EgZ3EilG0Q0C7LSdt+45gXHRcQkTA5gH6Cy96AUldtdPu
         pRftw+H0ngPE3c9DEpSJ16P17ZNceSxQEhOc5oXMeUaCo5WEFz4xbuRVD1mRvo6EH9Fb
         d6re7tONb12d9cJQd2xyuLY/S8oqKv8j78/HpyxnzstsUIHFZVHIEKFF8cqkfEcqX0bW
         h4Fg==
X-Received: by 10.69.3.97 with SMTP id bv1mr32226018pbd.73.1364425020123;
        Wed, 27 Mar 2013 15:57:00 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id mz8sm22986269pbc.9.2013.03.27.15.56.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 27 Mar 2013 15:56:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130327175358.53903fae@hoelz.ro>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219350>

Rob Hoelz wrote:

> My mistake; I had not seen it!  I thought you may have found a bug in
> my implementation, so I wanted to double check. =)

Well, I had found an unfortunate consequence of the implementation
that uses an unnecessary copy. :)

Will follow up to the updated patch.
