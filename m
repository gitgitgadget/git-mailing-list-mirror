From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH 1/1] --color and --no-color git-log options don't need diffs to be computed.
Date: Sat, 29 Sep 2007 15:07:39 +0200
Message-ID: <e5bfff550709290607y6704db5dgdddc4a3db30f067d@mail.gmail.com>
References: <e5bfff550709290429n291968f2md8068a945ff7a79e@mail.gmail.com>
	 <20070929123724.01BB045EC@madism.org> <85ve9t8wh7.fsf@lola.goethe.zz>
	 <20070929125633.GC32142@artemis.corp>
	 <e5bfff550709290606k71cc3c50h5ea42441223dede@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Pierre Habouzit" <madcoder@debian.org>,
	"David Kastrup" <dak@gnu.org>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 29 15:07:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ibc2t-0003st-MZ
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 15:07:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755907AbXI2NHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 09:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754920AbXI2NHl
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 09:07:41 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:65357 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754697AbXI2NHk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 09:07:40 -0400
Received: by wr-out-0506.google.com with SMTP id 36so1522460wra
        for <git@vger.kernel.org>; Sat, 29 Sep 2007 06:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=NNgkIg8by1B+AG1MJzYxSCYgGjIX7gYhfNxiBKppazk=;
        b=U8zZGGDdVg/LJpxCQrYx66Chk414Q3heeWy5u11PaQOO+borEHVnjRmNP7BR49Ge9e+IO2DDV1fpH2fq5IuNco1Zkevcr4xh5FWFKMsWhtxUq1uUmP8S1HfK9GnkYAaRgXlPNCWugbw7Q1rbMG2uWRWfNuyuc0yIqQgwsZSU1Ik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IMROGjqfUvUng2iSvlHCxpUb9V1mMlnU/5F72wshej/Kj5XQFhN2f3r21vHRL967UEb0ilaR6wksg1bvA0ZoPzjU5vD2fMNXvRB4hfzqAYct8aT6p8I9ITo5ylLmy9Yu/PPFKKcYmjpHGhi18DDlLt8DFEHvvHjT/btn9TjiWYc=
Received: by 10.90.96.7 with SMTP id t7mr7199795agb.1191071259418;
        Sat, 29 Sep 2007 06:07:39 -0700 (PDT)
Received: by 10.140.185.19 with HTTP; Sat, 29 Sep 2007 06:07:39 -0700 (PDT)
In-Reply-To: <e5bfff550709290606k71cc3c50h5ea42441223dede@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59469>

On 9/29/07, Marco Costalba <mcostalba@gmail.com> wrote:
>
> Perhaps also with an 'if' before to avoid clearing an already set
> revs->diff if the passed option does not match any of the three.
>

Please discard, I mistakenly pressed 'send' button.
