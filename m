From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 04/10] pkt-line: change error message for oversized packet
Date: Wed, 20 Feb 2013 00:54:15 -0800
Message-ID: <9aaf7cad-3709-4140-b18d-3287227efd36@email.android.com>
References: <20130218091203.GB17003@sigill.intra.peff.net> <20130218092221.GD5096@sigill.intra.peff.net> <7vd2vyarjy.fsf@alter.siamese.dyndns.org> <20130218094959.GA16408@sigill.intra.peff.net> <7v1ucdb9gw.fsf@alter.siamese.dyndns.org> <20130218213331.GA29200@sigill.intra.peff.net> <20130220084754.GA17055@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 20 09:56:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U85TG-0006Bj-V6
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 09:56:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932893Ab3BTIzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 03:55:47 -0500
Received: from mail-pb0-f45.google.com ([209.85.160.45]:33513 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932597Ab3BTIzq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 03:55:46 -0500
Received: by mail-pb0-f45.google.com with SMTP id ro8so2758741pbb.18
        for <git@vger.kernel.org>; Wed, 20 Feb 2013 00:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:user-agent:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding:subject:from:date:to:cc
         :message-id;
        bh=ZahBIgkTfJbG49HvGWTM5sYd5kTm9PbYKpJz09YBoOs=;
        b=Ciqt3TvjMmGdtRXLH9Z/mk86JYNnmiPEYn53KSgR9Hd5jK5Mn00oK9AQfk3XfP6McH
         8A2FY1EFNXPLNQKHUBuBKj1oSwKW7RFas70AU93fo5rv3Hy0zb4GDwVWyDV8bF+Qi17f
         kSkYR4KLN5/Y5+hiTwNS2IvQP15EopVBSXSOyZ7FKxaKWs62YhwD8UmXZ9Bat6USoNje
         +aiBHbK//s22ZzEMYv5XKIPDeDZoT9rh2ZhzbNkfLwwIffpTyOFAi5dyKA+zO8pFgb6c
         KtispZX9AkKPm4UVH1Y4VyggB2q0+jLIPhPt8t466zWeQmJTkSuOxPPc1B+IosT38jlz
         RyDg==
X-Received: by 10.68.196.193 with SMTP id io1mr1311695pbc.196.1361350546003;
        Wed, 20 Feb 2013 00:55:46 -0800 (PST)
Received: from [192.168.2.101] (c-98-234-214-94.hsd1.ca.comcast.net. [98.234.214.94])
        by mx.google.com with ESMTPS id bi2sm110518701pab.18.2013.02.20.00.55.43
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 20 Feb 2013 00:55:44 -0800 (PST)
User-Agent: K-9 Mail for Android
In-Reply-To: <20130220084754.GA17055@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216696>



Jeff King <peff@peff.net> wrote:
>
>In the meantime, please hold off on what I've posted so far (that
>includes the jk/smart-http-robustify topic).

Surely. I'm done for the night already. Looking forward to see the reroll tomorrow.

Thanks.
-- 
Pardon terseness, typo and HTML from a tablet.
