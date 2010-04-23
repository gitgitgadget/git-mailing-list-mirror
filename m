From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Problems with file name case on Windows.
Date: Fri, 23 Apr 2010 08:38:30 +0200
Message-ID: <4BD14066.3040307@kdbg.org>
References: <1271969657620-4947131.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: martinvz <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 23 08:38:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5CXO-0004JJ-99
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 08:38:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755985Ab0DWGis (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 02:38:48 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:14553 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755673Ab0DWGir (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 02:38:47 -0400
Received: from [192.168.0.200] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id E9296CDFC4;
	Fri, 23 Apr 2010 08:38:37 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <1271969657620-4947131.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145590>

Am 22.04.2010 22:54, schrieb martinvz:
>
> Under Cygwin, if you add a file "a" in one commit, then rename the file to
> "A" and commit again, both files will be in the new commit. Running the
> following line under Cygwin produces a commit with both files ("a" and "A").
> Running it on Linux produces a commit with one file ("A"), as expected.

The safe way to achieve your goal is:

   git mv a b
   git mv b A
   git commit

-- Hannes
