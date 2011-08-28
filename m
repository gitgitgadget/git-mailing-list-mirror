From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2 3/5] git-branch: introduce missing long forms for the
 options
Date: Sun, 28 Aug 2011 16:05:37 +0200
Message-ID: <4E5A4B31.80402@drmicha.warpmail.net>
References: <20110825175301.GC519@sigill.intra.peff.net> <c79179fa3476629ce47556c219719495c213f5f9.1314367414.git.git@drmicha.warpmail.net> <7vk4a0drjj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 28 16:55:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxglQ-000078-9h
	for gcvg-git-2@lo.gmane.org; Sun, 28 Aug 2011 16:55:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751692Ab1H1OzD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Aug 2011 10:55:03 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:55484 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751580Ab1H1OzA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Aug 2011 10:55:00 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 98C63208F4;
	Sun, 28 Aug 2011 10:54:59 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute5.internal (MEProxy); Sun, 28 Aug 2011 10:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=VrEQItKN7QhR7qxJ9w0xe3
	pL8bM=; b=mET0oTrhsgxh3UUlM03xD39c7SusCkJ8YUSHUTz0NMpBRCHzYAmdPO
	tgs9/HN+gKqYtFpnQNem0WbiLvCzFoDXQwnkKC9W6Y1QvYZqb7CLPJwv1W8nom6n
	jF1DaJPZShFknjHiSHh6YyqjU5yXQiXsd/Hp7WUiZW3KZ6wn3xEo8=
X-Sasl-enc: xOb1AkS301fnAPF3kAwmtOXjC6UcO8DfFyKFuOZCp6lg 1314543299
Received: from localhost.localdomain (p54859364.dip0.t-ipconnect.de [84.133.147.100])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 87091A00252;
	Sun, 28 Aug 2011 10:54:58 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <7vk4a0drjj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180275>

Junio C Hamano venit, vidit, dixit 26.08.2011 19:13:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> @@ -100,9 +103,11 @@ OPTIONS
>>  	Same as `--color=never`.
>>  
>>  -r::
>> +--remotes::
>>  	List or delete (if used with -d) the remote-tracking branches.
> 
> I am not sure if this should be "--remoteS".

like "git log --remotes".
