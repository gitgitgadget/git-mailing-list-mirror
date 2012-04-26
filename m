From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: What's cooking in git.git (Apr 2012, #08; Fri, 20)
Date: Thu, 26 Apr 2012 08:31:33 +0200
Message-ID: <4F98EBC5.9020008@kdbg.org>
References: <xmqqobqmkkxv.fsf@junio.mtv.corp.google.com> <4F941EA3.7080200@kdbg.org> <CAFouetg1L3qsUQfNNnNKE43AkKGBQcypTw=w8dZKRJBM7LkQoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 08:31:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNIEv-000208-Lk
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 08:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753952Ab2DZGbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 02:31:35 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:54778 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753880Ab2DZGbe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 02:31:34 -0400
Received: from [192.168.1.98] (cpe228-254-static.liwest.at [81.10.228.254])
	by bsmtp.bon.at (Postfix) with ESMTP id BC7AC13005C;
	Thu, 26 Apr 2012 08:27:48 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <CAFouetg1L3qsUQfNNnNKE43AkKGBQcypTw=w8dZKRJBM7LkQoA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196356>

Am 25.04.2012 20:14, schrieb Tim Henigan:
> I now have a working test environment using msysgit on Windows 7
> 32-bit.  I updated to the tip of 'pu' (on my clone this is commit
> 5224ba8) and was able to run all 33 tests in t7800 without error.

pu passes for me as well, but I'm carrying around this change

-                       $opts{Repository} = abs_path($dir);
+                       $opts{Repository} = $dir;

in my local git repository. No surprise that "difftool --dir-diff from 
subdirectory" fails with this patch.

So, all is well, and sorry for the noise and confusion.

-- Hannes
