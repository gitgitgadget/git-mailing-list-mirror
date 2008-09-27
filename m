From: "Leo Razoumov" <slonik.az@gmail.com>
Subject: Re: status letters consistency in log and ls-files
Date: Fri, 26 Sep 2008 23:20:03 -0400
Message-ID: <ee2a733e0809262020l318b0ac3v560400d95a5ba2b7@mail.gmail.com>
References: <ee2a733e0809261128h4c50d27bq3942bd1b3b66d3ee@mail.gmail.com>
	 <20080926224546.GB24817@coredump.intra.peff.net>
	 <ee2a733e0809261624y72dcfb8fw7910feb2542f501c@mail.gmail.com>
	 <20080927002949.GA25586@coredump.intra.peff.net>
Reply-To: SLONIK.AZ@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Jeff King" <peff@peff.net>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 27 05:21:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjQMt-0000wY-S6
	for gcvg-git-2@gmane.org; Sat, 27 Sep 2008 05:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658AbYI0DUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 23:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751700AbYI0DUG
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 23:20:06 -0400
Received: from fk-out-0910.google.com ([209.85.128.190]:19997 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611AbYI0DUF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 23:20:05 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1171623fkq.5
        for <git@vger.kernel.org>; Fri, 26 Sep 2008 20:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=+H3DpwqxFUdveKN0Z/T6R8sHBGMJJ2aMgpJylW7Md0Y=;
        b=qsZkCkAsw8+r10pARehLsxA05oWdfQ+T3MruaxvA/HHCpAfbyopf9w806EENhVxVXy
         ZuU+DjSuc8sIqA3+42/Q7qBoh0AFYOmWlTDtndKbrB7EDfbDJ/NON6T+wrFKX/shFMzg
         em4hN4tS0+1TpBleTVRTIKwondtH0KvqmPxak=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=W+dSdWHBI+X1d6YngBO/63V8pXAQgZfYsxxpUB/ZVm8i/TDsyvWQhZk9uYx9m4kDjx
         DFNN6yIm9IG0gkl9slljjvlxz1iSWOTm8AcNUIycgwMKFmiu2eBd0AnsP2w5zAw438Q+
         YBbn+IkB0CsOZCYbotORWkioEEdtsQwJdwvFI=
Received: by 10.187.201.15 with SMTP id d15mr319431faq.32.1222485603481;
        Fri, 26 Sep 2008 20:20:03 -0700 (PDT)
Received: by 10.187.162.17 with HTTP; Fri, 26 Sep 2008 20:20:03 -0700 (PDT)
In-Reply-To: <20080927002949.GA25586@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96899>

On 9/26/08, Jeff King <peff@peff.net> wrote:
> On Fri, Sep 26, 2008 at 07:24:11PM -0400, Leo Razoumov wrote:
>
>  > Another script takes output of
>  >   git ls-files -v -c -d -m -o -k
>  > and for each file pulls together all the file status letters in one record.
>
>
> OK. I was thinking I could suggest just using "git diff" here instead.
>  E.g.,:
>
>   git diff --name-status
>
>  will show you the modified and deleted files. But since you are using
>  "-c" to show _all_ cached files, I think only ls-files can do that
>  (since diff is, obviously, about files with differences).
>
>  So I'm not sure there is a straight-forward solution short of
>  translating the status codes.
>
>  -Peff

Moreover, git diff would not show untracked files while git ls-files
will include them and label '?'

--Leo--
