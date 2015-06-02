From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFCv2 06/16] remote.h: add new struct for options
Date: Tue, 02 Jun 2015 14:43:50 -0700
Message-ID: <xmqqzj4hzsyx.fsf@gitster.dls.corp.google.com>
References: <1433203338-27493-1-git-send-email-sbeller@google.com>
	<1433203338-27493-7-git-send-email-sbeller@google.com>
	<xmqqh9qp24hx.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZ5q1bbHjVL3W6gT7QceQdza9+Lquu6vzcjO6vKeu7fSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 23:44:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YztyY-0002i8-0f
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 23:43:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171AbbFBVny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 17:43:54 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:33989 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078AbbFBVnw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 17:43:52 -0400
Received: by igbhj9 with SMTP id hj9so97315826igb.1
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 14:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=0MEC2K2NFl1fdeW4hRAEELEa4V+27YPUlyIuNYF7XVY=;
        b=0CMQHSRJOKQUvnY6/PiKnmCvAdZuLgw266lqMSRhvFiXyalkchc/pgqlW0D7voDNTJ
         WiKzGnXKuhBgFSg8gdjoCV7UqaMe/LexLnxulFVfK3n6k2pqKCmAZw+1PPOyqTJY4VNb
         woAW2HmGdzWifWnLUPCRr79ybADn2qLajUTj9VZn+u0Oy0SOLPyzEM3rJBWfUJuk3qGM
         5yGaydr3AnMBQYn5VNlmoDleoDA/8k0+ygx/BBwDS7E/Bo7HSh7ay1w2L1LYN7GCJhQE
         UNLs6lkfHkN0Q0ra9Vhuq4cQcYg+nThz84VyJ4O/WYzgqURF5HbiR8wTrpTjkC5Ue1VF
         15+Q==
X-Received: by 10.50.8.68 with SMTP id p4mr23262830iga.4.1433281431976;
        Tue, 02 Jun 2015 14:43:51 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3140:53f3:e8c0:89b0])
        by mx.google.com with ESMTPSA id y124sm13362518iod.13.2015.06.02.14.43.51
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Jun 2015 14:43:51 -0700 (PDT)
In-Reply-To: <CAGZ79kZ5q1bbHjVL3W6gT7QceQdza9+Lquu6vzcjO6vKeu7fSQ@mail.gmail.com>
	(Stefan Beller's message of "Tue, 2 Jun 2015 14:40:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270608>

Stefan Beller <sbeller@google.com> writes:

> On Tue, Jun 2, 2015 at 2:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Why?
>>
>
> To have all options required for selecting the capabilities
> together in one struct.

No need to explain in the e-mail, as that won't be kept in our
history, unless you write it in your reroll.  Just keep them in mind
and try not to forget when you reroll ;-).

Thanks.
