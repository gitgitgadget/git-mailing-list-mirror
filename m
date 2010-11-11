From: Kevin Ballard <kevin@sb.org>
Subject: Re: is it kosher for pre-commit to change what's staged?
Date: Thu, 11 Nov 2010 14:06:53 -0800
Message-ID: <F0C8038B-0D8C-4A50-9934-9D9CF26FF9F9@sb.org>
References: <20101110170819.GA3031@gnu.kitenet.net> <7v1v6thrzc.fsf@alter.siamese.dyndns.org> <20101110200650.GA13439@burratino> <20101110204542.GA11201@gnu.kitenet.net> <AANLkTi=W_hwU=3PTTqE4R8Cg5T=GMdMfBsKQ1YE0HWRe@mail.gmail.com> <20101111192648.GE30870@efreet.light.src> <20101111204626.GA13937@gnu.kitenet.net> <7vlj4zfrgt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Joey Hess <joey@kitenet.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 23:07:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGfIQ-0005Ej-Ss
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 23:07:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757068Ab0KKWHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 17:07:00 -0500
Received: from mail-px0-f174.google.com ([209.85.212.174]:37227 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756548Ab0KKWG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 17:06:59 -0500
Received: by pxi15 with SMTP id 15so501600pxi.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 14:06:58 -0800 (PST)
Received: by 10.142.72.12 with SMTP id u12mr1122886wfa.159.1289513218773;
        Thu, 11 Nov 2010 14:06:58 -0800 (PST)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id x35sm2906257wfd.13.2010.11.11.14.06.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 14:06:57 -0800 (PST)
In-Reply-To: <7vlj4zfrgt.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161305>

On Nov 11, 2010, at 2:03 PM, Junio C Hamano wrote:

> Joey Hess <joey@kitenet.net> writes:
> 
>> ... The
>> pre-commit script there stores some metadata about files that git
>> usually doesn't track, by putting it in a dotfile, and stages that
>> dotfile for commit. Which currently works fine, except for the minor
>> problem that the user doesn't see the dotfile listed in the commit
>> message.
> 
> I am hearing "list of files in the commit message", and am getting
> confused.  As far as I know we don't store such a list in the commit
> message.
> 
> Puzzled.

I believe he means in the # comments at the bottom of the editor. They
contain the output of `git status` as a reminder of what you're
committing.

-Kevin Ballard
