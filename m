From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH v2] send-email: add --confirm option
Date: Mon, 02 Mar 2009 18:23:10 +0900
Message-ID: <20090302182310.6117@nanako3.lavabit.com>
References: <7vhc2d8vjk.fsf@gitster.siamese.dyndns.org>
 <1235924234-16923-1-git-send-email-jaysoffian@gmail.com>
 <7d1d9c250903010909h7d92f165oc703a05e819671a4@mail.gmail.com>
 <76718490903010949h7b64eb97ob567101fbc7e4cd1@mail.gmail.com>
 <20090302172401.6117@nanako3.lavabit.com>
 <7v7i385meo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 10:25:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Le4Or-0006us-Ia
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 10:25:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756196AbZCBJX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 04:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755541AbZCBJX5
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 04:23:57 -0500
Received: from karen.lavabit.com ([72.249.41.33]:55597 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755465AbZCBJX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 04:23:56 -0500
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 41CF511B7E7;
	Mon,  2 Mar 2009 03:23:54 -0600 (CST)
Received: from 7933.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id G48B3AUPBG3O; Mon, 02 Mar 2009 03:23:54 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=1pJSJXOQd4rbMww4eshNM7+lMUphlhAkVGQ3WDeZlag+e5+G+QE+LWcfhL1n8YjMIKvMir/JHktxhpj1myfxJdP+j+V9ggSzosDHqwWrIH1GAG/uD2E0k8YnL+8l0SS5nvZQKWTaf5KkclMnN8B6yU8ZkRS02E0Kq30QlD5VP0I=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7v7i385meo.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111922>

Quoting Junio C Hamano <gitster@pobox.com>:

> By the way, how are you researching these old discussions?  Do you have
> a huge list of bookmarks?

There weren't that many threads that became the turning points for the project; the list need not to be huge even if somebody were to keep one.

But I don't keep such a list; I just ask the gmane archive or google.

> And the most scary part of all is that you cannot try both.  We now know
> that for 1.6.0 transition people _claimed_ that they would have liked
> louder deprecation period than the way 1.6.0 transition was handled, but
> that is not (and cannot be) backed by real world experience. Nobody tried
> versions of git that warned loudly about the upcoming change every time he
> typed "git-commit" to see if the louder deprecation period was really
> preferrable.
>
> We are taking that route for 1.7.0 to warn very loudly about pushing into
> the currently checked-out branch in 1.6.2 and onwards.  We may now find
> out that people hate a loud deprecation period.  Then what?

Then you get flamed.

But isn't that what the maintainer is there for? To take blame on behalf of others, so that contributors can propose what they genuinely believe improvements without fearing what the end users would say?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
