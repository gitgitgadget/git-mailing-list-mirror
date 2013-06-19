From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH 2/4] glossary: define committish (a.k.a. commit-ish)
Date: Wed, 19 Jun 2013 11:31:00 -0400
Message-ID: <51C1CEB4.60206@bbn.com>
References: <1371607780-2966-1-git-send-email-rhansen@bbn.com> <1371607780-2966-3-git-send-email-rhansen@bbn.com> <CALkWK0mo2SG+Eh1Qmy58Xo-taG_EGEj9RSx65EYhvs2CLK9dUA@mail.gmail.com> <51C135BE.4030506@bbn.com> <CALkWK0=-PT=QD5enFQhrDZN03xCAttZKtjtT8rE7n4QynT+Ndg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 17:31:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpKLn-0000Yf-E3
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 17:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934022Ab3FSPbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 11:31:06 -0400
Received: from smtp.bbn.com ([128.33.0.80]:44195 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934566Ab3FSPbF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 11:31:05 -0400
Received: from socket.bbn.com ([192.1.120.102]:40584)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1UpKLe-0006iA-0J; Wed, 19 Jun 2013 11:31:02 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 841453FF5E
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <CALkWK0=-PT=QD5enFQhrDZN03xCAttZKtjtT8rE7n4QynT+Ndg@mail.gmail.com>
X-Enigmail-Version: 1.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228395>

On 2013-06-19 01:56, Ramkumar Ramachandra wrote:
> From gitglossary(7):
> 
> ref
>     A 40-byte hex representation of a SHA-1 or a name that denotes a
>     particular object. They may be stored in a file under $GIT_DIR/refs/
>     directory, or in the $GIT_DIR/packed-refs file.
> 
> Do master~3 and :/foomery qualify as refs?

Yes; they are names that denote a particular object.

> 
>>> Look at the other forms in gitrevisions(7); master:quuxery,
>>> master^{tree} are notable exceptions.
>>
>> gitrevisions(7) says that master:quuxery is a ref pointing to a blob or
>> tree, so it is not a committish.  However, if quuxery is a submodule, I
>> would expect master:quuxery to point to a commit object and thus be a
>> committish.  So perhaps the <rev>:<path> description in gitrevisions(7)
>> should be updated to accommodate submodules.
> 
> When quuxery is a submodule, master:quuxery refers to a commit object
> that does not exist in the parent repository.  I don't know what we
> gain by documenting a comittish you can't even `show`.

Fair point.

-Richard
