From: Alexander Pepper <pepper@inf.fu-berlin.de>
Subject: Re: Bug: git log --numstat counts wrong
Date: Wed, 21 Sep 2011 15:40:41 +0200
Message-ID: <C03FC526-B7D0-4EFA-9E35-68F28D950C4B@inf.fu-berlin.de>
References: <D3CF0A47-64DA-4EBB-9DCD-D2D714596C50@inf.fu-berlin.de> <7vr53a2icn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 21 15:40:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6N2g-00054y-J5
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 15:40:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754052Ab1IUNkp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 09:40:45 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:51714 "EHLO
	outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753741Ab1IUNkp convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2011 09:40:45 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost1.zedat.fu-berlin.de (Exim 4.69)
          with esmtp
          (envelope-from <pepper@inf.fu-berlin.de>)
          id <1R6N2X-0002sZ-J2>; Wed, 21 Sep 2011 15:40:41 +0200
Received: from 91-66-162-110-dynip.superkabel.de ([91.66.162.110] helo=[10.1.17.174])
          by inpost2.zedat.fu-berlin.de (Exim 4.69)
          with esmtpsa
          (envelope-from <pepper@inf.fu-berlin.de>)
          id <1R6N2X-0005jY-Gc>; Wed, 21 Sep 2011 15:40:41 +0200
In-Reply-To: <7vr53a2icn.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1084)
X-Originating-IP: 91.66.162.110
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181845>

Am 21.09.2011 um 14:24 schrieb Junio C Hamano:
>> $ git log --numstat 48a07e7e533f507228e8d1c99d4d48e175e14260
>> [...]
>> 11      10      src/java/voldemort/server/storage/StorageService.java
> 
> Didn't we update it this already? I seem to get 10/9 here not 11/10.

I just compiled git fresh from the master (4b5eac7f) and the issue is still active there:

$ ../git/git --version
git version 1.7.7.rc0.72.g4b5ea
$ ../git/git log --numstat 48a07e7e533f507228e8d1c99d4d48e175e14260
[...]
11      10      src/java/voldemort/server/storage/StorageService.java

Should I check another branch?