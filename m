From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH 1/4] Document the HTTP transport protocol
Date: Thu, 15 Oct 2009 22:59:25 -0700
Message-ID: <4AD80BBD.8080504@zytor.com>
References: <1255065768-10428-1-git-send-email-spearce@spearce.org> <1255065768-10428-2-git-send-email-spearce@spearce.org> <7vskdss3ei.fsf@alter.siamese.dyndns.org> <slrnhd0nfv.tq2.antti-juhani@kukkaseppele.kaijanaho.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Antti-Juhani Kaijanaho <antti-juhani@kaijanaho.fi>
X-From: git-owner@vger.kernel.org Fri Oct 16 08:01:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyfsF-0005qW-Sa
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 08:01:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752534AbZJPGAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 02:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752380AbZJPGAF
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 02:00:05 -0400
Received: from terminus.zytor.com ([198.137.202.10]:45499 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944AbZJPGAE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 02:00:04 -0400
Received: from tazenda.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.3/8.14.3) with ESMTP id n9G5xP6m010046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Thu, 15 Oct 2009 22:59:26 -0700
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.1) Gecko/20090814 Fedora/3.0-2.6.b3.fc11 Thunderbird/3.0b3
In-Reply-To: <slrnhd0nfv.tq2.antti-juhani@kukkaseppele.kaijanaho.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130457>

On 10/10/2009 03:12 AM, Antti-Juhani Kaijanaho wrote:
> On 2009-10-09, Junio C Hamano <gitster@pobox.com> wrote:
>>> +If there is no repository at $GIT_URL, the server MUST respond with
>>> +the '404 Not Found' HTTP status code.
>>
>> We may also want to add
>>
>>     If there is no object at $GIT_URL/some/path, the server MUST respond
>>     with the '404 Not Found' HTTP status code.
>>
>> to help dumb clients.
> 
> In both cases - is it really necessary to forbid the use of 410 (Gone)?
> 

410 means "we once had it, it's no longer here, no idea where it went."
 It's a largely useless code...

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
