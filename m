From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/7] pack-protocol.txt: Add warning about protocol inaccuracies
Date: Wed, 01 Jul 2015 12:52:10 -0700
Message-ID: <xmqqk2uj8xlh.fsf@gitster.dls.corp.google.com>
References: <1435774099-21260-1-git-send-email-dborowitz@google.com>
	<1435774099-21260-2-git-send-email-dborowitz@google.com>
	<20150701193949.GC4865@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Dave Borowitz <dborowitz@google.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 21:52:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAO3Q-00027c-7J
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 21:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752087AbbGATwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 15:52:15 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:33909 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbbGATwM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 15:52:12 -0400
Received: by igcsj18 with SMTP id sj18so143885930igc.1
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 12:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=r725mVZqbJjUMuoRnRY902odMyRvAJl5E+j7GmKyX/U=;
        b=pheYYgU/uPIQ1NRnbfgHEC6bkaPYe3y0n6dFYPXXJGJJw/fttWOaDsBsoy8uQENvk1
         ss9EwEZe65BndIoMSEfup3nRRKijyNeyRY+YOBMg3iyFxydwKwMsU75cLEOGhMf8/8Qu
         eBlkR/0tmrQbtmkOuHG9cLw5OEaBcSX+QpnybrFsmlCQNAW8csHHxL/08nTQj3EKRenQ
         oMw4d3FUeQosxWyix1DQ+s8pb76GoPPscYVpNQRjB9/XD4iFbMoD6G458hJy1hxoAhJM
         4HKkU9ZDwgZP1L1DiF2PNe0DJ618OSi6cnavrVvlmhfzHOu85I5eYpMwPEUFz76fN71S
         evxA==
X-Received: by 10.42.131.202 with SMTP id a10mr6861529ict.49.1435780332241;
        Wed, 01 Jul 2015 12:52:12 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:64b9:4225:baa1:c97c])
        by mx.google.com with ESMTPSA id b17sm2102325iod.32.2015.07.01.12.52.11
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 Jul 2015 12:52:11 -0700 (PDT)
In-Reply-To: <20150701193949.GC4865@google.com> (Jonathan Nieder's message of
	"Wed, 1 Jul 2015 12:39:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273192>

Jonathan Nieder <jrnieder@gmail.com> writes:

> The 'Reference Discovery' section says:
>
> 	Server SHOULD terminate each non-flush line using LF ("\n") terminator;
> 	client MUST NOT complain if there is no terminator.

I think these should be "sender/receiver", not "server/client".
