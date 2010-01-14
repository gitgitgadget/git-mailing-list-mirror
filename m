From: Chris Johnsen <chris_johnsen@pobox.com>
Subject: Re: [PATCH v2 1/3] strbuf_expand: convert "%%" to "%"
Date: Thu, 14 Jan 2010 05:47:09 -0600
Message-ID: <CABC23EF-410F-461C-936F-7BE72E9822BC@pobox.com>
References: <20100113173408.GA16652@coredump.intra.peff.net>
 <20100113173531.GA16786@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Adam Megacz <adam@megacz.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 14 12:48:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVOBG-0007Fp-Tn
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 12:48:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752698Ab0ANLr6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 06:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752463Ab0ANLr6
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 06:47:58 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44343 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752137Ab0ANLr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 06:47:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A63490D3D;
	Thu, 14 Jan 2010 06:47:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=in-reply-to
	:references:mime-version:content-type:message-id:cc
	:content-transfer-encoding:from:subject:date:to; s=sasl; bh=/P0w
	1mOskFDetqH4jHiLIz7zOjQ=; b=AXLKCnOoEtsssoWl6Ua8mtbG5/hjyns4BVt3
	0YmaU4tv35Snnu9PhgbXTPdeE+CSrTqqUTLlirh42pOQXPgc8vei/TtBlE1t2FC9
	p0mUU0T4x8oiu4zKM4hn84mqc16hFx8i9GzgECtrEHTMchY73iCUqtBKts/ad/DV
	CD15Xvc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=in-reply-to
	:references:mime-version:content-type:message-id:cc
	:content-transfer-encoding:from:subject:date:to; q=dns; s=sasl; b=
	OJW+n4srhKyzzjKizSqxEuF+nm7JlTyUf9PYVLZJvMcDCLUUeTgwW0wzulG/2a9T
	3Y+gZlzeZbh56hjYxh9T/+Xw0WZhqlEwChGiKtPCK7npFurwrQL4S+mPc4RmuWpE
	m/ee6YjSvlUF42YIHaYqQr9QUP1vcIkNYHU0qijRIJA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2267A90D3C;
	Thu, 14 Jan 2010 06:47:50 -0500 (EST)
Received: from [192.168.1.241] (unknown [75.53.33.9]) (using TLSv1 with
 cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A56CF90D3B; Thu, 14 Jan
 2010 06:47:44 -0500 (EST)
In-Reply-To: <20100113173531.GA16786@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.753.1)
X-Pobox-Relay-ID: A438146C-0102-11DF-9649-6AF7ED7EF46B-07245699!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136988>

On 2010 Jan 13, at 11:35, Jeff King wrote:
> Signed-off-by: Jeff King <peff@coredump.intra.peff.net>

The patches of the v2 of this series (well, except "4/3") all use  
this surprising, "extended" hostname in their Signed-off-by lines. I  
suppose you unset user.email while testing the series and sent these  
out before restoring your normal configuration.

Sorry for the noise if this was intentional (a small joke about the  
auto-configured ident info?).

-- 
Chris
