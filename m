From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] mv: better document side effects when moving a submodule
Date: Tue, 07 Jan 2014 18:57:53 +0100
Message-ID: <52CC4021.60209@web.de>
References: <CAByyCQCakKyUqJQDdFrTMf2CUJihRhqSUVCwT21VDN1EOerVWw@mail.gmail.com>	<52A602A2.6060909@web.de> <52CB023C.2050001@web.de> <xmqq8uushgz3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: George Papanikolaou <g3orge.app@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 18:58:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0aue-00018m-3R
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 18:58:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753473AbaAGR54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 12:57:56 -0500
Received: from mout.web.de ([212.227.17.11]:54008 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753007AbaAGR5z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 12:57:55 -0500
Received: from [192.168.178.41] ([84.132.139.6]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0M7KZO-1VDjzL2i50-00x25A for <git@vger.kernel.org>;
 Tue, 07 Jan 2014 18:57:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <xmqq8uushgz3.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:43TJh5hhCZC5wXBuZJvb6EUDXJQLqf3++fPeL+ibLAz0Tim1Fj8
 U/jiDNJm+8an8kg47H8ly25b/HqHFpTAFw9BiWNnmnQkD5LuiLP846Ma3gZ6DOfyVvYv2Ax
 eBV90Fzwi+ogqZODtO6JqLN6cgDGT2ZbaSz6k6563elVTxtsdhR0RrYOrtxIQgI4w+GYc6Y
 oEejoevaPgbVvdCdiqovA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240122>

Am 06.01.2014 23:40, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
>> Does this new paragraph make it clearer?
> 
> Don't we have bugs section that we can use to list the known
> limitations like this?

Right, will change accordingly in v2.

>>  Documentation/git-mv.txt | 10 ++++++++++
>>  t/t7001-mv.sh            | 21 +++++++++++++++++++++
> 
> It also may make sense to express the test as "this is what we would
> like to see happen eventually" in the form of test_expect_failure;
> it is not a big deal though.

We'll get the "what we would like to see happen eventually" test for
free from the recursive submodule update framework I'm currently
implementing, so I propose we don't implement this exepected failure
in this patch.
