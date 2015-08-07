From: Jarkko Hietaniemi <jhi@iki.fi>
Subject: Re: wishlist: make it possible to amend commit messages after push
 to remote
Date: Fri, 07 Aug 2015 18:50:52 -0400
Message-ID: <55C5364C.6040904@iki.fi>
References: <55C3FA66.90805@iki.fi> <xmqqd1yzyqzq.fsf@gitster.dls.corp.google.com> <55C4E67F.7050109@iki.fi> <a0b9f82a46f2887d3ff3fb392e2e4c2c@www.dscho.org>
Reply-To: jhi@iki.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Aug 08 00:51:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNqU8-0004ZO-Oj
	for gcvg-git-2@plane.gmane.org; Sat, 08 Aug 2015 00:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946350AbbHGWvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2015 18:51:00 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:33612 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946306AbbHGWu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2015 18:50:59 -0400
Received: by qged69 with SMTP id d69so84809303qge.0
        for <git@vger.kernel.org>; Fri, 07 Aug 2015 15:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:reply-to:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=UR4oeTvcLHbtjsiODrQCrHxYXtbh/fg7gEvmW3Yhrwk=;
        b=pJAAMlFep481ogV+B1J6PDJYMQ1JIjhZzImc9eMI9Mb0kAh71YkaUK314r0xjSNdBs
         2O2d3Wr2GF6VXU9HXBXNdZLn5r7K+sN1xyPeVosi7HvUugpH2EmVs0ExVhMX+hazrGYs
         S3hFQE08jNNkLlySvNFUsYuhcpQi7jJAuus9dg7nXXtzcKqlzMsWJAB1KyBRkEwDcuNO
         gHaIU1Ry3N5CSM2wipaNMBxZt7Xisg/kmrIY3cV7t6LItOyC9x6AWwmHgL4o+5XO7Pac
         auD24BbHYrhs49jHlbCOqqfXy2PCcYcnX/rDYmKipc+TnOuP0Fh0lyylR1o6SEh4C164
         OFFA==
X-Received: by 10.141.28.6 with SMTP id f6mr18644968qhe.64.1438987859163;
        Fri, 07 Aug 2015 15:50:59 -0700 (PDT)
Received: from Vredefort.local ([2601:18f:200:9bed:b15b:43c2:73b3:7915])
        by smtp.gmail.com with ESMTPSA id f82sm5735838qkf.7.2015.08.07.15.50.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Aug 2015 15:50:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <a0b9f82a46f2887d3ff3fb392e2e4c2c@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275498>

On Friday-201508-07 15:38, Johannes Schindelin wrote:
> Speaking for myself, I actually like it that the entire metadata is part of the commit object, even the commit message. It makes the whole thing more reliable: one cannot claim that the commit does one thing on one day, and the next day all of a sudden claim that the commit does something completely different. Git's just really consistent the way it is.

Not that I expect anything to change.. but I'd like to point out again 
that I wasn't wishlisting "overwrite/replace/demolish the old commit
message".  More like a chain (hopefully of length one, but I canot
spll wuth a dam) of the messages, git log then showing the latest of 
them, but allowing accessing earlier ones.

Or another way to illustrate my idea: assume a create-once-no-delete
filesystem.

echo 42 > the_answr.txt

Oh, darn it...

ln -s the_answr.txt the_answer.txt

Now both names still point to the content "42\n".  The first SHA
would be over ["42\n", "the_answr.txt"] and the second SHA over
["42\n", "the_answer.txt"].

But I get the distinct feeling of beating a poor dead horse here,
so I'll shut up.
