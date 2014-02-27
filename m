From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: How to mark a complete sub-directory assume-unchanged/skip-worktree?
Date: Thu, 27 Feb 2014 23:46:55 -0000
Organization: OPDS
Message-ID: <DAC4EA00279649D6B3F4DB1B3D662BA6@PhilipOakley>
References: <3A9AA61FDE124808AA25DE3511CF99F1@PhilipOakley> <CACsJy8DV2uCQbfCP=Mf2qajVAtpTZvKKeCS2H4_o6LA3B96QAA@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>
To: "Duy Nguyen" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 00:47:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJAfe-0005EV-KG
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 00:47:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbaB0XrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 18:47:14 -0500
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:28204 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751213AbaB0XrN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Feb 2014 18:47:13 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AlsXAN68D1NZ8YVX/2dsb2JhbABagwaEFYU+uEUFAQIBAYEcF3RpAQGBHwEBFAEEAQEFCAEBGRUeAQEhCwIDBQIBAw4HAwICBSECAhQBBAgSBgcXBhMIAgECAwGFOAcBggcNAxWqU5lbDYcKF4EpixaCFoJ1NYEUBI8vhxyOUIVHgy08
X-IPAS-Result: AlsXAN68D1NZ8YVX/2dsb2JhbABagwaEFYU+uEUFAQIBAYEcF3RpAQGBHwEBFAEEAQEFCAEBGRUeAQEhCwIDBQIBAw4HAwICBSECAhQBBAgSBgcXBhMIAgECAwGFOAcBggcNAxWqU5lbDYcKF4EpixaCFoJ1NYEUBI8vhxyOUIVHgy08
X-IronPort-AV: E=Sophos;i="4.97,558,1389744000"; 
   d="scan'208";a="602598438"
Received: from host-89-241-133-87.as13285.net (HELO PhilipOakley) ([89.241.133.87])
  by out1.ip06ir2.opaltelecom.net with SMTP; 27 Feb 2014 23:47:11 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242876>

From: "Duy Nguyen" <pclouds@gmail.com>
> On Fri, Feb 28, 2014 at 12:25 AM, Philip Oakley <philipoakley@iee.org> 
> wrote:
>> Have there been previous attempts to look at marking sub-dirs as
>> --skip-worktree, or some other sentinel value for the missing tree?
>
> I dealt with this by creating partial index, that only contains
> entries for interested subtrees. The index also stores the base tree
> SHA-1, so write-tree can still create (full) new trees correctly from
> partial index.
> -- 
> Duy

Is there a particular bit of code I'd be worth studying for the partial 
index example to see how well it might fit my ideas?

--
Philip 
