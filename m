From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2008, #05; Sat, 15)
Date: Sun, 16 Nov 2008 16:20:29 +0700
Message-ID: <fcaeb9bf0811160120v4954939x244165d6f6b5055e@mail.gmail.com>
References: <7vzlk04hkk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 16 10:22:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1dqC-0003pc-Q2
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 10:22:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618AbYKPJUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 04:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751588AbYKPJUe
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 04:20:34 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:50373 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366AbYKPJUc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 04:20:32 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1699015fgg.17
        for <git@vger.kernel.org>; Sun, 16 Nov 2008 01:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=P2e4OBXe5bvtWvdhiJ3svhbyTUSFhpVvHy4GWsardiU=;
        b=vuLdUOzUsRAYPG6bHU8YuzwDBCy0FOtSSmC5AsoFUQidk+niLT5FIKdVzbNPvUcGcL
         gL0uPmtjtHkJsBu+qOqBlcoKzz1kB2crk+xkY8xl4jzqgsemysLerkPQ13xzl5mqrbpA
         wQd5d4hyCYiRoEdWIUF3ZQNx48H3goKuJRveI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=rn2MvH78uP1AKKjxaxxsp54v6hzA8ue7XsNJHnfHQZZajDR0okGJlLZ6Q/e780u0Vk
         JDux9hV0e0B8NQPwFGcTlpKHQTFbfUYsN91XrK+FCy0S9AojoNjCTBiuBIkhLxRRkXWK
         Shf9jSbl5s7/DBhrKzm4rWDEbE+lc4vFgJ0tI=
Received: by 10.86.59.18 with SMTP id h18mr1634216fga.35.1226827229796;
        Sun, 16 Nov 2008 01:20:29 -0800 (PST)
Received: by 10.86.96.1 with HTTP; Sun, 16 Nov 2008 01:20:29 -0800 (PST)
In-Reply-To: <7vzlk04hkk.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101121>

On 11/16/08, Junio C Hamano <gitster@pobox.com> wrote:
>  * nd/rename-cache (Sat Nov 8 18:27:33 2008 +0700) 2 commits
>   - diffcore-rename: add config option to allow to cache renames
>   - diffcore-rename: support rename cache
>
>  I am moderately negative on this one in its current shape.  We shouldn't
>  have to be storing what can be recomputed (and recomputed differently in
>  later software), and we shouldn't be keeping such cached result
>  indefinitely.

Yeah.. having some way to deprecate the cache if you use a newer
version was something I thought about but haven't done. Anyway for all
the purposes I want it to do, injecting explicit renames may not work
if --find-copies-harder is not given. I think you should drop it.
-- 
Duy
