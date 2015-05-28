From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/WIP v3 2/4] for-each-ref: introduce new structures for better organisation
Date: Thu, 28 May 2015 14:28:37 -0700
Message-ID: <xmqqiobcfl2y.fsf@gitster.dls.corp.google.com>
References: <5567527A.6090607@gmail.com>
	<1432835025-13291-2-git-send-email-karthik.188@gmail.com>
	<vpqegm0o3dx.fsf@anie.imag.fr>
	<xmqqmw0ofljj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 28 23:28:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy5MH-0004T7-Vi
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 23:28:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbbE1V2o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 17:28:44 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:32840 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932320AbbE1V2k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 17:28:40 -0400
Received: by igbpi8 with SMTP id pi8so631052igb.0
        for <git@vger.kernel.org>; Thu, 28 May 2015 14:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=6vIrv4iudhTXkS159IF++7i5GyXd3K8oF+GPOiz+HcY=;
        b=jGT8KjFC71XqgP1HGT7OAlFywHII6SrFK/RGzEbTeYpvAZB+fO5GrfysmJoGjXbPzy
         jwhc6myZOPtEg23zBeLxssLOwQ/lEnfTN9AFNIYox0y2e+4jNwX8Xg/4V42VyyOkw+as
         HljRLMoRj8R5w/8MRsf4GvIZodPv4wWJTkSJAXIXDTmX7a8TkiX9/SFGkjZXUklWOAhe
         i9NkNTKNZufxEevxDCRNMF1AhmqzkodTg+c+4j+DgNfUKiAXwZqBnvqWQkCC0IQBoWql
         C4NB/EpgP2efrEOUkbKT8tPDwt+dgV1RMlydwzBs3j4HI/vqmgZKVMW1+Vk5cUhi0o7Y
         qDug==
X-Received: by 10.50.64.147 with SMTP id o19mr13796782igs.33.1432848519398;
        Thu, 28 May 2015 14:28:39 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:89d0:c49e:8012:77d2])
        by mx.google.com with ESMTPSA id i85sm2662621iod.41.2015.05.28.14.28.38
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 28 May 2015 14:28:38 -0700 (PDT)
In-Reply-To: <xmqqmw0ofljj.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 28 May 2015 14:18:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270202>

Junio C Hamano <gitster@pobox.com> writes:

> Sent off-list to reduce noise level; this is an issue that attracts
> a lot of useless comments.

Heh, somehow I screwed up and sent on-list X-<.
