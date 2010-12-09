From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH 0/2] [RFD] Using gitrevisions :/search style with other operators
Date: Wed, 8 Dec 2010 17:46:16 -0800
Message-ID: <C1C51028-60B5-46EE-B172-1A9330FBBB8A@sb.org>
References: <1291820319-12455-1-git-send-email-pclouds@gmail.com> <201012082047.44022.jnareb@gmail.com> <AANLkTi=AyCxn=dcKQQmT0_6Oc36AX6XDA4Dhhk7WLSN0@mail.gmail.com> <201012090144.19858.jnareb@gmail.com> <AANLkTin1SjEzBnLd-HK9fANShLezAKHAOai9MyF-cuoT@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Yann Dirson <dirson@bertin.fr>, Jeff King <peff@peff.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 09 02:46:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQVaT-0002uH-PT
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 02:46:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112Ab0LIBqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 20:46:20 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:41555 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932093Ab0LIBqT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 20:46:19 -0500
Received: by pva4 with SMTP id 4so398790pva.19
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 17:46:19 -0800 (PST)
Received: by 10.142.125.4 with SMTP id x4mr3387948wfc.234.1291859179300;
        Wed, 08 Dec 2010 17:46:19 -0800 (PST)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id p8sm1662059wff.16.2010.12.08.17.46.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Dec 2010 17:46:18 -0800 (PST)
In-Reply-To: <AANLkTin1SjEzBnLd-HK9fANShLezAKHAOai9MyF-cuoT@mail.gmail.com>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163254>

On Dec 8, 2010, at 5:42 PM, Nguyen Thai Ngoc Duy wrote:

> On Thu, Dec 9, 2010 at 7:44 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>> On Thu, 9 Dec 2010, Nguyen Thai Ngoc Duy wrote:
>>> 2010/12/9 Jakub Narebski <jnareb@gmail.com>:
>> 
>>>> I wonder if it would be possible to make :/<regex> (which looks a bit
>>>> like searching the index) to be an alias to --all^{/<regex>}...
>>> 
>>> It looks a bit strange to my eyes to merge normal option name with
>>> revision syntax. But I think it's possible. Do we allow branch/tag
>>> name with leading '-'?
>> 
>> Well, with below proposal it would simply be
>> 
>>  --all ^{/<regexp>}
> 
> This hardly works with range and may conflict with "--all" being
> already used by some commands.
> 
> I think we can move '/' out of {}, the space between '/' and '{' can
> be used for optional parameters: ^/{foo}

I thought ^{} was going to be an arbitrary grouping operator, capable of
embedding any other modifier, but primarily only useful for regex. This
change explicitly makes it an alternative regex syntax.

-Kevin Ballard
