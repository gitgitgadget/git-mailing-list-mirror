From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] document string_list_clear
Date: Tue, 9 Dec 2014 12:21:52 -0800
Message-ID: <20141209202152.GZ16345@google.com>
References: <1417830678-16115-1-git-send-email-sbeller@google.com>
 <20141206020458.GR16345@google.com>
 <20141206053024.GE31301@peff.net>
 <xmqq388omwzr.fsf@gitster.dls.corp.google.com>
 <20141209201551.GA12001@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 09 21:22:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyRIK-0004aM-E5
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 21:22:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752813AbaLIUV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 15:21:58 -0500
Received: from mail-ie0-f178.google.com ([209.85.223.178]:62098 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752761AbaLIUV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 15:21:56 -0500
Received: by mail-ie0-f178.google.com with SMTP id tp5so1303291ieb.9
        for <git@vger.kernel.org>; Tue, 09 Dec 2014 12:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=gZdWv2scM4RHcA5ecg38/1L9h8lMojomiD1nhH23H/Q=;
        b=pRYWJs2ijEsaEkKxxf7+/A3yoNY81kVGyPDZC90cshSmhCPbue1kiMqYN+VrZdHQ0O
         maSA/VsuA/kHRayBcESTIL0Qrff5j7hjct9OiJSVTA0wzyjCDjToprUhNfUbLyMwCeUw
         uLowqG9MAIVEF8hf0/D6WtolXJ053YpIQJPnib0sUMAXDpW5fDC4Q+1jliRuiy2AIJJM
         eAaSWexKUbp+JQwo5KCI/E9ufUMuX1qjg+XWkezYHaulIgyj79pp0Inlrc9ZDxiEbal4
         clWuXWrlXxdEf2Oz2r09IgSXFmgOqrcSWELVB7Ss6eaINzEaLKIrVRTDm9Phn3ErhRtD
         OSNg==
X-Received: by 10.42.194.17 with SMTP id dw17mr3658436icb.4.1418156515318;
        Tue, 09 Dec 2014 12:21:55 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:41c9:2fc6:1317:4ac])
        by mx.google.com with ESMTPSA id nm13sm1390707igb.5.2014.12.09.12.21.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Dec 2014 12:21:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141209201551.GA12001@peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261158>

Jeff King wrote:
> On Tue, Dec 09, 2014 at 11:41:44AM -0800, Junio C Hamano wrote:

>> Yeah, that is a thought.
>>
>> Some existing documentation pages like allocation-growing may not be
>> a good match for this strategy, though; cache.h has a lot more than
>> just alloc-grow, and there needs to be a way to generate more than
>> one API docs from a single header (and vice versa, taking text from
>> more than one source for a single API, I suspect).
>
> I think that would be a matter of tool support for saying "now I am
> outputting api-foo" in the inline documentation[1]. It does make writing
> Makefiles a lot harder, though, if there isn't a one-to-one
> correspondence between targets and their sources. Perhaps it is a sign
> that we should split our include files more along functional boundaries.

Yeah, I think a separate alloc-grow.h would be fine.

Thanks,
Jonathan
