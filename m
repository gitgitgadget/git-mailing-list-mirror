From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/3] git-pack-objects: Automatically pack annotated tags
 if object was packed
Date: Tue, 04 Mar 2008 08:27:22 +0100
Message-ID: <47CCF9DA.4050304@viscovery.net>
References: <20080304023607.GA16152@spearce.org> <alpine.LFD.1.00.0803032144110.2947@xanadu.home> <20080304030658.GO8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 04 08:28:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWRZO-0000B1-Ex
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 08:28:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757453AbYCDH1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 02:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757403AbYCDH1b
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 02:27:31 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:45974 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210AbYCDH1b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 02:27:31 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JWRXy-0000dg-Kk; Tue, 04 Mar 2008 08:26:46 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 4C52F546; Tue,  4 Mar 2008 08:27:22 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080304030658.GO8410@spearce.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76042>

Shawn O. Pearce schrieb:
> Nicolas Pitre <nico@cam.org> wrote:
>> On Mon, 3 Mar 2008, Shawn O. Pearce wrote:
>>
>>> The new option "--auto-follow-tags" allows the caller to request that
>>> any annotated tag be included into the packfile if the object the tag
>>> references was also included as part of the packfile.
>> Wouldn't "auto-include-tag" a better name for this option?
> 
> Ooooh.  Indeed it would!
> 
> I shall respin this series based around this better name.

More bikeshedding: Why are you calling it "auto-"? If I tell the program
to "--include-tags", I expect it to happen automatically.

-- Hannes

