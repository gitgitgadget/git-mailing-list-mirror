From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: tracking submodules out of main directory.
Date: Tue, 28 Jun 2011 09:37:52 +0200
Message-ID: <4E0984D0.80506@web.de>
References: <1309180056.2497.220.camel@Naugrim.eriador.com>	 <7vvcvrxlol.fsf@alter.siamese.dyndns.org> <4E08C89E.5020109@web.de>	 <7vvcvrw0vn.fsf@alter.siamese.dyndns.org> <1309211460.2497.395.camel@Naugrim.eriador.com> <4E0980D5.8040004@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: henri GEIST <henri.geist@flying-robots.com>
X-From: git-owner@vger.kernel.org Tue Jun 28 09:40:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbSuO-0005cn-Rs
	for gcvg-git-2@lo.gmane.org; Tue, 28 Jun 2011 09:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756671Ab1F1HjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jun 2011 03:39:08 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:44989 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754630Ab1F1Hh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2011 03:37:56 -0400
Received: from smtp08.web.de  ( [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id D1D36192E28B5;
	Tue, 28 Jun 2011 09:37:54 +0200 (CEST)
Received: from [93.246.58.144] (helo=[192.168.178.43])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QbSrq-0003l4-00; Tue, 28 Jun 2011 09:37:54 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.18) Gecko/20110616 Lightning/1.0b2 Thunderbird/3.1.11
In-Reply-To: <4E0980D5.8040004@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+IbnW/TyZgfFhpEqLHPcOHNniJSAK4yqSBEtye
	YXeSAdgE2I7jxRFR2kA/s1f0WGRL73Or2ErN9Mgej1ybOLNXy7
	PfbRr/oE7pL4oy3n3Q/A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176387>

Am 28.06.2011 09:20, schrieb Jens Lehmann:
>> This could be a way if .gitmodules can contain something like
>>
>> 	[module "project one"]
>> 		path = project1
>>         	url = ...
>>                 depends = lib1	"123456"
>> 	[module "project two"]
>> 		path = project2
>>         	url = ...
>>                 depends = lib1	"abcdef"
>> 	[module "lib1"]
>>         	path = lib1
>>                 url = ...
> 
> But there is no need for that as "123456" and "abcdef" are already present
> as the sha1 values for the gitlinks "lib1" and "lib2".

... but of course you would have to decide which sha1 is the right one for
lib1, while your proposal offers two contradicting sha1s (note to self: must
drink coffee *before* answering emails in the morning ;-)
