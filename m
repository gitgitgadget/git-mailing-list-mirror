From: Liu Yubao <yubao.liu@gmail.com>
Subject: dirty code to get an outline of commit history with gitk [Was: how
 to make gitk to use specified history information]
Date: Mon, 16 Nov 2009 18:58:58 +0800
Message-ID: <4B013072.5030208@gmail.com>
References: <4B01049A.5090402@gmail.com> <loom.20091116T090441-576@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 16 11:57:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9zHP-0004rp-5g
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 11:57:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752358AbZKPK50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 05:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752454AbZKPK50
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 05:57:26 -0500
Received: from mail-yw0-f202.google.com ([209.85.211.202]:51503 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752358AbZKPK5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 05:57:25 -0500
Received: by ywh40 with SMTP id 40so2946808ywh.33
        for <git@vger.kernel.org>; Mon, 16 Nov 2009 02:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=ikNGejk0jdTNkcLq9G+tTw1sNE8/cxyeuW6KA9SJmIc=;
        b=ivpEG+wm3pbCApZKg3YiMUmWP8f0tIfInt28YZRbsxviKxKIyCzpX9hkC7XyMHYQXW
         1cfWHox6mOwH+LRoc6WZUsJEN16DdNEzJj5WfCBLQ0OHZwL6RY0DlGxelOMl/YaYp5F3
         Om7pG9jeEjMyEqzQFJymj+/Oq+ve2XLfCOYdc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=cH+meDIsZh+crFJvUJ/G2WQlx2sf0wveOrdqCqRwWuCJynWkdB+zhKnJqb8ceugJC5
         TshQMA5T1l9fCS+1lyvxHzbtbZTLzaDGlA6fswC73W0D1R6GNmR/HFcFhGLy4/zOz8fT
         QkGapgnUeIJSainTd9t+KNtQVoozCwIUhGJFQ=
Received: by 10.150.45.40 with SMTP id s40mr13240926ybs.260.1258369049187;
        Mon, 16 Nov 2009 02:57:29 -0800 (PST)
Received: from ?10.64.1.88? ([211.157.41.194])
        by mx.google.com with ESMTPS id 6sm81778ywd.7.2009.11.16.02.57.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Nov 2009 02:57:28 -0800 (PST)
User-Agent: Mozilla-Thunderbird 2.0.0.22 (X11/20091109)
In-Reply-To: <loom.20091116T090441-576@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132999>

Eric Raible wrote:
> Liu Yubao <yubao.liu <at> gmail.com> writes:
> 
>> I want to obtain an outline of history information, for example:
>>
>>   a - b - c - d - h -i -j
>>    \         /
>>     e- f - g
>>
>> I simplify the graph like this:
>>
>>   a - c - d - j
>>     \    /
>>       g
> 
> "gitk --simplify-by-decoration"?
> 
> - Eric
> 
Hi, I get a very dirty implementation, see

http://jff.googlecode.com/svn/trunk/utils/git-branch-graph/

http://jff.googlecode.com/files/gitk-branch-graph--all.png
http://jff.googlecode.com/files/gitk--all.png

These are just to show my expectation, the code is very very very dirty,
I hope git and gitk will add this feature in an elegant and efficent way.
