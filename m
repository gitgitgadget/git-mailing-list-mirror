From: Junio C Hamano <gitster@pobox.com>
Subject: Re: co-authoring commits
Date: Wed, 17 Jun 2015 12:58:58 -0700
Message-ID: <xmqq4mm66r99.fsf@gitster.dls.corp.google.com>
References: <CAOvwQ4i_HL7XGnxZrVu3oSnsbnTyxbg8Vh6vzi4c1isSrrexYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Tuncer Ayaz <tuncer.ayaz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 21:59:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5JUI-0001mU-6G
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 21:59:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbbFQT7B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 15:59:01 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:34372 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856AbbFQT7A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 15:59:00 -0400
Received: by igboe5 with SMTP id oe5so1958757igb.1
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 12:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=JyKKSmGTX3S48Sv/uz+YGJ7yo9Fo/IFicS4BeFoGqa4=;
        b=bF8VdavoVfU/DPdEYp+2VTIrwjm7/rpZPmiOAENId7k7OQcr1DhcxFP6HPEcanaJOk
         4fgiQu2ndKsqdSIP74MOeGDZkNrKV7VvQ1XgjVOADCJN+qwH/oLKlpV6C/ooidCVR8U3
         8PDl/6QLiaocESc0rV5jWOkXwhM2rfwIGE2znbEwTcbVlheyrQCAWM9GZyAybKeUv1BX
         Fb9YkLXmztguUv8gk/FsSpCN8BTp/45lj9tpv5PAFTUGW6FIbKl0JxQk9nhxzrkKU6OK
         ynW1n02Z60tksrg0u2EsGue+RNAj/3YcSnHKZRRMpPw9xd/X38XVvGeEXUSCkJo9w5yJ
         +W2Q==
X-Received: by 10.42.30.208 with SMTP id w16mr2101293icc.88.1434571139931;
        Wed, 17 Jun 2015 12:58:59 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a4d4:8fab:953e:ec65])
        by mx.google.com with ESMTPSA id l128sm3237193iol.1.2015.06.17.12.58.59
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Jun 2015 12:58:59 -0700 (PDT)
In-Reply-To: <CAOvwQ4i_HL7XGnxZrVu3oSnsbnTyxbg8Vh6vzi4c1isSrrexYQ@mail.gmail.com>
	(Tuncer Ayaz's message of "Wed, 17 Jun 2015 21:52:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271902>

Tuncer Ayaz <tuncer.ayaz@gmail.com> writes:

> Is this something that breaks the design and would never be implemented,

Yes.
