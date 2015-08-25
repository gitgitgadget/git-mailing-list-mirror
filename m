From: "Graeme Geldenhuys" <graemeg@gmail.com>
Subject: Git's inconsistent command line options
Date: Tue, 25 Aug 2015 08:01:24 +0000 (UTC)
Message-ID: <mrh7ck$r0g$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 25 10:05:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZU9Ex-0008PH-69
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 10:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbbHYIBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2015 04:01:42 -0400
Received: from plane.gmane.org ([80.91.229.3]:47748 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932315AbbHYIBl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 04:01:41 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ZU9Ao-000641-34
	for git@vger.kernel.org; Tue, 25 Aug 2015 10:01:38 +0200
Received: from 97e0dc41.skybroadband.com ([151.224.220.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 10:01:38 +0200
Received: from graemeg by 97e0dc41.skybroadband.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 10:01:38 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 97e0dc41.skybroadband.com
User-Agent: XanaNews/1.20-0cfde51 (x86; Portable ISpell)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276509>

Hi,

I've used Git for years and this has always bothered me. Has anybody
else noticed the inconsistent command line parameteres for seemingly
similar tasks. There are many examples, but I'll list only two (I can
supply a more extensive list if needed).

eg: Renaming things.

 * When working with branches it uses "-m" or "-M" to rename a branch.

 * When working with remote repos it use "rename"  (not even the more
common -- prefix either).

eg: Deleting things

  * When working with branches it uses "-d" or "-D" to delete a branch

  * When working with remote branch it uses only a push command.

  * When deleting a remote repo it uses "remove" (again not even with
the commonly used -- prefix)


Even though I have worked with Git since 2009, I still have to
reference the help to remind me of what parameter to use in certain
situation simply because similar tasks differ so much.

Maybe we could address this in the next major version of Git? Has
anybody else thought about this or started work on this? Or was this
discussed before and declined (link?).

Regards,
  Graeme
