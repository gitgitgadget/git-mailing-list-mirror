From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 2/2] completion: complete config variables for  --get/getall/unset/unset-all
Date: Wed, 13 May 2009 11:33:57 -0700
Message-ID: <7vtz3o4zu2.fsf@alter.siamese.dyndns.org>
References: <1241832213-23070-1-git-send-email-bebarino@gmail.com>
	<1241832213-23070-2-git-send-email-bebarino@gmail.com>
	<1241832213-23070-3-git-send-email-bebarino@gmail.com>
	<20090509034438.GZ30527@spearce.org> <4A09071A.1030107@gmail.com>
	<7vtz3q91up.fsf@alter.siamese.dyndns.org>
	<780e0a6b0905121205r7a57a99as2cb0b94ead73199d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 20:34:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4JHK-0004zC-Mq
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 20:34:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758762AbZEMSd6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 14:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755816AbZEMSd5
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 14:33:57 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:50264 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755558AbZEMSd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 14:33:57 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090513183358.PXWS18948.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 13 May 2009 14:33:58 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id r6Zx1b00N4aMwMQ046Zx77; Wed, 13 May 2009 14:33:57 -0400
X-Authority-Analysis: v=1.0 c=1 a=IRI1rScfeIUA:10 a=aikODBtY-mwA:10
 a=pGLkceISAAAA:8 a=YbIhH4ZWV4tkEA1A6PcA:9 a=gbWvHUyfzVsJHmfAF0Bli3T-YYwA:4
 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <780e0a6b0905121205r7a57a99as2cb0b94ead73199d@mail.gmail.com> (Stephen Boyd's message of "Tue\, 12 May 2009 12\:05\:05 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119084>

Stephen Boyd <bebarino@gmail.com> writes:

>>> Subject: completion: complete config variables for
>>> --get/getall/unset/unset-all
>>
>> Hmm, shouldn't this just be
>>
>>    Subject: completion: complete variable names for "git config" command
>>
>> ?
>>
>
> This patch adds completion for set variable names when --get,
> --get-all, --set, or --set-all has been specified. Completion of
> variable names for git config already exists. Maybe this would be more
> clear:
>
> Subject: completion: complete set variable names for git config
> --get/get-all/set-set-all

Actually I was shooting for shorter description.  It is more like

	bash: complete variable names for "git config" with options

perhaps?
