From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [1.8.0] Remove deprecated commands
Date: Tue, 01 Feb 2011 19:37:34 +0100
Message-ID: <4D4852EE.6080605@lsrfire.ath.cx>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <7vwrll57ha.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 19:37:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkL6t-0001SG-5K
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 19:37:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756104Ab1BASho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 13:37:44 -0500
Received: from india601.server4you.de ([85.25.151.105]:45621 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755629Ab1BAShn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 13:37:43 -0500
Received: from [192.168.2.104] (p4FFDBAE4.dip.t-dialin.net [79.253.186.228])
	by india601.server4you.de (Postfix) with ESMTPSA id 4382C2F8072;
	Tue,  1 Feb 2011 19:37:41 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <7vwrll57ha.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165843>

The following four commands have been marked as deprecated in
command-list.txt for quite some time[*]:

   command          deprecated since replaced by
   ---------------- ---------------- ---------------------
   git-lost-found   2007-11-08       git fsck --lost-found
   git-peek-remote  2007-11-24       git ls-remote
   git-repo-config  2008-01-17       git config
   git-tar-tree     2007-11-08       git archive

Let's just remove them.  There's a risk that someone is still using the
old commands, of course, but they have been deprecated long enough now.


[*] data source:
    git blame -C command-list.txt |
    sed -n 's/.*\(....-..-..\).*\(git-[^ ]*\).*deprecated.*/\2\t\1/p'
