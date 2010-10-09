From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 2/3] Submodules: Add the new "fetch" config option for
 fetch and pull
Date: Sat, 09 Oct 2010 22:12:06 +0200
Message-ID: <4CB0CC96.4050905@web.de>
References: <4C935D77.3080008@web.de> <329A2E43-ADE3-467C-A2A6-24ACB9DF641E@sb.org> <4C953DE5.6020900@web.de> <DD3654D9-46B9-4980-9138-38FDC33A383C@sb.org> <4C963D00.9050207@web.de> <28BC3A45-D3CF-4A8C-A818-B92A9827C8FB@sb.org> <4CAB8DDF.8080004@web.de> <4CAB8E33.1030208@web.de> <AANLkTikUdNdDDK9-+AjuSO_RJHNBZEp5mHPRnsV0Fo0v@mail.gmail.com> <4CB0C0DC.40108@web.de> <20101009195446.GA19064@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jon Seymour <jon.seymour@gmail.com>, Kevin Ballard <kevin@sb.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 09 22:12:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4fmh-000151-8g
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 22:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760531Ab0JIUMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 16:12:08 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:37011 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760492Ab0JIUMH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 16:12:07 -0400
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate01.web.de (Postfix) with ESMTP id A3C9016DB7FB6;
	Sat,  9 Oct 2010 22:12:06 +0200 (CEST)
Received: from [93.246.43.182] (helo=[192.168.178.29])
	by smtp01.web.de with asmtp (WEB.DE 4.110 #24)
	id 1P4fm2-0003HF-00; Sat, 09 Oct 2010 22:12:06 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <20101009195446.GA19064@burratino>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18PTShtanJtY9NgGW/SW+VFzw3O4NkSkMiKGkg1
	YP9jT90OTe4fXz9WGoLqjRDcFjC6EHCbgSGfbWuXS/xa/a3Soy
	6L7FDFxlXeKTteumGa0Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158603>

Am 09.10.2010 21:54, schrieb Jonathan Nieder:
> Jens Lehmann wrote:
>> I think that's a valid point (especially as we might add the --recursive
>> option to other commands too). I will change the option name as proposed
>> in the next version.
> 
> That would look like
> 
> 	[submodule "<name>"]
> 		fetch.recursive = ...
> 
> in files with .git/config syntax.  Maybe fetchRecursive or similar
> would be more consistent with existing variables?

Yes, it looks like fetchRecursive would be a better choice.
