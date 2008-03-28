From: "Alex Bennee" <kernel-hacker@bennee.com>
Subject: Re: Truncating and cleaning a imported git repositary to make it more usable
Date: Fri, 28 Mar 2008 16:03:18 +0000
Message-ID: <b2cdc9f30803280903w4a6e3a6l9e33fd188af9995a@mail.gmail.com>
References: <1206707716.9819.15.camel@malory>
	 <32541b130803280550u2ed23b5auc84bf935d5344e84@mail.gmail.com>
	 <b2cdc9f30803280852y4f160bb2tda1e688ddf7213e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 17:04:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfH3l-0001qh-Q8
	for gcvg-git-2@gmane.org; Fri, 28 Mar 2008 17:04:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752742AbYC1QDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2008 12:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753774AbYC1QDV
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Mar 2008 12:03:21 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:45619 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbYC1QDU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2008 12:03:20 -0400
Received: by wr-out-0506.google.com with SMTP id c48so248601wra.1
        for <git@vger.kernel.org>; Fri, 28 Mar 2008 09:03:19 -0700 (PDT)
Received: by 10.140.203.15 with SMTP id a15mr1506576rvg.212.1206720198791;
        Fri, 28 Mar 2008 09:03:18 -0700 (PDT)
Received: by 10.140.161.13 with HTTP; Fri, 28 Mar 2008 09:03:18 -0700 (PDT)
In-Reply-To: <b2cdc9f30803280852y4f160bb2tda1e688ddf7213e7@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 656ac372d651483d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78423>

On Fri, Mar 28, 2008 at 3:52 PM, Alex Bennee <kernel-hacker@bennee.com> wrote:

>  ajb@pitcairn:/export/git/fresh.git$ git-filter-branch --tree-filter
>  'rm -rf big_dira big_dirb' dev-branch
>  warning: refname 'dev-branch' is ambiguous.
>  Which ref do you want to rewrite?

Ignore me. Not sure why but:

git-checkout dev-branch
git-filter-branch --tree-filter  'rm -rf big_dira big_dirb' HEAD

works


-- 
Alex, homepage: http://www.bennee.com/~alex/
