From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v4 3/4] setup: Add 'abspath_part_inside_repo' function
Date: Sun, 02 Feb 2014 13:27:25 +0100
Message-ID: <52EE39AD.80801@web.de>
References: <20140131202142.GA9731@mule> <1391306351-13237-1-git-send-email-martinerikwerner@gmail.com> <1391306351-13237-4-git-send-email-martinerikwerner@gmail.com> <CACsJy8A8hardH7EaopY2Xu5Ob50mew3pJdqAr6fJsqyyhLQYMg@mail.gmail.com> <20140202111330.GB14729@mule> <871tzl2209.fsf@fencepost.gnu.org> <52EE2DEC.4030400@web.de> <20140202120943.GA27787@mule>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org,
	gitster@pobox.com, richih@debian.org
To: Martin Erik Werner <martinerikwerner@gmail.com>,
	=?ISO-8859-1?Q?Torst?= =?ISO-8859-1?Q?en_B=F6gershausen?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Feb 02 13:27:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9w97-0000n5-7M
	for gcvg-git-2@plane.gmane.org; Sun, 02 Feb 2014 13:27:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbaBBM12 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Feb 2014 07:27:28 -0500
Received: from mout.web.de ([212.227.17.11]:55372 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751195AbaBBM12 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 07:27:28 -0500
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MXpdL-1VmaOf1bvT-00Wjrh for <git@vger.kernel.org>;
 Sun, 02 Feb 2014 13:27:26 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20140202120943.GA27787@mule>
X-Provags-ID: V03:K0:BcgiQRpPSKvAD/AuZG14O7C/vkvgV3mcKQDL2fkO3W8JyffalyU
 rCEa/YMH4+2kogb5W/oDjEc/dbrWHHyPQvXSWoEHrk8EwfFZdvDw8YAaLzr0wksc0h1OU2s
 dqGDABDMSykDp7KQQYMDP4Chv4MU2vErTorhHzafNFMbrsN9o5u/hcj+I2izIviTAIHIZ8q
 XaNMapF/QYGkIQXMSbX/g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241371>

> 
>> Another comment:
>> The "raw" comparison with '/' is probably working well on all
>> POSIX/Linux/Unix systems.
>>
>> To be more portable, the macro
>> is_dir_sep()
>> can be used:
>>
>> if (is_dir_sep(path[wtlen]))
> 
> Since the path is already normalized by 'normalize_path_copy_len' which
> seems to guarantee '/'-separation, I have assumed that this was
> unnecessary?

So true, sorry for the noise.
