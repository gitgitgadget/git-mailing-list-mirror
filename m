From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] push: Alias pushurl from push rewrites
Date: Mon, 18 Mar 2013 18:55:41 -0700
Message-ID: <20130319015541.GH5062@elie.Belkin>
References: <20130318220224.3b23a381@hoelz.ro>
 <20130318231043.GD5062@elie.Belkin>
 <7v38vsma9o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rob Hoelz <rob@hoelz.ro>, git@vger.kernel.org,
	josh@joshtriplett.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 02:56:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHlmg-0005X6-W0
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 02:56:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933149Ab3CSBzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 21:55:47 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:52369 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753970Ab3CSBzr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 21:55:47 -0400
Received: by mail-da0-f46.google.com with SMTP id y19so370126dan.19
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 18:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=/71Y91gZxuunR/iSLbGjBJgv2psjdO3nhNgHhqg8gRA=;
        b=rIetE0Z+xf+gyXLlg5lg42bVsiGtDXisuwPtOBnJFEjnGjfXBVk1P8aG+yDDld77aq
         m3J/Y19BVlsEho5/+PIeSHK8Cmn4fVE9DVeNtL37DTEKCcz/Llz1dRy87aBREubIskUY
         4U2SG5X8HukR9aJI9ED/xsYUPCFbJwwKg2dajgwClpntldDznW0rZzuhnEK2xsiEb6ZP
         cBUhJBLTv0f4Bs8jtQKQEuDFTA3xLrEkNi3c11+4szSMzMWdagtHBeTH5+Few0EHp7bj
         zyWcAiQfGf1I3mIqCTBkONQ3zegSfmzl3dqZp2gB+s2VkB7iNjmR9lpomrGaqZArOH7M
         N4bA==
X-Received: by 10.68.222.73 with SMTP id qk9mr360331pbc.115.1363658146673;
        Mon, 18 Mar 2013 18:55:46 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id dl1sm17880364pbc.17.2013.03.18.18.55.43
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Mar 2013 18:55:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v38vsma9o.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218470>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> Test nits:
>> ...
>> Hope that helps,
>>
>> Jonathan Nieder (3):
>>   push test: use test_config where appropriate
>>   push test: simplify check of push result
>>   push test: rely on &&-chaining instead of 'if bad; then echo Oops; fi'
>
> Are these supposed to be follow-up patches?  Preparatory steps that
> Rob can reroll on top?  Something else?

Preparatory steps.
