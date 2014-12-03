From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: FW: [cygwin] Cygwin's git says "error: failed to read delta-pack base object"
Date: Wed, 3 Dec 2014 18:31:18 -0500
Organization: PD Inc
Message-ID: <64C98FC352BD45EC9632202946A081E1@black>
Reply-To: <git@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 04 00:31:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwJOF-0003qb-QB
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 00:31:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbaLCXbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 18:31:20 -0500
Received: from mail.pdinc.us ([67.90.184.27]:60357 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751124AbaLCXbT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Dec 2014 18:31:19 -0500
Received: from black (five-58.pdinc.us [192.168.5.58])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id sB3NVI5i026624
	for <git@vger.kernel.org>; Wed, 3 Dec 2014 18:31:18 -0500
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AdAPTnipQMftO49bTwmCLkDwG7UbFAAAn1Pg
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260711>

I remember hitting this a while ago, but just gave up.

It seems to be a problem for others too.

Any ideas on how to debug this so it can be patched?

-----Original Message-----
From: Dave Lindbergh
Sent: Wednesday, December 03, 2014 18:07
To: cygwin
Subject: Re: [cygwin] Cygwin's git says "error: failed to read delta-pack base object"

On Wed, Dec 3, 2014 at 3:42 PM, Jason Pyeron <jpyeron@pdinc.us> wrote:
> [copy off list, because the sourceware system admins throws temper tantrums]
>> -----Original Message-----
>> From: Dave L
>> Sent: Wednesday, December 03, 2014 15:30
>>
>> ...but the git from github.com works fine.
>>
>> I installed Cygwin's version of git, and get this:
>>
>>     $ git clone https://github.com/nerdfever/pic32mx-bmf
>>     Cloning into 'pic32mx-bmf'...
>>     remote: Counting objects: 12, done.
>>     remote: Total 12 (delta 0), reused 0 (delta 0)
>>     error: failed to read delta-pack base object
>>     300bdeb2fd209d24afb865584da10b78aa8fefc4
>>     fatal: unpack-objects failed
>
> What file system are you on? Local NTFS or remote?

Aha - you're right.

It works fine on a local NTFS volume.

I get the error when I do it on Z:, which is mapped to a network drive
(on another Windows box).

Is there a workaround? Why does this happen?

--Dave

--
Problem reports:       http://cygwin.com/problems.html
FAQ:                   http://cygwin.com/faq/
Documentation:         http://cygwin.com/docs.html
Unsubscribe info:      http://cygwin.com/ml/#unsubscribe-simple
