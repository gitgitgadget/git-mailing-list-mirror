From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: Re: [PATCH] rebase -i: inform the user they can re-order commits
Date: Fri, 16 Mar 2012 16:07:09 +0100
Message-ID: <4F63571D.4070405@seap.minhap.es>
References: <4F63205A.6000202@seap.minhap.es><vpqlin0n8w5.fsf@bauges.imag.fr> <7vty1oivub.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 16 15:08:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8Xph-0008F9-Oo
	for gcvg-git-2@plane.gmane.org; Fri, 16 Mar 2012 15:08:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032239Ab2CPOIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 10:08:37 -0400
Received: from luthien2.mpt.es ([82.150.0.102]:3121 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753374Ab2CPOIg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 10:08:36 -0400
Received: from correo.map.es (unknown [10.1.24.76])
	by luthien2.map.es (Postfix) with ESMTP id 34B2724DEE;
	Fri, 16 Mar 2012 15:08:19 +0100 (CET)
Received: from [10.47.128.147] (unknown [10.1.29.55])
	by correo.map.es (Postfix) with ESMTP id 8EFEA2C4F0;
	Fri, 16 Mar 2012 15:08:11 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
In-Reply-To: <7vty1oivub.fsf@alter.siamese.dyndns.org>
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: 34B2724DEE.EBB34
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1332511702.72011@VRuuSPOLisTDlYyGOJ+cXg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193261>

On 03/16/2012 01:17 PM, Junio C Hamano wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> 
>> Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es> writes:
>>
>>> +# You can re-order the commit lines to affect the order on which
>>> +# the commits will be applied.
>>
>> That's probably the main use of "rebase -i", so it deserves a mention,
>> yes.
> 
> Erm, read in isolation by people like you who _know_ what the command
> does, the addition might look sensible, but I find that line of thinking
> somewhat disturbing in the first place.
> 
> These are meant to be a short _reminder_ for people who _learned_ how the
> command they already _know_ is spelled.
> 
> If the user does not even know that one of the primary use of the command
> is to reorder, isn't he playing with fire?

In an ideal world everybody should study the manpages and documentation of
a program prior to using it, unfortunately most people often start with an
easy-to-follow tutorial where there are commands to type in, the user
will type them (confident in the tutorial reputation) and try to learn along
the way, in this case giving the user more indications about what he can 
do in any moment is, in my opinion, a good thing (as git already does). 


> If we come up with a politely worded message that makes the user realize
> that the user does not know what he is doing and gently nudges the user to
> read the documentation before continuing to potentially harm himself, that
> would be a good addition, but...
> 
> So, I dunno.
