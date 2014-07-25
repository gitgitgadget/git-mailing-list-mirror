From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Amending merge commits?
Date: Fri, 25 Jul 2014 15:31:46 -0700
Message-ID: <20140725223146.GM12427@google.com>
References: <22F01493C523F940B4B5E53BB6D0F5352275F207@G5W2738.americas.hpqcorp.net>
 <20140725221911.GL12427@google.com>
 <22F01493C523F940B4B5E53BB6D0F5352275F25B@G5W2738.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Besen, David" <david.besen@hp.com>
X-From: git-owner@vger.kernel.org Sat Jul 26 00:32:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAo27-0007gf-Cf
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jul 2014 00:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933208AbaGYWbz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 18:31:55 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:61260 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761072AbaGYWbt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 18:31:49 -0400
Received: by mail-pa0-f52.google.com with SMTP id bj1so6839783pad.11
        for <git@vger.kernel.org>; Fri, 25 Jul 2014 15:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=nPHD5FjVbPc964v+SHUl58rMVEW6ql8wZQ7POcCRBvA=;
        b=sLSd31c2zJ/C9cjuACxj7nt3A/9j/V388Q9DAy6vd40ER0xXv7uDz7j9RqCN9xZQiq
         x1xGfQWhj/qa3i6TuHTwhFrGgDwRFTSBqhmpxrq/Sm0jUWcBJ/fg7woHBqwFJwYjR/RS
         A/XbXODPn4Cdq6wg/YYyo0KxxW+jgadErl/wPoA7PvfG4e4iEYuU2McfwPEue7pZWNaX
         Ep2Woeu/nANwP3O7VBkczOPf6N+pv8V4BkiznpKYjbgW9Fkg4eQGT8TbN/C96FX6jGLb
         qGeLjagGQvS1ewYYg0xujWx5laAOLShUDqTQhp9nPA3uAJExV/ZHFMCZDQTPFwr/gTNF
         nhmg==
X-Received: by 10.68.204.134 with SMTP id ky6mr14622708pbc.61.1406327509535;
        Fri, 25 Jul 2014 15:31:49 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:11c3:a287:a529:3c10])
        by mx.google.com with ESMTPSA id oo3sm13175675pdb.19.2014.07.25.15.31.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 25 Jul 2014 15:31:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <22F01493C523F940B4B5E53BB6D0F5352275F25B@G5W2738.americas.hpqcorp.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254273>

David Besen wrote:
> Jonathan Nieder wrote:

>> This is how pull --rebase works.  It turns your single-parent commits
>> into a sequence of patches on top of upstream and completely ignores
>> your merge commits.
>>
>> There is a --rebase=preserve option that makes a halfhearted attempt
>> to preserve your merges --- perhaps that would help?  The
>> git-rebase(1) documentation has more details.
>
> Ah thanks, I'll RTFM better in the future.

No, not a problem.  It's very useful to see examples of where git's
behavior was counterintuitive and the documentation was more obscure
than it could have been.

I should also emphasize the "halfhearted" above.  There's a lot of
room for improvement in rebase --preserve-merges's handling of "evil"
and otherwise amended merges.

Thanks again,
Jonathan
