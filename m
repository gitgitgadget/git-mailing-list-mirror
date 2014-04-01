From: Justin Lebar <jlebar@google.com>
Subject: Re: [PATCH v5 1/4] Documentation: Fix misuses of "nor"
Date: Tue, 1 Apr 2014 09:48:25 -0700
Message-ID: <CAMuNMfokH8cVwYmuPX7jY+i6Vp9nPKLS+7rZKUyMvw-8yDOGmQ@mail.gmail.com>
References: <1396303907-23291-1-git-send-email-jlebar@google.com> <xmqqtxae0xe7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 18:52:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV1vY-0007FE-Om
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 18:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbaDAQsu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 12:48:50 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:35372 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096AbaDAQsq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 12:48:46 -0400
Received: by mail-qg0-f54.google.com with SMTP id a108so5702887qge.41
        for <git@vger.kernel.org>; Tue, 01 Apr 2014 09:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vDKTQ7isxRqxJgWHLuG4CNCBY733xw+RHJmAL0VPIls=;
        b=pDbhDLy7KH8+IpeIgVa9lz2tyeH2xO81FJbBcIOl/MCcc80YO07IzbH2Ow9u0J7N5w
         wlwTLsQ9TSog9uQbqugx/ij3Ud6iflmnb1OF0xO9l4Ah4ILGAucekmeV9rAy99PeuZ1N
         EXMFXOrc4xtaXlzQta7JzIRlILeLTXzR+dP14BbOTg/CpwnHMqN1DNPXSA40VRaYgIXy
         ctkaxY0RuYiSAImGOwD1MQ6wB5X1DR4xL6tZXh3OyNdt+4TvLKojGnM9zR0Ecvoc4Cqd
         hqXHquIORJcyys7NAwAJ3ZRZVVpSY8VXy5KcEXsXQ25SQJhfbgLFHeWVjWWhIKIDD7yn
         mmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=vDKTQ7isxRqxJgWHLuG4CNCBY733xw+RHJmAL0VPIls=;
        b=K5OBzZceuB1/wR263vExhtVN9iR8hG5FDvYzDN1og4pElE1oN6dP2Xpxk5+FfLeXEz
         xMWCz/I4URYZcq2EVoo9LphnESidJyF4v2427Os6B5INpwIBSce1haNLknsrLsMoEAwb
         FvZEMYzXhZTx+ZDXIV00qmXpH/KEsxe/w9ZdvXCD0USnfBTeHa0jOXsNwZ7/6pdTtsGA
         Q8BDVObX9fXEbxZwwu2vhyMJ1KIrYJlAsGSm8aqbfROIr8/7NOrc9bLx7IgXdaFL1utm
         R2apv3spRb4vslo3+s7+1NIEKMrf1BMP1SnWnnQe/MilcknEBXTHhCdwzNk1a/CaRg3m
         +RAw==
X-Gm-Message-State: ALoCoQk895V+j7nKIsyIJq1gVN/88PBdbmY8hfhcG/k+jPoA54NJhlcd3lqN2OgfWYpDy4AdDjFACjyXZJrzHSExT154jS3T9wzx2n9ezpRBkhL1ZoU/0heo2ZwCd0Z4yxWNL8bnDC3UubpdiY/9HCdnPBsHURnLU3qkVblS/abzPuRJsEDQclGLyfE9uOPw6hvNrHEjMohV
X-Received: by 10.224.125.194 with SMTP id z2mr3717932qar.99.1396370925324;
 Tue, 01 Apr 2014 09:48:45 -0700 (PDT)
Received: by 10.96.69.36 with HTTP; Tue, 1 Apr 2014 09:48:25 -0700 (PDT)
In-Reply-To: <xmqqtxae0xe7.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245615>

Thanks a lot, Junio.

It's unclear to me: Are we done with this patch queue, or do I need to
worry about getting these patches into another branch?  If the latter,
I'll update patch v5 per your comments.

-Justin

On Mon, Mar 31, 2014 at 4:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Four patches queued on 'pu' as-is (but retitled).  I didn't read
> everything very carefully, though.
>
> Thanks.
