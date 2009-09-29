From: Marius Storm-Olsen <marius@storm-olsen.com>
Subject: Re: git-diff/git-diff-files: Turn off copy-detection?
Date: Tue, 29 Sep 2009 16:24:59 +0200
Message-ID: <4AC218BB.4080807@gmail.com>
References: <4AC20286.6020108@gmail.com> <4AC20E37.3090204@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Sep 29 16:24:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsddM-0000XI-1f
	for gcvg-git-2@lo.gmane.org; Tue, 29 Sep 2009 16:24:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752740AbZI2OYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2009 10:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752656AbZI2OYm
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Sep 2009 10:24:42 -0400
Received: from mail-ew0-f211.google.com ([209.85.219.211]:58619 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664AbZI2OYm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2009 10:24:42 -0400
Received: by ewy7 with SMTP id 7so5459164ewy.17
        for <git@vger.kernel.org>; Tue, 29 Sep 2009 07:24:45 -0700 (PDT)
Received: by 10.211.128.17 with SMTP id f17mr5253797ebn.69.1254234284746;
        Tue, 29 Sep 2009 07:24:44 -0700 (PDT)
Received: from ?192.168.0.198? (cm-84.215.55.206.getinternet.no [84.215.55.206])
        by mx.google.com with ESMTPS id 10sm937538eyd.8.2009.09.29.07.24.43
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 29 Sep 2009 07:24:44 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <4AC20E37.3090204@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129304>

Johannes Sixt said the following on 29.09.2009 15:40:
> Marius Storm-Olsen schrieb:
>> Doing a 'git diff origin/4.5..origin/4.6 -- src/corelib' gives me this
>> excerpt:
>>
>> diff --git origin/4.5/src/corelib/tools/qtimeline.h
>> origin/4.6/src/corelib/animation/qabstractanimation.h
>> similarity index 58%
>> ...
> 
> You must have the config variable diff.renames set. But I would not expect
> that this setting applies to 'git diff-files', only to 'git diff'.

$ git config diff.renames
copies

That's it, thanks! Strange that nothing in the git-diff documentation 
pointed me in this direction? Obviously I didn't connect the dots 
between 'copy' and 'renames' either..


> You can also try 'git diff -C99 -M99' if you don't want to unset the
> config variable.

Thanks, I'll add that to my review script. Much appreciated!

--
.marius
