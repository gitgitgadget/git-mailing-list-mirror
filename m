From: Andrew Keller <andrew@kellerfarm.com>
Subject: Re: Reduced privileges install
Date: Mon, 20 Sep 2010 10:06:33 -0400
Message-ID: <33FB1E5A-D469-4B00-B4EB-03572C7F934A@kellerfarm.com>
References: <325786BC-5F54-47B5-AEF5-7FDAD9BEA4BA@kellerfarm.com> <86k4mhfcj1.fsf@red.stonehenge.com> <6BE502C9-5507-452D-A5D5-D0C69C05F126@kellerfarm.com> <677DFF75-2DBB-4772-802B-4402E4024307@sb.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 20 16:06:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oxh0z-0003aN-23
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 16:06:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755825Ab0ITOGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 10:06:35 -0400
Received: from sanjose.tchmachines.com ([208.76.86.38]:51313 "EHLO
	leia.tchmachines.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753729Ab0ITOGe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Sep 2010 10:06:34 -0400
Received: from host-211-194.meilvil.clients.pavlovmedia.com ([96.63.211.194])
	by leia.tchmachines.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69)
	(envelope-from <andrew@kellerfarm.com>)
	id 1Oxh0m-0007vx-R3
	for git@vger.kernel.org; Mon, 20 Sep 2010 10:06:28 -0400
In-Reply-To: <677DFF75-2DBB-4772-802B-4402E4024307@sb.org>
X-Mailer: Apple Mail (2.1081)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - leia.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kellerfarm.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156625>

On Sep 20, 2010, at 2:51 AM, Kevin Ballard wrote:
> On Sep 19, 2010, at 6:31 PM, Andrew Keller wrote:
>> On Sep 19, 2010, at 9:07 PM, Randal L. Schwartz wrote:
>>> "Andrew" == Andrew Keller <andrew@kellerfarm.com> writes:
>>> 
>>>> Because I do not own the server and my account has restricted privileges, I attempted to augment my PATH to include a directory in my home folder, and then install git in there by specifying a prefix at the configure stage.  The configure and the make work, but the make install fails.  Here's the last section of the log:
>>> 
>>> What's your PREFIX set to?  If you set your prefix, the Perl modules are installed below the prefix, not in the system dirs.
>> 
>> Here's what I executed:
>> 
>> $ ./configure --prefix=/usr/users/students/ak4390/.local
>> $ make
>> $ make install
>> 
>> I also tried providing the --oldincludedir and --datadir parameters, but I got the same result.
> 
> I admit, I'm not well-versed on the build system, but my impression was that specifying --prefix in ./configure was indeed supposed to propagate to a subsequent make and make install. However, you may wish to attempt the following to be sure:
> 
> $ make PREFIX=/usr/users/students/ak4390/.local
> $ make install PREFIX=/usr/users/students/ak4390/.local

The same error occurs when providing the prefix to the build and install segments.

~ Andrew Keller
