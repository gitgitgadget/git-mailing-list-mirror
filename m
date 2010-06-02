From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 1/5] t/t5800: skip if python version is older than 2.5
Date: Wed, 02 Jun 2010 09:44:26 -0500
Message-ID: <meC0HM60UnAajjHuTX-y8qZO2Unmc9VZYk1ZAHZ86LlKSy4E9Rfc_w@cipher.nrlssc.navy.mil>
References: <Wt_M4qptcPdpY0Q3jqUbfIk6yMCN9Ja5RCtRUsADK5OJGrz7R_Cq1oGpeQoN7A9uCvw38jm63Jo@cipher.nrlssc.navy.mil> <Wt_M4qptcPdpY0Q3jqUbfCU_HpY9NEjqs9eujZFD2rsUj5HRo__oQm7EUCxzXu38mC0y-ilUA14@cipher.nrlssc.navy.mil> <AANLkTinQrdJeTxoZ207kvv5R_3qUj5ocGgAlC22SQyOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 02 16:49:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJpGW-0007HD-FY
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 16:49:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757975Ab0FBOtv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 10:49:51 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50572 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755530Ab0FBOtu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 10:49:50 -0400
Received: by mail.nrlssc.navy.mil id o52EiQWv018005; Wed, 2 Jun 2010 09:44:26 -0500
In-Reply-To: <AANLkTinQrdJeTxoZ207kvv5R_3qUj5ocGgAlC22SQyOg@mail.gmail.com>
X-OriginalArrivalTime: 02 Jun 2010 14:44:26.0868 (UTC) FILETIME=[19897340:01CB0262]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148257>

On 06/02/2010 01:21 AM, Sverre Rabbelier wrote:
> Heya,
> 
> On Wed, Jun 2, 2010 at 02:13, Brandon Casey <casey@nrlssc.navy.mil> wrote:
>> This test script depends on the git-remote-testgit python script.  This
>> python script makes use of the hashlib module which was released in python
>> version 2.5.  So, add a new pre-requisite named PYTHON_2_5_OR_NEWER to
>> test-lib.sh and check for it in t5800.
> 
> Perhaps instead we can change git-remote-testgit to do:
> 
> "try:
> import hashlib
> except ImportError:
> import ?? as hashlib
> "

I can only guess at what that does. :)

> Otoh, python 2.5 has been out for a while (and is in fact only
> downloadable as a source-only release these days). To be exact, it was
> released on September 19, 2006.

That's only long in python years. :)

RedHat's latest operating system still has version 2.4.3.

-brandon
