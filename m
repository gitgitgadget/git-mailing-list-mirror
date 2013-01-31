From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/7] Undocument deprecated alias 'push.default=tracking'
Date: Thu, 31 Jan 2013 11:11:05 -0800
Message-ID: <20130131191105.GF27340@google.com>
References: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
 <1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
 <1335170284-30768-3-git-send-email-Matthieu.Moy@imag.fr>
 <CACBZZX552fnD+u9Zp-BhqDyYWN+OiyvCyub-xjMZ-_GXCG-vQA@mail.gmail.com>
 <7vvcadgss0.fsf@alter.siamese.dyndns.org>
 <20130131190747.GE27340@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 20:11:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0zXp-0004s7-GL
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 20:11:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754972Ab3AaTLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 14:11:12 -0500
Received: from mail-pb0-f47.google.com ([209.85.160.47]:34979 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945Ab3AaTLK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 14:11:10 -0500
Received: by mail-pb0-f47.google.com with SMTP id rp8so1752880pbb.34
        for <git@vger.kernel.org>; Thu, 31 Jan 2013 11:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=SGwBed3a6sHezbHy3hK4fFhWPmyz43694QHRQEhKHoY=;
        b=nw+wb+HGpqcMyP2Y8ZnkVaWWQkQInxwRD6WhkWFgXvHyrtxtc2k0qvIZv5deWqkaVc
         opEw3olpB5umv9Vrs+WysoqVJHvg1fq45ovRNPO6Q2+XrNNgw6p5ElL57afr1bo4i1oR
         kFESibjm5lmRk21CbJ+aZJ652f0PU3A13qrtJiUZPW2rHAfx4d9rDJyGfmvvYZq+Keck
         SmNjOISq9/BGhmAsuD/K84N0EBGpb+NgsDibRbx1J7R6u2kTN5I0ssTwXLUErewQppeu
         EdQt5X9PAe6zGZSEdHzWqljPF5g2eCjofDjXdkNkLcXFG5SkhgHcvLNKAe2qKeKs0jJX
         0QNQ==
X-Received: by 10.68.235.200 with SMTP id uo8mr25105567pbc.29.1359659470293;
        Thu, 31 Jan 2013 11:11:10 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id vk5sm5778454pbc.34.2013.01.31.11.11.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 31 Jan 2013 11:11:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130131190747.GE27340@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215152>

Jonathan Nieder wrote:

> Is the problem that "deprecated" is not precise enough?  For example,
> would it make sense to say "deprecated synonym for `upstream`.  Will
> be dropped in git 2.1" or something like that?

Also, if we plan to remove support soon, we should start warning when
this setting is encountered so people know to update their
configuration.

Jonathan
