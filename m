From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/WIP v3 2/4] for-each-ref: introduce new structures for better organisation
Date: Thu, 28 May 2015 14:18:40 -0700
Message-ID: <xmqqmw0ofljj.fsf@gitster.dls.corp.google.com>
References: <5567527A.6090607@gmail.com>
	<1432835025-13291-2-git-send-email-karthik.188@gmail.com>
	<vpqegm0o3dx.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 28 23:18:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy5CR-0005h7-F4
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 23:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754645AbbE1VSo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 17:18:44 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:33624 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753959AbbE1VSm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 17:18:42 -0400
Received: by igbpi8 with SMTP id pi8so463548igb.0
        for <git@vger.kernel.org>; Thu, 28 May 2015 14:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=XsC696nWOkyMUr31ZK004yUGknIFZ3S9Vj5l3Zxnkqc=;
        b=s/CVK1DUO8hvsfg7LDk87Ye0FEyScB7Y3r1MZcEhSlXdgiav7QBUg7LEdhhe46Pp5j
         r1cKlAtYlmnMjgVHakwmOlWYlETbbtnCYCtVOeq5BjvQVR2XnHNDSqAcNaXbUHUF4kj7
         9IiK0dfQDuNv9So5aoB+VkQp/Twh4x79zyo9FiWl+6Fk9+DwXrNf7icii2pl6W7DiUQ+
         jb5xaiVZotRc2KNjDm+mtoeJUjB2nWpovAl7NiZ0Mx6mxqKFVroFquuM5YSpPLQz+3wx
         kEzD4kVLDsa39v/MCAyHvt3D8r2T4m+mOP/hvUl3z/RmMdNRKhJQWTRq2Qscph+kAUSj
         Tbvg==
X-Received: by 10.107.137.80 with SMTP id l77mr5925370iod.92.1432847922139;
        Thu, 28 May 2015 14:18:42 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:89d0:c49e:8012:77d2])
        by mx.google.com with ESMTPSA id c20sm2643083ioc.40.2015.05.28.14.18.41
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 28 May 2015 14:18:41 -0700 (PDT)
In-Reply-To: <vpqegm0o3dx.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	28 May 2015 22:26:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270200>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Not very important, but two spaces after a period is what one is
> supposed to do in English. Not everybody follow the rule, but it seems
> backward to change the code to break it.

I am old fashioned enough to personally agree, but this practice
that originates in the typewriter era is frowned upon in many
circles, including those who work with professional typesetters, I
think.

Sent off-list to reduce noise level; this is an issue that attracts
a lot of useless comments.
