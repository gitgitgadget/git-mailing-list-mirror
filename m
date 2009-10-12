From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 2/3] git config: clarify bool types
Date: Mon, 12 Oct 2009 14:30:35 +0200
Message-ID: <4AD3216B.7030507@drmicha.warpmail.net>
References: <1255293973-17444-1-git-send-email-felipe.contreras@gmail.com>	 <1255293973-17444-2-git-send-email-felipe.contreras@gmail.com>	 <1255293973-17444-3-git-send-email-felipe.contreras@gmail.com>	 <7v7hv1kxyg.fsf@alter.siamese.dyndns.org> <94a0d4530910120303y205e6cfeg80ba0dfd6ed5a045@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 14:38:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxKAa-0003nL-Ii
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 14:38:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755662AbZJLMbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 08:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754736AbZJLMbU
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 08:31:20 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:43230 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755072AbZJLMbU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Oct 2009 08:31:20 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 0931AA398C;
	Mon, 12 Oct 2009 08:30:44 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 12 Oct 2009 08:30:44 -0400
X-Sasl-enc: TtihhFqpuNqNUeCoKjxQJApaA+8qlNpPfGCzjVg2FEtI 1255350643
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 431A869863;
	Mon, 12 Oct 2009 08:30:43 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5pre) Gecko/20091012 Lightning/1.0pre Shredder/3.0pre
In-Reply-To: <94a0d4530910120303y205e6cfeg80ba0dfd6ed5a045@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130008>

Felipe Contreras venit, vidit, dixit 12.10.2009 12:03:
> On Mon, Oct 12, 2009 at 8:01 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> The value is what it is, the --bool and --bool-or-int options don't
>>> specify the value type, just how it is interpreted. For example: a value
>>> of '1' can be interpreted as 'true'.
>>
>> It is not really about "interpreting", but about showing, isn't it?
> 
> Unless you are setting it, instead of reading it.
> 

I'd still suggest fixing the typo ("interpreted") and spelling out
"boolean".

Michael
