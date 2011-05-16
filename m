From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCHv3 6/9] receive-pack: Prepare for addition of the new
 'limit-*' family of capabilities
Date: Mon, 16 May 2011 15:02:59 -0700
Message-ID: <BANLkTimUWHiUdxbBfvvcomqmzQxLPhUsZA@mail.gmail.com>
References: <201105151942.29219.johan@herland.net> <1305495440-30836-1-git-send-email-johan@herland.net>
 <1305495440-30836-7-git-send-email-johan@herland.net> <7vaaenm957.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johan Herland <johan@herland.net>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 17 00:03:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QM5tB-0006c7-I5
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 00:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753078Ab1EPWDk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 18:03:40 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:56054 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668Ab1EPWDk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 18:03:40 -0400
Received: by qwk3 with SMTP id 3so2510503qwk.19
        for <git@vger.kernel.org>; Mon, 16 May 2011 15:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=wPOaUSugLfytdc2rzFQj4BrFLyb63rqpHVB+KxfGxzQ=;
        b=Ut+wF0qhKqlwNuRyHH/4rGjfcuw7wAjcZo5ja9Mdbs9ZTlcaW2QIp1LzJA29mxcRqF
         hXuf4ZArRC1q+zITHIyXCtG6ChQvOWqqpXBu83g4vhqmhZnfkHKXZRMz1Y6DFiDv3PXV
         YXA64teVWnbQm4RiSvGkbPVsoDpsx3UGWsK5w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=tKIvJL3SwzxGHqkyszxGbnDTmQLf0oiIhZrVrF/p89RFfjBpk8HdcUj2u8+KPtxV6p
         WJl9buwqJ+sNoz6aOPDCY3RCv4uikQumgMkZNEJ/JmEh9JNxGQmgnWj44Vw/FeDSbcDD
         4N7YQrDWeF1xKbigmbKuICBurhOkoldWupRLM=
Received: by 10.229.43.142 with SMTP id w14mr3805879qce.27.1305583419132; Mon,
 16 May 2011 15:03:39 -0700 (PDT)
Received: by 10.229.229.5 with HTTP; Mon, 16 May 2011 15:02:59 -0700 (PDT)
In-Reply-To: <7vaaenm957.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173766>

Heya,

On Sun, May 15, 2011 at 23:50, Junio C Hamano <gitster@pobox.com> wrote:
> We should tighten this strstr() to make sure we are not matching in the
> middle of a string, and the need to do so is even greater now that you are
> going to introduce "foo=<value>" and the value could even be strings in
> the future.

If we are writing this down somewhere, should we also dictate how
spaces should be escaped to be "forward-compatible"?

-- 
Cheers,

Sverre Rabbelier
