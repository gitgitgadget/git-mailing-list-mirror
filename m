From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: What's cooking in git.git (Jul 2009, #01; Mon, 06)
Date: Fri, 10 Jul 2009 07:05:16 +0200
Message-ID: <200907100705.16590.chriscool@tuxfamily.org>
References: <7vk52l4q7k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 10 07:05:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MP8IP-0000d0-58
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 07:05:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbZGJFE4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2009 01:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750996AbZGJFE4
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 01:04:56 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:44505 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750895AbZGJFEz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2009 01:04:55 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 6E2FD8180C5;
	Fri, 10 Jul 2009 07:04:45 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 4A1DB8180EA;
	Fri, 10 Jul 2009 07:04:43 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vk52l4q7k.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Monday 06 July 2009, Junio C Hamano wrote:
> For the following three series, I have not managed to convince myself if
> these changes have real-world needs.

[...]

> * cc/replace (Wed May 27 07:14:09 2009 +0200) 14 commits
>  - t6050: check pushing something based on a replaced commit
>  - Documentation: add documentation for "git replace"
>  - Add git-replace to .gitignore
>  - builtin-replace: use "usage_msg_opt" to give better error messages
>  - parse-options: add new function "usage_msg_opt"
>  - builtin-replace: teach "git replace" to actually replace
>  - Add new "git replace" command
>  - environment: add global variable to disable replacement
>  - mktag: call "check_sha1_signature" with the replacement sha1
>  - replace_object: add a test case
>  - object: call "check_sha1_signature" with the replacement sha1
>  - sha1_file: add a "read_sha1_file_repl" function
>  - replace_object: add mechanism to replace objects found in
>    "refs/replace/"
>  - refs: add a "for_each_replace_ref" function

Didn't you say before that it would be an improvement over grafts?

By the way, may be it would be an improvement to use one bit in "struct 
object" to mark replaced objects. It could make it easier to spot them 
where they could make the code behave strangely.

Anyway I will have a 2 week long vacation starting today, so I won't be able 
to do much soon.

Best regards,
Christian.
